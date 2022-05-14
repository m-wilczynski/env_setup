# env_setup
🏗 Development environment setup


## WSL with Ubuntu setup

**1. *(WSL)* Clone the repo (obviously):**
```bash
git clone https://github.com/m-wilczynski/env_setup.git
```

**1.1. *(Powershell)* Optional - copy Windows Terminal setup**
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
![image](https://user-images.githubusercontent.com/6330789/168451434-65a3d3d0-8cb3-491e-b83d-094f2a9cc65d.png)


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
