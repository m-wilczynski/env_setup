sudo apt-get update

source ./ubuntu20_lts_cli.sh

# Fresh Golang from tarball
curl -OL https://go.dev/dl/go1.18.2.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.18.2.linux-amd64.tar.gz

# Add golang to PATH
echo '
export PATH=$PATH:/usr/local/go/bin' >> ~/.profile

sudo apt-get install --reinstall ca-certificates

# Set GOPATH for golang packages installation
echo '
GOPATH=$HOME/go' >> ~/.bashrc

# Source both files from above for immediate effeect
source ~/.profile && source ~/.bashrc

# Powerline for WSL via powerline-go
go get github.com/justjanne/powerline-go

# Enable powerline-go in bash
echo '
function _update_ps1() {
    PS1="$($GOPATH/bin/powerline-go -error $? -jobs $(jobs -p | wc -l)\
            -colorize-hostname\
            -newline -cwd-max-depth 5 -colorize-hostname\
            -max-width 95 -shell bash\
            -theme gruvbox\
            -modules 'venv,host,ssh,cwd,perms,git,hg,jobs,exit,root,docker,docker-context,kube,dotenv,node,wsl')"

    # Uncomment the following line to automatically clear errors after showing
    # them once. This not only clears the error for powerline-go, but also for
    # everything else you run in that shell. Don't enable this if you're not
    # sure this is what you want.

    #set "?"
}

if [ "$TERM" != "linux" ] && [ -f "$GOPATH/bin/powerline-go" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi' >> ~/.bashrc

# More readable dirs in Ubuntu @ WSL
echo '
LS_COLORS="ow=01;36;40" && export LS_COLORS' >> ~/.bashrc

source ~/.bashrc
