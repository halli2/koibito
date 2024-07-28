# First boot setup
setup-koibito:
	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
	ujust install-firefox
	flatpak install -y com.github.iwalton3.jellyfin-media-player
	ujust brew
	brew install pipx
	pipx install jellyfin-mpv-shim
	brew install atuin
	brew install dust
	brew install zoxide
	brew install yazi
	brew install fd

# Install firefox from flatpak
install-firefox:
	flatpak install -y flathub org.mozilla.firefox

# Install chrome from flatpak
install-chrome:
	flatpak install -y flathub com.google.Chrome
