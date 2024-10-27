fzf --fish | source

# Colors from https://github.com/catppuccin/fzf
set --export FZF_DEFAULT_OPTS \
    --reverse \
    --inline-info \
    --color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
    --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
    --color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284

set --export BAT_PAGER
