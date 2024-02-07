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

# Install cli tools
dnfDepends=(
	fzf
	speedtest-cli
	tealdeer
	bpytop
	neofetch
	cpufetch
	bat
	micro
	trash-cli
	ripgrep
	lsd
	lolcat
	fd-find
	nodejs
	nvim
)

sudo dnf install -y "${dnfDepends[@]}"

tldr --update

# Define the user
user=$(whoami)

# Install rmtrash
git clone https://github.com/PhrozenByte/rmtrash /home/"$user"/Downloads/rmtrash/
sudo mv /home/"$user"/Downloads/rmtrash/rmdirtrash /home/"$user"/Downloads/rmtrash/rmtrash /usr/local/bin/
rm -rf /home/"$user"/Downloads/rmtrash/

# Install Noto Nerdfont
curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Noto.zip --output /home/"$user"/Downloads/Noto.zip
unzip /home/"$user"/Downloads/Noto.zip -d /home/"$user"/Downloads/Nerd-Noto/
sudo mkdir /usr/share/fonts/nerds-noto
sudo mv /home/"$user"/Downloads/Nerd-Noto/*.ttf /usr/share/fonts/nerds-noto/

rm -vf /home/"$user"/Downloads/Noto.zip
rm -rvf /home/"$user"/Downloads/Nerd-Noto/

# Refresh Font Cache
fc-cache -fv
fc-list | rg "NerdFont"

# Add Bash Aliases
bashAliases=(
	"# Aliases"
	"alias cat='bat --paging=never'"
	"alias speedtest='speedtest-cli'"
	"alias ls='lsd --group-dirs first'"
	"alias la='lsd -A --group-dirs first'"
	"alias ll='lsd -l --group-dirs first'"
	"alias lla='lsd -lA --group-dirs first'"
	"alias lt='lsd --tree'"
	"alias dinstall='sudo dnf install -y'"
	"alias rm='rmtrash -iv'"
	"alias rmdir='rmdirtrash -v'"
	"alias grep='rg'"
)

for i in "${bashAliases[@]}"; do
	echo "$i" >> /home/"$user"/.bashrc
done

# Add NvChad config to NeoVim
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

# Add Catppuccin Colorscheme to konsole
git clone https://github.com/catppuccin/konsole /home/"$user"/Downloads/catppuccin/
mv Catppuccin-Frappe.colorscheme Catppuccin-Latte.colorscheme Catppuccin-Macchiato.colorscheme Catppuccin-Mocha.colorscheme ~/.local/share/konsole/
rm -rvf /home/"$user"/Downloads/catppuccin/

# Install Starship and add setup to .bashrc file and add config
curl -sS https://starship.rs/install.sh | sh
echo "# Starship Setup" >> /home/"$user"/.bashrc
echo "eval '$(starship init bash)'" >> /home/"$user"/.bashrc
mkdir -p ~/.config && touch ~/.config/starship.toml

# Clone config files from my github repo
git clone https://github.com/AutofillMe/Linux /home/"$user"/Downloads/myConfigs/

# Add my starship.toml file to config
mv -f /home/"$user"/Downloads/myConfigs/starship.toml ~/.config/