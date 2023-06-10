#

include ../makefile.mk

init :
	mkdir -p .local && cd .local || exit 1
	git clone https://github.com/bootlin/elixir
	# geant4
	mkdir -p geant4/data
	git clone https://github.com/Geant4/geant4 geant4/repo
	# root
	mkdir -p root/data
	git clone https://github.com/root-project/root root/repo
