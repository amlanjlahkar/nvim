function! has_colorscheme#colorscheme(name) abort
    let plugin_dir = 'pack/packer/start/' .a:name
    return !empty(globpath(&rtp, plugin_dir))
endfunction
