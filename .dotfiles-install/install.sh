git clone --bare git@github.com:guiohm/myWork_WSL_DotFiles.git "$HOME/.dotfiles-repo"
function config {
   git --git-dir="$HOME/.dotfiles-repo/" --work-tree="$HOME" $@
}
mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
    echo "Checked out config.";
else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} |  xargs sh -c 'for arg do mkdir -p .config-backup/`dirname "$arg"`; mv "$arg" .config-backup/"$arg"; done' _
fi;
config checkout
config config status.showUntrackedFiles no
config submodule init
config submodule update
source $HOME/.bashrc
