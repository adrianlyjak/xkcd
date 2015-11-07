#!/bin/bash
PROFILE="$HOME/.bash_profile"
if [ -e $PROFILE ]; then
	echo "installing xkcd to $PROFILE"
	cat <<- "EOF" >> $PROFILE

	##### xkcd, it's like cd, but better #####
	function xkcd() {
		QUOTE=$(curl -L "http://c.xkcd.com/random/comic/" 2>/dev/null | \
			sed "s:>:>\n:g" | \
			grep -A 3 "id=\"comic\"" | \
			grep -o "title=\"[^\"]*" | \
			cut -f 2 -d"\"" | \
	                sed "s/&#39;/'/g" | \
	                sed "s/&lt;/</g" |
	                sed "s/&quot;/\"/g" |
			sed "s/&gt;/</g" )

		echo \"$QUOTE\"
		cd "$@"
	}
	##### end xkcd
	EOF
	
	echo "now run \`source $PROFILE\`, and try it out!"
	echo "$ xkcd ."
else
	echo "this dumb install script only installs to $PROFILE, which you appear to not have"
fi
