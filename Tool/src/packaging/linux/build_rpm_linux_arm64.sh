#!/usr/bin/env bash
echo "*************************************************"
echo "Creating rpm file for Amazon Linux and RHEL arm64"
echo "*************************************************"

rm -rf ${BGO_SPACE}/bin/linux_arm64/linux

echo "Creating rpmbuild workspace"
mkdir -p ${BGO_SPACE}/bin/linux_arm64/linux/rpmbuild/{RPMS,SRPMS,BUILD,COORD_SOURCES,SPECS,DATA_SOURCES}
mkdir -p ${BGO_SPACE}/bin/linux_arm64/linux/usr/bin/
mkdir -p ${BGO_SPACE}/bin/linux_arm64/linux/etc/amazon/xray/
mkdir -p ${BGO_SPACE}/bin/linux_arm64/linux/etc/init/
mkdir -p ${BGO_SPACE}/bin/linux_arm64/linux/etc/systemd/system/

echo "Copying application files"
cp ${BGO_SPACE}/build/xray/xray ${BGO_SPACE}/bin/linux_arm64/linux/usr/bin/
cp ${BGO_SPACE}/build/xray/cfg.yaml ${BGO_SPACE}/bin/linux_arm64/linux/etc/amazon/xray/cfg.yaml
cp ${BGO_SPACE}/Tool/src/packaging/linux/xray.conf ${BGO_SPACE}/bin/linux_arm64/linux/etc/init/
cp ${BGO_SPACE}/Tool/src/packaging/linux/xray.service ${BGO_SPACE}/bin/linux_arm64/linux/etc/systemd/system/

echo "Creating the rpm package"
SPEC_FILE="${BGO_SPACE}/Tool/src/packaging/linux/xray.spec"
BUILD_ROOT="${BGO_SPACE}/bin/linux_arm64/linux"
setarch aarch64 rpmbuild --define "rpmversion `cat ${BGO_SPACE}/VERSION`" --define "_topdir bin/linux_arm64/linux/rpmbuild" -bb --buildroot ${BUILD_ROOT} ${SPEC_FILE}

echo "Copying rpm files to bin"
cp ${BGO_SPACE}/bin/linux_arm64/linux/rpmbuild/RPMS/aarch64/*.rpm ${BGO_SPACE}/build/xray/aws-xray-daemon-arm64-`cat ${BGO_SPACE}/VERSION`.rpm
cp ${BGO_SPACE}/bin/linux_arm64/linux/rpmbuild/RPMS/aarch64/*.rpm ${BGO_SPACE}/build/xray/aws-xray-daemon-arm64-3.x.rpm