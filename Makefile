APP_ID := io.gitlab.Goodvibes

RUNTIME_PLATFORM := org.freedesktop.Platform
RUNTIME_SDK      := org.freedesktop.Sdk
RUNTIME_VERSION  := 20.08

BUILD_DIR := build
REPO_DIR  := repo

all: $(APP_ID).flatpak

$(APP_ID).flatpak: $(BUILD_DIR) $(REPO_DIR)
	flatpak build-bundle $(REPO_DIR) $@ $(APP_ID)

$(BUILD_DIR) $(REPO_DIR): $(APP_ID).yaml
	flatpak-builder --force-clean --repo=$(REPO_DIR) $(BUILD_DIR) $^
	flatpak build-update-repo $(REPO_DIR)

.PHONY: install
install: $(APP_ID).flatpak
	flatpak install $^

.PHONY: uninstall
uninstall:
	flatpak remove $(APP_ID)

.PHONY: clean
clean:
	$(RM) -fr $(BUILD_DIR) $(REPO_DIR) $(APP_ID).flatpak

.PHONY: run
run:
	flatpak run $(APP_ID)

.PHONY: debug
debug:
	flatpak run --devel --command=bash $(APP_ID)

.PHONY: setup
setup:
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak install flathub $(RUNTIME_PLATFORM)//$(RUNTIME_VERSION)
	flatpak install flathub $(RUNTIME_SDK)//$(RUNTIME_VERSION)
