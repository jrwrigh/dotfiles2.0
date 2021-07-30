cursor_mode() {
    # See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursor shapes
    cursor_block_solid='\e[2 q'
    cursor_block_blink='\e[0 q'
    cursor_beam_solid='\e[6 q'

    cursor_vicmd=$cursor_block_solid
    cursor_viins=$cursor_beam_solid

    function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]]; then
            echo -ne $cursor_vicmd
        elif [[ ${KEYMAP} == main ]] ||
            [[ ${KEYMAP} == viins ]] ||
            [[ ${KEYMAP} = '' ]]; then
            echo -ne $cursor_viins
        fi
    }

    zle-line-init() {
        echo -ne $cursor_viins
    }

    zle -N zle-keymap-select
    zle -N zle-line-init
}
