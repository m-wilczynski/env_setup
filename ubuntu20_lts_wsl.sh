# TODO

sudo apt-get update
# TODO: fresh golang from tarball, add it to ~/.profile and add $GOPATH do ~/.bashrc
# Source both files from above
sudo apt-get install --reinstall ca-certificates

# Append below to ~/.bashrc

GOPATH=$HOME/go

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
fi
