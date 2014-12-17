"Vim configuration File
"by Tobias Breitwieser <breitwieser-tobi@gmx.de>


"set mouse=a "shame on me -.-


syntax on              "syntax highlighting


set bs=2
set number             "line numbers
"set list               "show special characters
set ignorecase         "ignore case when searching
set wildmenu           "fancy tab completion
set tabstop=2          "tabstop every 4 characters
set cindent            "autoindent on functions
set copyindent         "copy indention method
set preserveindent     "preserve previous idention
set shiftwidth=2      "shift by 8 characters
"set expandtab
"set smarttab           "tab smartly ;)
set background=dark    "brighter colors
set spelllang=de,en    "german and english
set foldmethod=marker  "set the folding method

set spellfile=/home/tobgod/.vim/de.add                    "user dictionary
set printoptions=paper:A4,number:y,syntax:y,duplex:off  "printing options
"set listchars=tab:>.,trail:_,extends:>,precedes:<       "special characters


filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"





"colors
hi PreProc ctermfg=1 term=bold


"spelling errors
ab ihc ich
ab Ihc Ich
ab nciht nicht
ab auhc auch
ab acuh auch


"C/C++
"ab STD using namespace std;
ab DEF #define
ab IFN #ifndef
ab INC #include
"ab STRING #include <string>
"ab VECTOR #include <vector>
"ab QUEUE #include <queue>
"ab IOSTREAM #include <iostream>
"ab FSTREAM #include <fstream>
"ab SSTREAM #include <sstream>
"ab CERRNO #include <cerrno>
"ab CSTDLIB #include <cstdlib>
"ab CSTDIO #include <cstdio>
ab LINE1 //_________________________________________________________________________

ab LINE2 ===========================================================================


"abbreviations
ab XHTML <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
ab SN > [...]
ab EMAIL tobias@breitwieser.biz
ab MURL http://www.tobias-breitwieser.de
ab NAME Tobias Breitwieser
ab GRUSS Mit freundlichen Grüßen<CR><CR>Tobias Breitwieser
ab DATE1 <C-R>=strftime("%F")<CR>
ab DATE2 <C-R>=strftime("%d.%m.%y")<CR>
ab DATE3 <C-R>=strftime("%a, %d %b %Y  %H:%M:%S %z")<CR>


"convert German umlauts into their HTML equivalent
"by Erik Scharwaechter <diozaka@gmx.de>

function Umlauts2HTML()
	%s/Ä/\&Auml;/Ige
	%s/ä/\&auml;/Ige
	%s/Ü/\&Uuml;/Ige
	%s/ü/\&uuml;/Ige
	%s/Ö/\&Ouml;/Ige
	%s/ö/\&ouml;/Ige
	%s/ß/\&szlig;/Ige
	%s/€/\&euro;/Ige
endfunction

function Nl2br()
	%s/\n/<br>/Ige
endfunction

"convert quoted-printable format to German umlauts
"by Erik Scharwaechter <diozaka@gmx.de>
function QP2Umlauts()
	%s/=DF/ß/Ige
	%s/=FC/ü/Ige
	%s/=DC/Ü/Ige
	%s/=F6/ö/Ige
	%s/=D6/Ö/Ige
	%s/=E4/ä/Ige
	%s/=C4/Ä/Ige
	%s/=A4/€/Ige
	%s/=84/"/Ige
	%s/=93/"/Ige
	%s/=AC/-/Ige
	%s/=\n//Ige
	%s/=3D/=/Ige
	%s/=20/ /Ige
endfunction


"comment out code
map <F1> I//<Esc>
map <F2> I#<Esc>
map <F3> O#if 0<Esc>
map <F4> o#endif<Esc>

"misc keys
map <F5> :set invspell<CR><Bar>:echo "Spell Check: " . strpart("OffOn", 3 * &spell, 3)<CR>
map <F6> :set invpaste<CR><Bar>:echo "Paste Mode: " . strpart("OffOn", 3 * &paste, 3)<CR>
map <F7> :tabp<CR>
map <F8> :tabn<CR>
map <F9> yy p
map <F10> :call Umlauts2HTML()<CR>
map <F11> :call QP2Umlauts()<CR>
map <F12> :ascii<CR>


"mail settings
augroup mail
	au!

	"don't show line numbers
	au FileType mail set nonu

	"no special characters
	au FileType mail set nolist

	"break line after 72 characters
	au FileType mail set tw=72

	"no indention
	au FileType mail set noai
	au FileType mail set nocin
	au FileType mail set nosi
	au FileType mail set bs=2
	
augroup END


"transparent editing of gpg encrypted files.
"by Wouter Hanegraaff <wouter@blub.net>
augroup encrypted
	au!

	"make sure nothing is written to ~/.viminfo
	au BufReadPre,FileReadPre      *.gpg set viminfo=

	"we don't want a swap file
	au BufReadPre,FileReadPre      *.gpg set noswapfile

	"switch to binary mode to read the encrypted file
	au BufReadPre,FileReadPre      *.gpg set bin
	au BufReadPre,FileReadPre      *.gpg let ch_save = &ch|set ch=2
	au BufReadPost,FileReadPost    *.gpg '[,']!gpg --decrypt 2> /dev/null

	"switch to normal mode for editing
	au BufReadPost,FileReadPost    *.gpg set nobin
	au BufReadPost,FileReadPost    *.gpg let &ch = ch_save|unlet ch_save
	au BufReadPost,FileReadPost    *.gpg execute ":doau BufReadPost " . expand("%:r")

	"convert all text to encrypted text before writing
	au BufWritePre,FileWritePre    *.gpg   '[,']!gpg --default-recipient-self -ae 2>/dev/null

	"undo the encryption after the file has been written.
	au BufWritePost,FileWritePost    *.gpg   u
augroup END
