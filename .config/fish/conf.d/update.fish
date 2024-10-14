function update_all
    pushd ~/dotfiles
    while not git pull
        gum choose --header "Uncommited config changes" "lazygit" "continue" "exit" | read CHOICE
        switch $CHOICE
        case "lazygit"
            lazygit
        case "continue"
            break
        case "exit"
            popd
            return
        end
    end
    stow . --no-folding
    popd

    switch (uname)
    case Linux
        sudo pacman -Syu --noconfirm
        yay -Syu --noconfirm
    case Darwin
        softwareupdate --install --all
        brew update
        brew upgrade
    end

    rustup update
    cargo install-update --all

    bob update --all
    echo "Updating lazy.nvim"
    nvim --headless '+Lazy! sync' +qa &> /dev/null

    pyenv install $(pyenv latest 3) --skip-existing
    echo "Updating fisher"
    fisher update &> /dev/null
    bun update --global
    gem update
end
