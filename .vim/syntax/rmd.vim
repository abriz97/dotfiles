" markdown Text with R statements
" Language: markdown with R code chunks
" Homepage: https://github.com/jalvesaq/R-Vim-runtime
" Last Change: Sun Apr 17, 2022  04:37PM
"
"   For highlighting pandoc extensions to markdown like citations and TeX and
"   many other advanced features like folding of markdown sections, it is
"   recommended to install the vim-pandoc filetype plugin as well as the
"   vim-pandoc-syntax filetype plugin from https://github.com/vim-pandoc.


if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" Highlight the header of the chunks as R code
let g:rmd_syn_hl_chunk = get(g:, 'rmd_syn_hl_chunk', 0)

" Pandoc-syntax has more features, but it is slower.
" https://github.com/vim-pandoc/vim-pandoc-syntax

" Don't waste time loading syntax that will be discarded:
let s:save_pandoc_lngs = get(g:, 'pandoc#syntax#codeblocks#embeds#langs', [])
let g:pandoc#syntax#codeblocks#embeds#langs = []

" Step_1: Source pandoc.vim if it is installed:
runtime syntax/pandoc.vim
if exists("b:current_syntax")
  if hlexists('pandocDelimitedCodeBlock')
    syn clear pandocDelimitedCodeBlock
  endif

  if len(s:save_pandoc_lngs) > 0 && !exists('g:rmd_fenced_languages')
    let g:rmd_fenced_languages = deepcopy(s:save_pandoc_lngs)
  endif

  " Recognize inline R code
  syn region rmdrInline matchgroup=rmdInlineDelim start="`r "  end="`" contains=@R containedin=pandocLaTeXRegion,yamlFlowString keepend
