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

let g:fullscreen_python_win32ext_available = 0

" http://vim.wikia.com/wiki/Restore_screen_size_and_position
" " To enable the saving and restoring of screen positions.
let g:fullscreen_orig_screen_size_restore_pos = g:screen_size_restore_pos

function! s:check_win32_extensions()
  if has('python3')
    silent! python3 import vimfullscreen
  else
    silent! python import vimfullscreen
  endif
  if !g:fullscreen_python_win32ext_available
    echomsg "VimFullscreen: Python Win32 Extensions not found. Please install for best fullscreen experience."
  endif
  return g:fullscreen_python_win32ext_available
endfunction

if has('fullscreen')

  " MacVim has a native fullscreen mode
  function fullscreen#toggle()
    if &fullscreen
      set nofullscreen
      let g:screen_size_restore_pos = g:fullscreen_orig_screen_size_restore_pos
    else
      set fullscreen
      let g:screen_size_restore_pos = 0 " do NOT store full screen as default screen size
    endif
  endfunction

  function fullscreen#maximize()
    call fullscreen#default#maximize()
    let g:screen_size_restore_pos = 0 " do NOT store full screen as default screen size
  endfunction

elseif has('gui_win32') && (has('python3') || has('python')) && s:check_win32_extensions()
  
  function fullscreen#toggle()
    if fullscreen#windows#is_active()
      call fullscreen#windows#deactivate()
      let g:screen_size_restore_pos = g:fullscreen_orig_screen_size_restore_pos
    else
      call fullscreen#windows#activate()
      let g:screen_size_restore_pos = 0 " do NOT store full screen as default screen size
    endif
  endfunction

  " Simulate maximize
  function fullscreen#maximize()
    call fullscreen#windows#maximize()
    let g:screen_size_restore_pos = 0 " do NOT store full screen as default screen size
  endfunction

  function fullscreen#exit()
    if fullscreen#windows#is_active()
      call fullscreen#windows#deactivate()
      let g:screen_size_restore_pos = g:fullscreen_orig_screen_size_restore_pos
    endif
  endfunction

  au VimLeave * call fullscreen#exit()

else

  " Sorry!
  function fullscreen#toggle()
    echoerr "Fullscreen mode not implemented for this system, sorry!"
  endfunction

  function fullscreen#maximize()
    call fullscreen#default#maximize()
  endfunction

endif

