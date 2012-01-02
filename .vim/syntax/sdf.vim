"
" Vim syntax file for SDF language
" Language: SDF
" Author:   Albert Hofkamp (a.t.hofkamp@tue.nl)
" Version:  1.2 (dd 20040227)
" 
" 1.2 (20040227)
" - Updated to reflect changes in the 1.5 release
"   (mostly copied from Hayco de Jong).
"
" 1.1 (20031013)
" - Added comment strings
"
" 1.0 (+/- 20030526)
" - Rewrite from scratch
"
" 0.2 (dd 20030513)
" - Added contains=None to sdfString
"
" 0.1 (dd 20030507)
" - First version
" - Known bug:
"   The approach of beginning with imports/exports/hiddens is wrong, these
"   keywords should be ignored. Syntax coloring should be based on the
"   lower-level keywords only.

" syntax.txt, line 1932	    writing your own syntax file
" syntax.txt, line 200	    naming conventions for groups
" syntax.txt, line 2963	    highlighting
" :help syntax
"

" Check whether syntax already loaded (section 44.12 manual)
if version < 600
   syntax clear
elseif exists("b:current_syntax")
   finish
endif

setlocal commentstring="\%\%%s\n"
setlocal comments=:%%

"syntax clear

syntax case match
syntax sync fromstart
setlocal iskeyword+=-

" Scoping keywords
syntax keyword	sdfScoping exports hiddens

" module <identifier>
syntax keyword	sdfModule	module nextgroup=sdfModname skipwhite
syntax match	sdfModname	"[-A-Za-z0-9\/\[\]][-A-Za-z0-9\/\[\]]*" contained

syntax match	sdfSortIden	"[A-Z][-A-Za-z0-9]*" contained

" context-free XXXXX regions
syntax keyword 	sdfCF		context-free nextgroup=sdfCFSyntax,sdfCFRestricts,sdfCFPrios,sdfCFStartsymbols skipwhite
syntax region	sdfCFSyntax	start=/syntax/ end=/\(context-free\)\@=/ end=/\(aliases\)\@=/ end=/\(exports\)\@=/ end=/\(hiddens\)\@=/ end=/\(imports\)\@=/ end=/\(lexical\)\@=/ end=/\(sorts\)\@=/ end=/\(variables\)\@=/ contains=sdfSyntaxKW,sdfSortIden,sdfSyntaxError,sdfSyntaxOperator,sdfComment,sdfString contained
syntax region	sdfCFRestricts	start=/restrictions/ end=/\(context-free\)\@=/ end=/\(aliases\)\@=/ end=/\(exports\)\@=/ end=/\(hiddens\)\@=/ end=/\(imports\)\@=/ end=/\(lexical\)\@=/ end=/\(sorts\)\@=/ end=/\(variables\)\@=/ contains=sdfRestrictsKW,sdfSortIden,sdfRestrictOperator,sdfComment,sdfString contained
syntax region	sdfCFStartsymbols start=/start-symbols/ end=/\(context-free\)\@=/ end=/\(aliases\)\@=/ end=/\(exports\)\@=/ end=/\(hiddens\)\@=/ end=/\(imports\)\@=/ end=/\(lexical\)\@=/ end=/\(sorts\)\@=/ end=/\(variables\)\@=/ contains=sdfStartsymbolsKW,sdfSortIden,sdfSyntaxOperator,sdfSyntaxError,sdfComment,sdfString contained
syntax region	sdfCFPrios	start=/priorities/ end=/\(context-free\)\@=/ end=/\(aliases\)\@=/ end=/\(exports\)\@=/ end=/\(hiddens\)\@=/ end=/\(imports\)\@=/ end=/\(lexical\)\@=/ end=/\(sorts\)\@=/ end=/\(variables\)\@=/ contains=sdfPriosKW,sdfSortIden,sdfSyntaxOperator,sdfSyntaxError,sdfComment,sdfString contained

" lexical XXXXX regions
syntax keyword 	sdfLex		lexical nextgroup=sdfLexSyntax,sdfLexRestricts skipwhite
syntax region	sdfLexSyntax	start=/syntax/ end=/\(context-free\)\@=/ end=/\(aliases\)\@=/ end=/\(exports\)\@=/ end=/\(hiddens\)\@=/ end=/\(imports\)\@=/ end=/\(lexical\)\@=/ end=/\(sorts\)\@=/ end=/\(variables\)\@=/ contains=sdfSyntaxKW,sdfSortIden,sdfSyntaxOperator,sdfSyntaxError,sdfComment,sdfString contained
syntax region	sdfLexRestricts	start=/restrictions/ end=/\(context-free\)\@=/ end=/\(aliases\)\@=/ end=/\(exports\)\@=/ end=/\(hiddens\)\@=/ end=/\(imports\)\@=/ end=/\(lexical\)\@=/ end=/\(sorts\)\@=/ end=/\(variables\)\@=/ contains=sdfRestrictsKW,sdfSortIden,sdfRestrictOperator,sdfComment,sdfString contained

syntax keyword	sdfSyntaxKW	syntax contained
syntax keyword	sdfStartsymbolsKW	start-symbols contained
syntax keyword	sdfRestrictsKW	restrictions contained
syntax keyword	sdfPriosKW	priorities contained