else
  " Step_2: Source markdown.vim if pandoc.vim is not installed
  syn region rmdrInline matchgroup=rmdInlineDelim start="`r "  end="`" contains=@Rmdr keepend

  " Configuration if not using pandoc syntax:
  " Add syntax highlighting of YAML header
  let g:rmd_syn_hl_yaml = get(g:, 'rmd_syn_hl_yaml', 1)
  " Add syntax highlighting of citation keys
  let g:rmd_syn_hl_citations = get(g:, 'rmd_syn_hl_citations', 1)

  " R chunks will not be highlighted by syntax/markdown because their headers
  " follow a non standard pattern: "```{lang" instead of "^```lang".
  " Make a copy of g:markdown_fenced_languages to highlight the chunks later:
  if exists('g:markdown_fenced_languages') && !exists('g:rmd_fenced_languages')
    let g:rmd_fenced_languages = deepcopy(g:markdown_fenced_languages)
  endif

  if exists('g:markdown_fenced_languages') && len(g:markdown_fenced_languages) > 0
    let s:save_mfl = deepcopy(g:markdown_fenced_languages)
  endif
  " Don't waste time loading syntax that will be discarded:
  let g:markdown_fenced_languages = []
  runtime syntax/markdown.vim
  if exists('s:save_mfl') > 0
    let g:markdown_fenced_languages = deepcopy(s:save_mfl)
    unlet s:save_mfl
  endif

  " Step_2a: Add highlighting for both YAML and citations which are pandoc
  " specific, but also used in Rmd files

  " You don't need this if either your markdown/syntax.vim already highlights
  " the YAML header or you are writing standard markdown
  if g:rmd_syn_hl_yaml
    " Basic highlighting of YAML header
    syn match rmdYamlFieldTtl /^\s*\zs\w*\ze:/ contained
    syn match rmdYamlFieldTtl /^\s*-\s*\zs\w*\ze:/ contained
    syn region yamlFlowString matchgroup=yamlFlowStringDelimiter start='"' skip='\\"' end='"' contains=yamlEscape,rmdrInline contained
    syn region yamlFlowString matchgroup=yamlFlowStringDelimiter start="'" skip="''"  end="'" contains=yamlSingleEscape,rmdrInline contained
    syn match  yamlEscape contained '\\\%([\\"abefnrtv\^0_ NLP\n]\|x\x\x\|u\x\{4}\|U\x\{8}\)'
    syn match  yamlSingleEscape contained "''"
    syn region pandocYAMLHeader matchgroup=rmdYamlBlockDelim start=/\%(\%^\|\_^\s*\n\)\@<=\_^-\{3}\ze\n.\+/ end=/^\([-.]\)\1\{2}$/ keepend contains=rmdYamlFieldTtl,yamlFlowString
    hi def link rmdYamlBlockDelim Delimiter
    hi def link rmdYamlFieldTtl Identifier
    hi def link yamlFlowString String
  endif

  " You don't need this if either your markdown/syntax.vim already highlights
  " citations or you are writing standard markdown
  if g:rmd_syn_hl_citations
    " From vim-pandoc-syntax
    " parenthetical citations
    syn match pandocPCite /\^\@<!\[[^\[\]]\{-}-\{0,1}@[[:alnum:]_][[:alnum:]à-öø-ÿÀ-ÖØ-ß_:.#$%&\-+?<>~\/]*.\{-}\]/ contains=pandocEmphasis,pandocStrong,pandocLatex,pandocCiteKey,@Spell,pandocAmpersandEscape display
    " in-text citations with location
    syn match pandocICite /@[[:alnum:]_][[:alnum:]à-öø-ÿÀ-ÖØ-ß_:.#$%&\-+?<>~\/]*\s\[.\{-1,}\]/ contains=pandocCiteKey,@Spell display
    " cite keys
    syn match pandocCiteKey /\(-\=@[[:alnum:]_][[:alnum:]à-öø-ÿÀ-ÖØ-ß_:.#$%&\-+?<>~\/]*\)/ containedin=pandocPCite,pandocICite contains=@NoSpell display
    syn match pandocCiteAnchor /[-@]/ contained containedin=pandocCiteKey display
    syn match pandocCiteLocator /[\[\]]/ contained containedin=pandocPCite,pandocICite
    hi def link pandocPCite Operator
    hi def link pandocICite Operator
    hi def link pandocCiteKey Label
    hi def link pandocCiteAnchor Operator
    hi def link pandocCiteLocator Operator
  endif
endif

" Step_3: Highlight code blocks.

syn region rmdCodeBlock matchgroup=rmdCodeDelim start="^\s*```\s*{.*}$" matchgroup=rmdCodeDelim end="^\s*```\ze\s*$" keepend
syn region rmdCodeBlock matchgroup=rmdCodeDelim start="^\s*```.+$" matchgroup=rmdCodeDelim end="^```$" keepend
hi link rmdCodeBlock Special

" Now highlight chunks:
syn region knitrOption start='^#| ' end='$' contained  containedin=rComment,pythonComment contains=knitrVar,knitrValue transparent
syn match knitrValue ': \zs.*\ze$' keepend contained containedin=knitrOption
syn match knitrVar '| \zs\S\{-}\ze:' contained containedin=knitrOption
syn cluster rmdChunkOptions contains=knitrOption,knitrVar,knitrValue

let g:rmd_fenced_languages = get(g:, 'rmd_fenced_languages', ['r'])
for s:type in g:rmd_fenced_languages
  if s:type =~ '='
    let s:ft = substitute(s:type, '.*=', '', '')
    let s:nm = substitute(s:type, '=.*', '', '')
  else
    let s:ft = s:type
    let s:nm  = s:type
  endif
  unlet! b:current_syntax
  exe 'syn include @Rmd'.s:nm.' syntax/'.s:ft.'.vim'
  if g:rmd_syn_hl_chunk
    exe 'syn region rmd'.s:nm.'ChunkDelim matchgroup=rmdCodeDelim start="^\s*```\s*{\s*=\?'.s:nm.'\>" matchgroup=rmdCodeDelim end="}$" keepend containedin=rmd'.s:nm.'Chunk contains=@Rmdr'
    exe 'syn region rmd'.s:nm.'Chunk start="^\s*```\s*{\s*=\?'.s:nm.'\>.*$" matchgroup=rmdCodeDelim end="^\s*```\ze\s*$" keepend contains=rmd'.s:nm.'ChunkDelim,@Rmd'.s:nm.',rmdChunkOptions'
  else
    exe 'syn region rmd'.s:nm.'Chunk matchgroup=rmdCodeDelim start="^\s*```\s*{\s*=\?'.s:nm.'\>.*$" matchgroup=rmdCodeDelim end="^\s*```\ze\s*$" keepend contains=@Rmd'.s:nm.',rmdChunkOptions'
  endif
endfor
unlet! s:type

" Step_4: Highlight code recognized by pandoc but not defined in pandoc.vim yet:
syn match pandocDivBegin '^:::\+ {.\{-}}' contains=pandocHeaderAttr
syn match pandocDivEnd '^:::\+$'

hi def link knitrVar PreProc
hi def link knitrValue Constant
hi def link knitrOption rComment
hi def link pandocDivBegin Delimiter
hi def link pandocDivEnd Delimiter
hi def link rmdInlineDelim Delimiter
hi def link rmdCodeDelim Delimiter

if len(s:save_pandoc_lngs)
  let g:pandoc#syntax#codeblocks#embeds#langs = s:save_pandoc_lngs
endif
unlet s:save_pandoc_lngs
let &cpo = s:cpo_save
unlet s:cpo_save

let b:current_syntax = "rmd"

" vim: ts=8 sw=2
