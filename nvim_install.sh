# Make sure this is running on Nobara
echo "This script is for Fedora Linux and more specifically for Nobara Linux."

while true; do
	read -rp "Are you sure that you want to continue? [y/n]" yn
	case $yn in
		[Yy]* ) break;;
		[Nn]* ) exit 1;;
		* ) echo "Please answer Y for Yes or N for No";;
	esac
done

# Make sure this is running after running install.sh and and after setting up Nvim
echo "This script must be run after running install.sh and running the initial NeoVim setup."

while true; do
	read -rp "Are you sure that you want to continue? [y/n]" yn
	case $yn in
		[Yy]* ) break;;
		[Nn]* ) exit 1;;
		* ) echo "Please answer Y for Yes or N for No";;
	esac
done

# Define the user
user=$(whoami)

# Move over all the configs
mv -f /home/"$user"/Downloads/myConfigs/chadrc.lua /home/"$user"/.config/nvim/lua/custom/
mv -f /home/"$user"/Downloads/myConfigs/init.lua /home/"$user"/.config/nvim/lua/custom/
mv -f /home/"$user"/Downloads/myConfigs/plugins.lua /home/"$user"/.config/nvim/lua/custom/
mkdir /home/"$user"/.config/nvim/lua/custom/configs/
mv -f /home/"$user"/Downloads/myConfigs/lspconfig.lua /home/"$user"/.config/nvim/lua/custom/configs/

# Remove the config folder
rm -rvf /home/"$user"/Downloads/myConfigs/