syntax region	sdfImport	start=/imports/ end=/\(context-free\)\@=/ end=/\(aliases\)\@=/ end=/\(exports\)\@=/ end=/\(hiddens\)\@=/ end=/\(imports\)\@=/ end=/\(lexical\)\@=/ end=/\(sorts\)\@=/ end=/\(variables\)\@=/ contains=sdfImportKW,sdfSortIden,sdfComment
syntax keyword	sdfImportKW imports contained

syntax region	sdfSorts	start=/sorts/ end=/\(context-free\)\@=/ end=/\(aliases\)\@=/ end=/\(exports\)\@=/ end=/\(hiddens\)\@=/ end=/\(imports\)\@=/ end=/\(lexical\)\@=/ end=/\(sorts\)\@=/ end=/\(variables\)\@=/ contains=sdfSortsKW,sdfSortIden,sdfComment
syntax keyword	sdfSortsKW sorts contained

syntax region	sdfVariables	start=/variables/ end=/\(context-free\)\@=/ end=/\(aliases\)\@=/ end=/\(exports\)\@=/ end=/\(hiddens\)\@=/ end=/\(imports\)\@=/ end=/\(lexical\)\@=/ end=/\(sorts\)\@=/ end=/\(variables\)\@=/ contains=sdfVariablesKW,sdfSortIden,sdfSyntaxOperator,sdfSyntaxError,sdfComment,sdfString
syntax keyword	sdfVariablesKW variables contained

syntax region	sdfAliases	start=/aliases/ end=/\(context-free\)\@=/ end=/\(aliases\)\@=/ end=/\(exports\)\@=/ end=/\(hiddens\)\@=/ end=/\(imports\)\@=/ end=/\(lexical\)\@=/ end=/\(sorts\)\@=/ end=/\(variables\)\@=/ contains=sdfAliasesKW,sdfSyntaxOperator,sdfSyntaxError,sdfSortIden,sdfComment
syntax keyword	sdfAliasesKW aliases contained

" %% comment, % comment %
syntax region	sdfComment	start="%%" end="\n" contains=sdfTodo
syntax match	sdfComment	"%[^%][^%]*%" contains=None
syntax keyword 	sdfTodo 	TODO contained
"
" strings (between "'s with \. escape
syntax match	sdfString	"\"[^\\"]*\(\\.[^\\"]*\)*\"" contained contains=None

"" various operators
syntax match	sdfSyntaxOperator	"\->" contained display
syntax match	sdfSyntaxError		"#" contained display
syntax match	sdfSyntaxOperator	"(" contained display
syntax match	sdfSyntaxOperator	")" contained display
syntax match	sdfSyntaxOperator	"<" contained display
syntax match	sdfSyntaxOperator	">" contained display
syntax match	sdfSyntaxOperator	"," contained display
syntax match	sdfSyntaxOperator	"\*" contained display
syntax match	sdfSyntaxOperator	"+" contained display
syntax match	sdfSyntaxOperator	"?" contained display
syntax match	sdfRestrictOperator	"\-/\-" contained display
"syntax match	sdfOperator	"\[\[" contained display
"syntax match	sdfOperator	"\]\]" contained display

syntax match	sdfSyntaxOperator	"{" contained display
" the }, }?, }*, }+, }n*, and }n+
syntax match	sdfSyntaxOperator	"}\(?\|\*\|+\|[0-9][0-9]*\(\*\|+\)\)\?" contained display
"syntax match	sdfOperator	"\[\|{" contained
"" and the ], ]?, ]*, ]+, ]n*, ]n+, }, }?, }*, }+, }n*, and }n+
"syntax match	sdfOperator	"\(\]\|}\)\(?\|\*\|+\|[0-9][0-9]*\(\*\|+\)\)\?" contained

" Link matches to colours
" See also section 44.12 manual
if version >= 508 || !exists("did_c_syn_inits")
    if version < 508
        let did_c_syn_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi def link <args>
    endif

    HiLink sdfModule		Statement
    HiLink sdfModname		Identifier
    HiLink sdfScoping		StorageClass
    HiLink sdfString		String
"    HiLink sdfFile		Include
    HiLink sdfComment		Comment
    HiLink sdfTodo		Todo
"    HiLink sdfDefinitions	Identifier
    HiLink sdfSyntaxOperator	Operator
    HiLink sdfSyntaxError	Error
    HiLink sdfRestrictOperator	Operator
    HiLink sdfImport    	Include
    HiLink sdfImportKW		Keyword
"    HiLink sdfVariables    	Identifier
    HiLink sdfVariablesKW	Keyword
"    HiLink sdfSorts    		Type
    HiLink sdfSortsKW		Keyword
"    HiLink sdfAliases		Type
    HiLink sdfAliasesKW		Keyword

    HiLink sdfSortIden		Identifier

    HiLink sdfCF		Keyword
    HiLink sdfLex		Keyword
    HiLink sdfSyntaxKW		Keyword
    HiLink sdfStartsymbolsKW	Keyword
    HiLink sdfRestrictsKW	Keyword
    HiLink sdfPriosKW		Keyword

    delcommand HiLink
endif

