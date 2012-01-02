" CVSconflict: a vimdiff-based way to view and edit cvs-conflict containing files
" Author:	Charles E. Campbell, Jr.
" Date:		Sep 28, 2005
" Version:	1
" Copyright:    Copyright (C) 2005 Charles E. Campbell, Jr. {{{1
"               Permission is hereby granted to use and distribute this code,
"               with or without modifications, provided that this copyright
"               notice is copied with it. Like anything else that's free,
"               CVSconflict.vim is provided *as is* and comes with no warranty
"               of any kind, either expressed or implied. By using this
"               plugin, you agree that in no event will the copyright
"               holder be liable for any damages resulting from the use
"               of this software.
" GetLatestVimScripts: 1370 1 :AutoInstall: CVSconflict.vim

" ---------------------------------------------------------------------
" Load Once: {{{1
if exists("g:loaded_CVSconflict") || &cp
 finish
endif
let g:loaded_CVSconflict = "v1"
let s:keepcpo            = &cpo
set cpo&vim

" ---------------------------------------------------------------------
"  Public Interface:	{{{1
com! CVSconflict	call <SID>CVSconflict()

" ---------------------------------------------------------------------
" CVSconflict: this function splits the current, presumably {{{1
"              cvs-conflict'ed file into two versions, and then applies
"              vimdiff.  The original file is left untouched.
fun! s:CVSconflict()
  "call Dfunc("CVSconflict()")

  " sanity check
  if !search('^>>>>>>>','nw')
   echo "***CVSconflict*** no cvs-conflicts present"
   "call Dret("CVSconflict")
   return
  endif

  " construct A and B files
  let curfile = expand("%")
  if curfile =~ '\.'
   let fileA= substitute(curfile,'\.[^.]\+$','A&','')
   let fileB= substitute(curfile,'\.[^.]\+$','B&','')
  else
   let fileA= curfile."A"
   let fileB= curfile."B"
  endif

  " check if fileA or fileB already exists (as a file).  Although CVSconflict
  " doesn't write these files, I don't want to have a user inadvertently
  " writing over such a file.
  if filereadable(fileA)
   echohl WarningMsg | echo "***CVSconflict*** ".fileA." already exists!"
   "call Dret("CVSconflict")
   return
  endif
  if filereadable(fileB)
   echohl WarningMsg | echo "***CVSconflict*** ".fileB." already exists!"
   "call Dret("CVSconflict")
   return
  endif

  " make two windows with separate copies of curfile, named fileA and fileB
  silent vsplit
  let ft=&ft
  exe "silent file ".fileA
  wincmd l
  enew
  exe "r ".curfile
  0d
  exe "silent file ".fileB
  let &ft=ft
  wincmd h

  " fileA: remove
  "   =======
  "   ...
  "   >>>>>>>
  " sections, and remove the <<<<<<< line
  silent g/^=======/.;/^>>>>>>>/d
  silent g/^<<<<<<</d
  set nomod

  " fileB: remove
  "   >>>>>>>
  "   ...
  "   =======
  " sections, and remove the <<<<<<< line
  wincmd l
  silent g/^<<<<<<</.;/^=======/d
  silent g/^>>>>>>>/d
  set nomod

  " set up vimdiff'ing
  diffthis
  wincmd h
  diffthis

  "call Dret("CVSconflict")
endfun

" ---------------------------------------------------------------------
"  Restore Cpo: {{{1
let &cpo= s:keepcpo
unlet s:keepcpo
" ---------------------------------------------------------------------
"  Modelines: {{{1
" vim: ts=4 fdm=marker
