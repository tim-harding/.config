if status is-interactive
    alias ls="exa --long --all --git --icons --header --no-permissions --no-user --time-style=long-iso --group-directories-first --level=2"
    function take_a_dub
        git add . && git commit -m $argv
    end
    set -x TERM xterm-256color
    set -x RIPGREP_CONFIG_PATH ~/.config/ripgrep/.ripgreprc
end
