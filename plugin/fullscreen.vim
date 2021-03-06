" VIM Fullscreen Plugin
" Copyright (C) 2015 Ruediger Hanke
" All rights reserved.
"
" Redistribution and use in source and binary forms, with or without
" modification, are permitted provided that the following conditions are met:
" 1. Redistributions of source code must retain the above copyright
" notice, this list of conditions and the following disclaimer.
" 2. Redistributions in binary form must reproduce the above copyright
" notice, this list of conditions and the following disclaimer in the
" documentation and/or other materials provided with the distribution.
" 3. Neither the name of the organization nor the
" names of its contributors may be used to endorse or promote products
" derived from this software without specific prior written permission.
"
" THIS SOFTWARE IS PROVIDED BY Ruediger Hanke ''AS IS'' AND ANY
" EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
" WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
" DISCLAIMED. IN NO EVENT SHALL Ruediger Hanke BE LIABLE FOR ANY
" DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
" (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
" LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
" ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
" (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
" SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

if !has('gui_running') || exists('g:loaded_fullscreen')
  finish
endif

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:fullscreen_default_keymap')
  let g:fullscreen_default_keymap = 1
endif

command! MaximizeWindow   call fullscreen#maximize()
command! ToggleFullscreen call fullscreen#toggle()

nnoremap <silent> <Plug>(fullscreen_maximize) :call fullscreen#maximize()<CR>
nnoremap <silent> <Plug>(fullscreen_toggle)   :call fullscreen#toggle()<CR>

if g:fullscreen_default_keymap != 0
  nmap <silent> <C-CR> <Plug>(fullscreen_toggle)
endif

let &cpo = s:save_cpo
unlet! s:save_cpo

let g:loaded_fullscreen = 1

