define SNAPD_TEST_SETUP
- snap wait system seed.loaded
- snap install core24
packages:
- snapd
endef

define SNAPD_TEST_SETUP_WITH_BETA_SNAPD
- snap wait system seed.loaded
- snap install --beta snapd
- snap install core24
packages:
- snapd
endef

define DEBIAN_CLOUD_INIT_USER_DATA_TEMPLATE
$(CLOUD_INIT_USER_DATA_TEMPLATE)
$(SNAPD_TEST_SETUP_WITH_BETA_SNAPD)
endef

define UBUNTU_CLOUD_INIT_USER_DATA_TEMPLATE
$(CLOUD_INIT_USER_DATA_TEMPLATE)
$(SNAPD_TEST_SETUP_WITH_BETA_SNAPD)
endef

define FEDORA_CLOUD_INIT_USER_DATA_TEMPLATE
$(CLOUD_INIT_USER_DATA_TEMPLATE)
- ln -s /var/lib/snapd/snap /snap
$(SNAPD_TEST_SETUP)
endef
