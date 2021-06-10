# Inspired by Bouke van der Bijl:
# https://github.com/bouk/b/blob/master/default.nix
{ lib ? (import <nixpkgs> { }).lib, stdenv ? (import <nixpkgs> { }).stdenv }:

# https://status.nixos.org
with import
  (fetchTarball "https://github.com/NixOS/nixpkgs/archive/21.05.tar.gz") { };

let
  comma = pkgs.callPackage ./nixpkgs/comma.nix { };
  setrb = pkgs.callPackage ./nixpkgs/setrb.nix { };
  bin = pkgs.runCommand "teoljungberg-dotfiles-bin" { } ''
    mkdir $out
    ln -sf ${./bin} $out/bin
  '';
  env = pkgs.buildEnv {
    name = "teoljungberg-dotfiles-env";
    paths = paths;
    extraOutputsToInstall = [ "bin" "dev" "lib" ];
  };
  cpathEnv = builtins.getEnv "CPATH";
  libraryPathEnv = builtins.getEnv "LIBRARY_PATH";
  pathEnv = builtins.getEnv "PATH";

  tmux = (let
    tmuxConfig = pkgs.writeText "tmux.conf" ''
      ${builtins.readFile ./tmux.conf}
    '';
  in pkgs.symlinkJoin {
    name = "tmux";
    paths = [ pkgs.tmux ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      bin="$(readlink -v --canonicalize-existing "$out/bin/tmux")"
      rm "$out/bin/tmux"
      makeWrapper $bin "$out/bin/tmux" --add-flags "-f ${tmuxConfig}"
    '';
  });

  git = (let
    gitConfig = pkgs.writeTextDir "git/config" ''
      ${builtins.readFile ./gitconfig}
    '';
  in pkgs.symlinkJoin {
    name = "git";
    paths = [ pkgs.git ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      bin="$(readlink -v --canonicalize-existing "$out/bin/git")"
      rm "$out/bin/git"
      makeWrapper $bin "$out/bin/git" --set "XDG_CONFIG_HOME" "${gitConfig}"
    '';
  });

  vim = (pkgs.vim_configurable.customize {
    name = "vim";
    vimrcConfig.customRC = builtins.readFile ./vimrc;
    vimrcConfig.packages.bundle = with pkgs.vimPlugins; {
      start = [
        ale
        fzf-vim
        splitjoin-vim
        vim-abolish
        vim-commentary
        vim-dispatch
        vim-endwise
        vim-eunuch
        vim-exchange
        vim-fugitive
        vim-fugitive
        vim-git
        vim-markdown
        vim-nix
        vim-projectionist
        vim-rails
        vim-repeat
        vim-rhubarb
        vim-ruby
        vim-scriptease
        vim-sleuth
        vim-surround
        vim-unimpaired
        vim-vinegar
        (pkgs.vimUtils.buildVimPluginFrom2Nix {
          pname = "vim-bundler";
          version = "2.1";
          src = pkgs.fetchFromGitHub {
            owner = "tpope";
            repo = "vim-bundler";
            rev = "v2.1";
            sha256 = "1050qnqdkgp1j1jj1a8g5b8klyb7s4gi08hhz529zm8fsdmzj1ca";
          };
        })
        (pkgs.vimUtils.buildVimPluginFrom2Nix {
          pname = "vim-rake";
          version = "2021-06-07";
          src = pkgs.fetchFromGitHub {
            owner = "tpope";
            repo = "vim-rake";
            rev = "34ece18ac8f2d3641473c3f834275c2c1e072977";
            sha256 = "1ff0na01mqm2dbgncrycr965sbifh6gd2wj1vv42vfgncz8l331a";
          };
        })
        (pkgs.vimUtils.buildVimPluginFrom2Nix {
          pname = "vim-mkdir";
          version = "2021-06-07";
          src = pkgs.fetchFromGitHub {
            owner = "pbrisbin";
            repo = "vim-mkdir";
            rev = "f0ba7a7dc190a0cedf1d827958c99f3718109cf0";
            sha256 = "0kp2n1wfmlcxcwpqp63gmzs8ihdhd5qcncc4dwycwr1sljklarnw";
          };
        })
        (pkgs.vimUtils.buildVimPluginFrom2Nix {
          pname = "vim-whitescale";
          version = "2021-06-07";
          src = pkgs.fetchFromGitHub {
            owner = "teoljungberg";
            repo = "vim-whitescale";
            rev = "0e5e8370c8851246e02729024a96b7ab6453fe00";
            sha256 = "1m3ydzfgxkq0rmzl44prgki4bwg0z8lnlcligriqj62gm6q2g2a1";
          };
        })
      ];
    };
  });

  zsh = (let
    zshenv = pkgs.writeText ".zshenv" ''
      ${builtins.readFile ./zshenv}
      CPATH=${
        lib.makeSearchPathOutput "dev" "include" [ pkgs.libxml2 pkgs.libxslt ]
      }:${cpathEnv}
      LIBRARY_PATH=${
        lib.makeLibraryPath [ pkgs.libxml2 pkgs.libxslt ]
      }:${libraryPathEnv}
      PATH=$HOME/.gem/ruby/${ruby.version}/bin:${
        lib.makeBinPath [ env ]
      }:${pathEnv}
    '';
    zshrc = pkgs.writeText ".zshrc" ''
      ${builtins.readFile ./zshrc}
    '';
    zdotdir = pkgs.buildEnv {
      name = "teoljungberg-zdotdir";
      paths = [
        (pkgs.runCommand "zdotdir" { } ''
          mkdir -p $out/zdotdir
          cp ${zshenv} $out/zdotdir/.zshenv
          cp ${zshrc} $out/zdotdir/.zshrc
        '')
      ];
    };
  in pkgs.symlinkJoin {
    name = "zsh";
    paths = [ pkgs.zsh ];
    passthru = { shellPath = pkgs.zsh.shellPath; };
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      bin="$(readlink -v --canonicalize-existing "$out/bin/zsh")"
      rm "$out/bin/zsh"
      makeWrapper $bin "$out/bin/zsh" --set "ZDOTDIR" "${zdotdir}/zdotdir"
    '';
  });

  ruby = pkgs.ruby_3_0;
  paths = [
    bin
    comma
    git
    pkgs.autoconf
    pkgs.automake
    pkgs.coreutils-prefixed
    pkgs.fzf
    pkgs.gitAndTools.gh
    pkgs.gitAndTools.hub
    pkgs.gnupg
    pkgs.heroku
    pkgs.jq
    pkgs.libxml2
    pkgs.libxslt
    pkgs.nixfmt
    pkgs.openssl.dev
    pkgs.pgformatter
    pkgs.pkg-config
    pkgs.rcm
    pkgs.readline.dev
    pkgs.ripgrep
    pkgs.shellcheck
    pkgs.universal-ctags
    ruby
    setrb
    tmux
    vim
  ];
in if pkgs.lib.inNixShell then
  pkgs.mkShell { shellHook = "${zsh}${zsh.shellPath}; exit $?"; }
else
  zsh
