echo "Copying .vimrc file"
cp ./vim-config/.vimrc $HOME/.vimrc

echo "Checking Vundle"

# https://sentry.io/answers/determine-whether-a-file-exists-or-not-in-bash/

VundleDIR=~/.vim/bundle/Vundle.vim
if [ -d $VundleDIR ]; then
       echo "Vundle already exists, skipping installation."
else
        echo "Installing Vundle..."
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

echo "Installing vim plugin dependencies..."

vim +PluginInstall +qall
# https://github.com/ycm-core/YouCompleteMe?tab=readme-ov-file#linux-64-bit
sudo apt install build-essential cmake vim-nox python3-dev -y
sudo apt install mono-complete golang nodejs default-jdk npm -y

python3 ~/.vim/bundle/youcompleteme/install.py --all

