" Vim syntax file for ASF language
" Language: ASF
" Author:   Albert Hofkamp (a.t.hofkamp@tue.nl)
" Version:  0.1 (dd 20030701)
" 
" 0.1 (dd 20030507)
" - First version
"   Very incomplete
"

" Check whether syntax already loaded (section 44.12 manual)
if version < 600
   syntax clear
elseif exists("b:current_syntax")
   finish
endif

"syntax clear

syntax case match
"syntax sync fromstart
setlocal iskeyword+=-

" Scoping keywords
syntax keyword	asfEquations equations
syntax keyword	asfTests     tests

syntax match	asfLabel	"^[ \t]\+\[[-A-Za-z0-9]*\]"

syntax keyword  asfConclusion when
syntax match	asfConclusion "====*"

" %% comment, % comment %
syntax region	asfComment	start="%%" end="\n" contains=None
syntax match	asfComment	"%[^%][^%]*%" contains=None

" // comment
syntax region	asfComment	start="//" end="\n" contains=None

" Link matches to colours
" See also section 44.12 manual
if version >= 508 || !exists("did_c_syn_inits")
    if version < 508
        let did_c_syn_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi def link <args>
    endif

    HiLink asfEquations		Keyword
    HiLink asfTests		Keyword
    HiLink asfConclusion	Keyword
    HiLink asfLabel		Label
    HiLink asfComment		Comment

    delcommand HiLink
endif
