""""""""""""""""""""""""""""""""""""""""""
"    LICENSE: 
"     Author: 
"    Version: 
" CreateTime: 2019-03-25 09:41:02
" LastUpdate: 2019-03-25 09:41:02
"       Desc: 
""""""""""""""""""""""""""""""""""""""""""

if exists("s:is_loaded")
	finish
endif
let s:is_loaded = 1


function! Denite_references() abort
    let l:servers = filter(lsp#get_whitelisted_servers(), 'lsp#capabilities#has_references_provider(v:val)')

    if len(l:servers) == 0
        call s:not_supported('Retrieving references')
        return
    endif

	let result = []
	function! References_cb(data) closure
		echo string(a:data)
		let result = a:data["response"]["result"]
	endfunction

	let l:server = l:servers[0]
	"for l:server in l:servers
        call lsp#send_request(l:server, {
            \ 'method': 'textDocument/references',
            \ 'params': {
            \   'textDocument': lsp#get_text_document_identifier(),
            \   'position': lsp#get_position(),
            \   'context': {'includeDeclaration': v:false},
            \ },
			\ 'sync': 1,
            \ 'on_notification': function('References_cb'),
            \ })
    "endfor

	return result
endfunction
