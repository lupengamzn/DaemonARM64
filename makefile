# Initialize BGO_SPACE
export BGO_SPACE=$(shell pwd)

.PHONY: zip-linux
zip-linux:
	$(BGO_SPACE)/Tool/src/packaging/linux/build_zip_linux_arm64.sh

.PHONY: package-deb
package-deb:
	$(BGO_SPACE)/Tool/src/packaging/debian/build_deb_linux_arm64.sh

.PHONY: package-rpm
package-rpm:
	-$(BGO_SPACE)/Tool/src/packaging/linux/build_rpm_linux_arm64.sh