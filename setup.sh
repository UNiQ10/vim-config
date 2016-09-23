#!/bin/bash

# Find the directory path of setup.sh.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create a symlink to $DIR/.vimrc at $HOME/.vimrc.
# Will prompt to delete existing .vimrc.
echo "Creating symlink to $DIR/.vimrc at $HOME/.vimrc."

if [[ -e "$HOME"/.vimrc ]]; then
    echo ".vimrc already exists at $HOME! Press y when prompted to remove it."
    rm -i "$HOME"/.vimrc
    if [[ -e "$HOME"/.vimrc ]]; then
        echo "Failed to create symlink at $HOME/.vimrc! Exiting."
        exit 1
    fi
fi

ln -s "$DIR"/.vimrc "$HOME"/.vimrc

echo ".vimrc symlink created!"

# Dowload plug.vim plugin manager to autoload directory.
echo "Downloading plug.vim plugin manger to autoload directory"

curl -fLo "$DIR"/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if [[ $? -ne 0 ]]; then
    echo "plug.vim download failed! Exiting."
    exit 1
fi

echo "plug.vim download completed!"

# Setup complete.
echo "vim configuration completed!"