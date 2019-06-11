if has("python")
  py vindect.detect(verbose=-1)
elseif has("python3")
  py3 vindect.detect(verbose=-1)
endif
set textwidth=79
let b:ale_linters = ['flake8', 'mypy', 'pylint', 'pyflakes']
