#!/bin/bash

# Sudo for elevating whole script execution
sudo echo "Bootstrapping Ubuntu GUI workstation..."
echo "Bootstrapping CLI tools..."
source ./ubuntu20_lts_cli.sh
echo "Bootstrapping GUI tools..."
source ./ubuntu20_lts_gui.sh
echo "Done!"
