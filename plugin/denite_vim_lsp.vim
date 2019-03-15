""""""""""""""""""""""""""""""""""""""""""
"    LICENSE: 
"     Author: 
"    Version: 
" CreateTime: 2019-03-15 13:40:06
" LastUpdate: 2019-03-15 13:40:06
"       Desc: 
""""""""""""""""""""""""""""""""""""""""""

if exists("s:is_loaded")
	finish
endif
let s:is_loaded = 1

function! Denite_document_symbol() abort
    let l:servers = filter(lsp#get_whitelisted_servers(), 'lsp#capabilities#has_document_symbol_provider(v:val)')

    if len(l:servers) == 0
        call s:not_supported('Retrieving symbols')
        return
    endif

	let result = []
	function! Symbol_cb(data) closure
		let result = a:data["response"]["result"]
	endfunction

    for l:server in l:servers
        call lsp#send_request(l:server, {
            \ 'method': 'textDocument/documentSymbol',
            \ 'params': {
            \   'textDocument': lsp#get_text_document_identifier(),
            \ },
			\ 'sync': 1,
            \ 'on_notification': function('Symbol_cb'),
            \ })
    endfor

	return result
endfunction

"function s:test_cb(data)
"	call nvim_log#debug(string(a:data))
"endfunction
