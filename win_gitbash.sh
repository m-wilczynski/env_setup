winget install JanDeDobbeleer.OhMyPosh -s winget
touch $HOME/.bashrc
echo 'eval "$(oh-my-posh --init --shell bash --config https://raw.githubusercontent.com/m-wilczynski/oh-my-posh/main/themes/easy-term.omp.json)"' > $HOME/.bashrc
echo 'Time to restart your terminal!'