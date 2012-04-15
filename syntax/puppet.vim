" puppet syntax file
" Filename:     puppet.vim
" Language:     puppet configuration file 
" Maintainer:   Luke Kanies <luke@madstop.com>
" URL:          https://github.com/puppetlabs/puppet/blob/master/ext/vim/syntax/puppet.vim
" Last Change: 
" Version:      
"

" Copied from the cfengine, ruby, and perl syntax files
" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn region  puppetDefine        start="^\s*\(class\|define\|site\|node\)\s+" end="{" contains=puppetDefType,puppetDefName,puppetDefArguments
syn match   puppetDefType       "\(class\|define\|site\|node\|inherits\)" contained
syn match   puppetInherits      "inherits" contained
syn region  puppetDefArguments  start="(" end=")\s*" contains=puppetArgument
syn match   puppetArgument      "\w\+" contained
syn match   puppetDefName     "\(\w\|\:\)\+\s*" contained

syn match   puppetInstance           "\(\w\|\:\)\+\s*{" contains=puppetTypeBrace,puppetTypeName,puppetTypeDefault
syn match   puppetExisting       "[A-Z\:]\(\w\|\:\)*\[" contains=puppetTypeDefault,puppetTypeBrack
syn match   puppetTypeBrack      "\[" contained
syn match   puppetTypeBrace       "{" contained
syn match   puppetTypeName       "[a-z]\w*" contained
syn match   puppetTypeDefault    "[A-Z]\w*" contained

syn match   puppetParam           "\w\+\s*=>" contains=puppetTypeRArrow,puppetParamName
syn match   puppetParamRArrow       "=>" contained
syn match   puppetParamName       "\w\+" contained
syn match   puppetVariable           "$\w\+"
syn match   puppetVariable           "$::\w\+"
syn match   puppetVariable           "${\w\+}"
syn match   puppetVariable           "${::\w\+}"
syn match   puppetParen           "("
syn match   puppetParen           ")"
syn match   puppetBrace           "{"
syn match   puppetBrace           "}"
syn match   puppetBrack           "\["
syn match   puppetBrack           "\]"
syn match   puppetConditional     "\<\%(case\|if\|else|elsif\|given\|when\|default\)\>"

syn region  puppetString start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=puppetVariable
syn region  puppetString start=+'+ skip=+\\\\\|\\"+ end=+'+
syn region  puppetString start=+/+ skip=+\\\\\|\\/+ end=+/+

syn keyword puppetMetaParam  unless
syn keyword puppetMetaParam  require
syn keyword puppetMetaParam  onlyif

syn keyword puppetBoolean    true false 
syn keyword puppetKeyword    import inherits include
syn keyword puppetControl    case default 
syn region  puppetDefine        keepend start="^\s*\(class\|define\|node\)" end='{' contains=puppetDefType,puppetDefName,PuppetDefArguments,puppetDefBrace
syn match   puppetDefBrace      '{' contained
syn match   puppetDefName       "[a-z]\w*" contained
syn match   puppetDefType       "\(class\|define\|node\|inherits\)" contained
syn region  puppetDefArguments  start="(" end=")\s*" contains=puppetVariable,puppetComment

syn match   puppetDefault       "[A-Z]\(\w\|\:\)\+\s*{" contains=puppetBrace,puppetTypeDefault
syn match   puppetTypeTitle     "[a-z]\(\w\|\:\)\+\s*{" contains=puppetBrace,puppetTypeName
syn match   puppetReference     "[A-Z\:]\(\w\|\:\)*\[" contains=puppetTypeDefault,puppetBrack
syn match   puppetTypeBrack     "\[" contained
syn match   puppetTypeBrace     "{" contained
syn match   puppetTypeName      "[a-z]\w*" contained
syn match   puppetTypeDefault   "[A-Z]\w*" contained

syn match   puppetParam         "\w\+\s*\(+>\|=>\)" contains=puppetHashRocket,puppetParamName
syn match   puppetHashRocket    "+>\|=>" contained
syn match   puppetParamName     "\w\+" contained
syn match   puppetVariable      "$\(\w\|\:\)\+"
syn match   puppetVariable      "${\(\w\|\:\)\+}" contained
syn match   puppetParen         "(\|)"
syn match   puppetBrace         "{\|}"
syn match   puppetBrack         "\[\|\]"
syn match   puppetResSep        ';'
syn match   puppetParamSep      ','

syn region  puppetString        start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=puppetVariable,puppetERB
syn region  puppetString        start=+'+ skip=+\\\\\|\\"+ end=+'+
syn match   puppetNumber        '\d\+\(\|.\d\+\)'
syn keyword puppetBoolean       true false

syn keyword puppetRelationship  require before subscribe notify
syn keyword puppetMetaParams    alias audit check loglevel noop notify schedule stage tag
syn match   puppetOperator      '==\|>=\|<=\|>>\|<<\|>\|<\|!=\|!\|+\|-\|*\|/\|and\|or'
syn match   puppetRelationship  '\~>\|->\|<\~\|<-'
syn match   puppetERB           '<%=\|<%\|-%>\|%>'

syn keyword puppetKeyword       import inherits include
syn keyword puppetConditional   case default if else elsif

" comments last overriding everything else
syn match   puppetComment       "\s*#.*$" contains=puppetTodo
syn keyword puppetTodo          TODO NOTE FIXME XXX contained

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_puppet_syn_inits")
  if version < 508
    let did_puppet_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink puppetConditional          Conditional
  HiLink puppetVariable             Identifier
  " *Constant (String, Character, Number, Boolean, Float)
  HiLink puppetString               String
  HiLink puppetNumber               Number
  HiLink puppetBoolean              Boolean

  " *Identifier (Function)
  HiLink puppetType                 Identifier
  HiLink puppetDefault              Identifier
  HiLink puppetDefName              Identifier
  HiLink puppetArgument             Identifier
  HiLink puppetVariable             Identifier
  HiLink puppetParamName            Identifier

  " *Statement (Conditional, Repeat, Label, Operator, Keyword, Exception)
  HiLink puppetConditional          Conditional
  HiLink puppetTypeName             Statement
  HiLink puppetRelationship         Statement
  HiLink puppetMetaParams           Statement
  HiLink puppetOperator             Operator
  HiLink puppetERB                  Operator
  HiLink puppetKeyword              Keyword

  " *PreProc (Include, Define, Macro, PreCondit)
  HiLink puppetDefType              Define
  HiLink puppetTypeDefs             Define

  " *Type (StorageClass, Stucture, Typedef)
  HiLink puppetTypeDefault          Type

  " *Special (SpecialChar, Tag, Delimiter, SpecialComment, Debug)
  HiLink puppetBrack                Delimiter
  HiLink puppetTypeBrack            Delimiter
  HiLink puppetBrace                Delimiter
  HiLink puppetTypeBrace            Delimiter
  HiLink puppetParen                Delimiter
  HiLink puppetDelimiter            Delimiter
  HiLink puppetControl              Statement
  HiLink puppetDefType              Define
  HiLink puppetDefName              Identifier
  HiLink puppetTypeName             Statement
  HiLink puppetTypeDefault          Type
  HiLink puppetParamName            Identifier
  HiLink puppetArgument             Identifier
  HiLink puppetMetaParam            Conditional
  HiLink puppetParamSep             Delimiter
  "HiLink puppetBrace                Delimiter
  "HiLink puppetTypeBrace            Delimiter

  " *Underlined     text that stands out, HTML links
  " *Error
  "HiLink puppetResSep               Error

  " *Ignore

  " *Comment        any comment
  HiLink puppetComment              Comment
  " *Todo
  HiLink puppetTodo                 Todo

  delcommand HiLink
endif

let b:current_syntax = "puppet"
