# env_setup
🏗 Development environment setup


## WSL (Powerline) with Ubuntu setup

**1. *(any)* Clone the repo (obviously):**
```bash
git clone https://github.com/m-wilczynski/env_setup.git
```

**1.1. *(Powershell as Administrator)* Optional - copy Windows Terminal setup**
> If skipped you need to edit your settings.json manually with font you'll choose in step 1
```powershell
Invoke-WebRequest -Uri https://raw.githubusercontent.com/m-wilczynski/env_setup/main/win-term_settings.json -UseBasicParsing -OutFile $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
```

**2. *(Powershell)* Get font with Powerline glyphs; my choice is `Source Code Pro`:**
```powershell
cd $env:USERPROFILE
mkdir tmp_fonts
cd tmp_fonts
$fontFileUrl="https://github.com/powerline/fonts/raw/master/SourceCodePro/Source%20Code%20Pro%20for%20Powerline.otf"
Invoke-WebRequest -Uri $fontFileUrl -UseBasicParsing -OutFile "Source Code Pro for Powerline.otf"
& '.\Source Code Pro for Powerline.otf'
```
Click "Install" afterwards when font preview window pops up.
If you want to go full automate, find `Add-Font.ps1` script that Microsoft published.

**3. *(WSL)* Go to cloned repo, run `ubuntu20_lts_wsl.sh` and source it to have immediate effect:**
```bash
cd env_setup
bash ./ubuntu20_lts_wsl.sh && source ~/.bashrc
```

**4. *(WSL)* Open new terminal window of WSL; result should be:**
![WSL Powerline](./wsl-powerline.PNG)


**5. *(WSL)* Verify setup:**
```bash
# Git
git version
# traceroute
traceroute --version
# curl
curl --version
# .NET
dotnet --list-sdks
# Node.js
node -v
# Go
go version
# Docker (to be replaced with podman to work with WSL without Docker Desktop)
docker version
# kubectl (with alias = "k", running minikube)
k version
```


## Git Bash with `oh-my-posh`

**1. *(any)* Clone the repo (obviously):**
```bash
git clone https://github.com/m-wilczynski/env_setup.git
```

**1.1. *(Powershell as Administrator)* Optional - copy Windows Terminal setup**
> If skipped you need to edit your settings.json manually with font you'll choose in step 1
```powershell
Invoke-WebRequest -Uri https://raw.githubusercontent.com/m-wilczynski/env_setup/main/win-term_settings.json -UseBasicParsing -OutFile $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
```

**2. *(Powershell as Administrator)* Download font to be used with `oh-my-posh`:**
```powershell
cd $env:USERPROFILE
mkdir -Force tmp_fonts
cd tmp_fonts
$fontFileUrl="https://github.com/ryanoasis/nerd-fonts/blob/2.1.0/patched-fonts/Meslo/M/Regular/complete/Meslo%20LG%20M%20Regular%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.ttf?raw=true"
Invoke-WebRequest -Uri $fontFileUrl -UseBasicParsing -OutFile "Meslo Mono NF.ttf"
& '.\Meslo Mono NF.ttf'
```
Click "Install" in newly opened window and close both this window and Powershell prompt.

**3. *(Git Bash)* Run `win_gitbash.sh` script inside Git Bash:**
```bash
cd env_setup
sh ./win_gitbash.sh
```
then restart entire Windows Terminal (required since refreshing PATH sourced from Windows environment is tricky).

**4. *(Git Bash)* Result:**
![Git Bash](./git-bash.PNG)
