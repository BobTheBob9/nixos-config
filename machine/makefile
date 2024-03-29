# makefile that builds a configuration.nix file that includes a bunch of other files, based on provided environment variables
# not super clean and needs changes! TODO!

.PHONY: build_machine install clean

export GPU_NVIDIA := 1
export GPU_AMD := 0

export ENVIRONMENT_KDE := 1
export ENVIRONMENT_GNOME := 0

export LOCALE_ENGLAND := 1
# no other locales atm :c

export SOUND_PIPEWIRE := 1
export NETWORKING := 1
export SSH_SERVER := 0
export SMB_SERVER := 0

build_machine: 
	mkdir -p .build
	cp -r src/* .build/
	cd .build; sh ../make_machine_config.sh

install: preinstall
	cd .build; nixos-rebuild switch --impure

install_test: preinstall
	cd .build; nixos-rebuild test --impure

preinstall: clean_nixos_rebuild_result
	rm -r /etc/nixos/* || true
	rm -r .build/result || true
	cp -r .build/* /etc/nixos/

clean_nixos_rebuild_result:
	rm -r .build/result || true

clean: clean_nixos_rebuild_result
	rm -r .build || true
