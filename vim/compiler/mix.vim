if exists("current_compiler")
  finish
endif
let current_compiler = "mix"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif
CompilerSet errorformat=
      \%A%t%*[^:]:\ %m,
      \%C%f:%l:\ %m,
      \%C%f:%l,%Z,
      \**\ (%\\w%\\+)\ %f:%l:\ %m,
      \%f:%l:\ %m,
      \%f:%l:%c:\ %m,
CompilerSet makeprg=mix
