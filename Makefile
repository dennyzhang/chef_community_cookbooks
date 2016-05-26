all:check

check:rubocopcheck foodcriticcheck

rubocopcheck:
	cd cookbooks; ls -1 | xargs rubocop

foodcriticcheck:
	cd cookbooks; ls -1 | xargs foodcritic
