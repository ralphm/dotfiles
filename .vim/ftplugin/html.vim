
if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1 

imap <buffer> ,pp <lt>p></p><esc>bba

" header and setup info
"imap <buffer> ,dtx <?xml version="1.0"?><CR><!DOCTYPE article PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"<CR>"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd">
"imap <buffer> ,dts <!DOCTYPE BOOK PUBLIC "-//OASIS//DTD DocBook V4.1//EN">
"imap <buffer> ,bk <book><CR><bookinfo><CR><title></title><CR></bookinfo><CR><CR></book><esc>kkk$bba
"imap <buffer> ,ar <article><CR><articleinfo><CR><title></title><CR></articleinfo><CR><CR></article><esc>kkk$bba

" character formatting
"imap <buffer> ,em <emphasis></emphasis><esc>bba
"imap <buffer> ,es <emphasis role="strong"></emphasis><esc>bbla

" links
"imap <buffer> ,ul <ulink url=""></ulink><esc>bb3la
"imap <buffer> ,lk <link linkend=""></link><esc>bb3la

" lists
imap <buffer> ,ul <ul><CR><li></li><CR></ul><ESC>k$bba
imap <buffer> ,li <li></li><ESC>bba
" note that ',l2' was created solely to fit into ,il and ,ol
"imap <buffer> ,li <listitem><para></para></listitem><esc>bbbba
"imap <buffer> ,l2 <listitem><para></para></listitem>
"imap <buffer> ,l3 <listitem><CR><para><CR></para><CR></listitem><esc>kk$a
"imap <buffer> ,il <itemizedlist><CR>,l2<CR><BS><BS></itemizedlist><esc>k$bbbba
"imap <buffer> ,ol <orderedlist><CR>,l2<CR></orderedlist><esc>kkk$a
"imap <buffer> ,ve ,v2<esc>kk$bba
"imap <buffer> ,v2 <varlistentry><CR><term></term><CR>,l2<CR><BS><BS></varlistentry>
"imap <buffer> ,vl <variablelist><CR><title></title><CR>,v2<CR><BS><BS></variablelist><esc>kkkkk$bba
"imap <buffer> ,ge <glossentry><CR><glossterm></glossterm><CR><glossdef><para></para></glossdef><CR><BS><BS></glossentry><esc>kk$bba

" sections
" I put a <para> in here so that onsgmls will treat it as valid DB even with 
" nothing entered into the text.
" Note that I also assign an 'id' to each section so that openjade generates
" files with those ids as names.
"imap <buffer> ,s1 <sect1 id=""><CR><title></title><CR><para><CR></para><CR></sect1><esc>kkk$bba
"imap <buffer> ,s2 <sect2 id=""><CR><title></title><CR><para><CR></para><CR></sect2><esc>kkk$bba
"imap <buffer> ,s3 <sect3 id=""><CR><title></title><CR><para><CR></para><CR></sect3><esc>kkk$bba
"imap <buffer> ,se <section><CR><title></title><CR><CR><para></para><CR><CR><BS><BS></section><esc>kkkk$bba
"imap <buffer> ,ch <chapter id=""><CR><title></title><CR><CR><para></para><CR><CR><BS><BS></chapter><esc>kkkk$bba

" images
" My mediaobject has two imagedata entries - 1 for PDF and 1 for PNG
"imap <buffer> ,img <imageobject><CR><imagedata fileref="" format=""/><CR></imageobject>
"imap <buffer> ,to <textobject><CR><phrase></phrase><CR></textobject>
"imap <buffer> ,mo <mediaobject><CR>,img<esc>k$hhiPDF<esc>j$a<CR>,img<esc>k$hhiPNG<esc>j$a<CR>,to<CR></mediaobject>

"tables
"imap <buffer> ,en <entry></entry><esc>bba
"imap <buffer> ,tb <table><CR><title></title><CR><tgroup cols=2><CR><tbody><CR></tbody><CR></tgroup><CR></table><esc>kk
"imap <buffer> ,ro <row><CR><entry></entry><CR></row><esc>k$bba

" Q and A sets
"imap <buffer> ,qq <question><CR><para></para><CR></question><esc>k$bba
"imap <buffer> ,qa <answer><CR><para></para><CR></answer><esc>k$bba
"imap <buffer> ,qe <qandaentry><CR></qandaentry><esc>O
"imap <buffer> ,qs <qandaset><CR></qandaset><esc>O
"imap <buffer> ,qd <qandadiv><CR><title></title><CR></qandadiv><esc>k$bba

" other objects
"imap <buffer> ,ti <title></title><esc>bba
"imap <buffer> ,fn <filename></filename><esc>bba
"imap <buffer> ,fo <footnote><para></para></footnote>
"imap <buffer> ,pl <programlisting><CR></programlisting><esc>O
"imap <buffer> ,sb <sidebar><CR><title></title><CR><para></para><CR></sidebar>
"imap <buffer> ,sc <screen><CR></screen><esc>O
"imap <buffer> ,no <note><CR><para></para><CR></note>
"imap <buffer> ,w <warning><CR><para></para><CR></warning>
"imap <buffer> ,co <!--  --><esc>bhi
"imap <buffer> ,cm <command></command><esc>bba
"imap <buffer> ,bq <blockquote><CR></blockquote><esc>O
"imap <buffer> ,vn <varname></varname><esc>bba

" macro for character data
"imap <buffer> ,cd <![CDATA[]]><esc>$ba

" macros for DocBook XML Slides using Norman Walsh's slides DocType
"imap <buffer> ,fl ,f2<esc>kkkk$bba
"imap <buffer> ,f2 <foil><CR><title></title><CR><CR><para></para><CR><CR><BS><BS></foil>
"imap <buffer> ,fg <foilgroup><CR><title></title><CR><CR>,f2<CR><CR><BS><BS></foilgroup><esc>kkkkkkkkk$bba

" macros for weblog entries
"imap <buffer> ,tm <CR><esc>k:r! date +\%H:\%M:\%S\%z<CR>$hi:<esc>kJxJxa
"imap <buffer> ,da <CR><esc>k:r! date +\%Y-\%m-\%d<CR>kJxJxa
"imap <buffer> ,xst <story id="" time=",tm"><CR><storyinfo><CR><title></title><CR><subtitle></subtitle><CR><CR><abstract><CR><para></para><CR></abstract><CR><CR><keywordset><CR></keywordset><CR></storyinfo><CR><CR><para></para><CR><CR></story>
"imap <buffer> ,st ,xst<esc>kk$bba
"imap <buffer> ,dy <day date=",da"><CR><CR>,xst<CR><CR></day><esc>kkkk$bba
"imap <buffer> ,bl <?xml version="1.0" encoding="UTF-8"?><CR><CR><!DOCTYPE blog><CR><CR><blog month=",da<BS><BS><BS>"><CR><author>ralphm</author><CR><CR><CR><CR></blog><CR><CR><!-- vim: set ts=2 sw=2 et : --><ESC>kkkki,dy

"imap <buffer> ,kw <keyword></keyword><esc>bba

imap <buffer> ,sl <div class="slide"><CR><h1></h1><CR></div><ESC>k$bba
