# First boot setup
setup-koibito:
	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
	ujust install-firefox
	flatpak install -y com.github.iwalton3.jellyfin-media-player

# Install firefox from flatpak
install-firefox:
	flatpak install -y flathub org.mozilla.firefox

# Install chrome from flatpak
install-chrome:
	flatpak install -y flathub com.google.Chrome
