set ts=2 sw=2 sts=2 et
set textwidth=79
if has("python")
  py vindect.detect(verbose=-1)
elseif has("python3")
  py3 vindect.detect(verbose=-1)
endif
