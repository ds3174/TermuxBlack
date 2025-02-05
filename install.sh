#!/usr/bin/env sh

# Create separate directory for my repositor
decoration() {
	apt-get install gnupg -yq --silent
	mkdir -p ~/.termux
	for i in colors.properties termux.properties font.ttf; do
		wget -q https://github.com/Hax4us/TermuxBlack/raw/master/style/$i -O ~/.termux/$i
	done
	#rm -r $PREFIX/etc/motd
	#echo "toilet -F metal -F border -f future termux black" >> $PREFIX/etc/bash.bashrc
}

addrepo() {
	# Add repo in separate file
	mkdir -p $PREFIX/etc/apt/sources.list.d && printf "deb https://hax4us.github.io/TermuxBlack/ termuxblack main" > $PREFIX/etc/apt/sources.list.d/termuxblack.list

	# Add gpg public key
	wget -q https://hax4us.github.io/TermuxBlack/termuxblack.key -O termuxblack.key && apt-key add termuxblack.key
	
	# just update
	apt-get update -yq --silent
}

echo "[*] Installing TermuXBlacK ..."
decoration
addrepo
echo "[*] Finished :)"
# Now trigger broadcast to make changes visible
am broadcast --user 0 -a com.termux.app.reload_style com.termux > /dev/null
echo "[*] Now open new session & enjoy"
