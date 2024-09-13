#!/bin/bash
#========================================================================================================================
# https://github.com/ophub/amlogic-s9xxx-openwrt
# Description: Automatically Build OpenWrt
# Function: Diy script (After Update feeds, Modify the default IP, hostname, theme, add/remove software packages, etc.)
# Source code repository: https://github.com/openwrt/openwrt / Branch: main
#========================================================================================================================

# ------------------------------- Main source started -------------------------------
#
# Add the default password for the 'root' user（Change the empty password to 'password'）
sed -i 's/root:::0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.::0:99999:7:::/g' package/base-files/files/etc/shadow

# Set etc/openwrt_release
sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION='R$(date +%Y.%m.%d)'|g" package/base-files/files/etc/openwrt_release
echo "DISTRIB_SOURCECODE='Lienol'" >>package/base-files/files/etc/openwrt_release

# Modify default IP（FROM 192.168.2.1 CHANGE TO 192.168.31.4）
sed -i 's/192.168.2.1/192.168.31.4/g' package/base-files/files/bin/config_generate
#
# ------------------------------- Main source ends -------------------------------

# ------------------------------- Other started -------------------------------
#
# Add luci-app-amlogic
svn co https://github.com/kiddin9/openwrt-packages/tree/master/luci-theme-argon openwrt-packages/luci-theme-argon
svn co https://github.com/kiddin9/openwrt-packages/tree/master/luci-app-argon-config openwrt-packages/luci-app-argon-config
svn co https://github.com/kiddin9/openwrt-packages/tree/master/luci-app-arpbind openwrt-packages/luci-app-arpbind
svn co https://github.com/kiddin9/openwrt-packages/tree/master/luci-app-attendedsysupgrade openwrt-packages/luci-app-attendedsysupgrade
svn co https://github.com/kiddin9/openwrt-packages/tree/master/luci-app-autoreboot openwrt-packages/luci-app-autoreboot
svn co https://github.com/kiddin9/openwrt-packages/tree/master/luci-app-firewall openwrt-packages/luci-app-firewall
svn co https://github.com/kiddin9/openwrt-packages/tree/master/luci-app-netdata openwrt-packages/luci-app-netdata
svn co https://github.com/kiddin9/openwrt-packages/tree/master/luci-app-onliner openwrt-packages/luci-app-onliner
svn co https://github.com/kiddin9/openwrt-packages/tree/master/luci-app-openclash openwrt-packages/luci-app-openclash
svn co https://github.com/kiddin9/openwrt-packages/tree/master/luci-app-ramfree openwrt-packages/luci-app-ramfree
svn co https://github.com/kiddin9/openwrt-packages/tree/master/luci-app-turboacc openwrt-packages/luci-app-turboacc
svn co https://github.com/kiddin9/openwrt-packages/tree/master/luci-app-vlmcsd openwrt-packages/luci-app-vlmcsd
svn co https://github.com/kiddin9/openwrt-packages/tree/master/luci-app-watchcat openwrt-packages/luci-app-watchcat
svn co https://github.com/kiddin9/openwrt-packages/tree/master/luci-app-zerotier openwrt-packages/luci-app-zerotier
svn co https://github.com/kiddin9/openwrt-packages/tree/master/luci-app-filetransfer openwrt-packages/luci-app-filetransfer
# coolsnowwolf default software package replaced with Lienol related software package
# rm -rf feeds/packages/utils/{containerd,libnetwork,runc,tini}
# svn co https://github.com/Lienol/openwrt-packages/trunk/utils/{containerd,libnetwork,runc,tini} feeds/packages/utils

# Add third-party software packages (The entire repository)
# git clone https://github.com/libremesh/lime-packages.git package/lime-packages
# Add third-party software packages (Specify the package)
# svn co https://github.com/libremesh/lime-packages/trunk/packages/{shared-state-pirania,pirania-app,pirania} package/lime-packages/packages
# Add to compile options (Add related dependencies according to the requirements of the third-party software package Makefile)
# sed -i "/DEFAULT_PACKAGES/ s/$/ pirania-app pirania ip6tables-mod-nat ipset shared-state-pirania uhttpd-mod-lua/" target/linux/armvirt/Makefile

# Apply patch
# git apply ../config/patches/{0001*,0002*}.patch --directory=feeds/luci
#
# ------------------------------- Other ends -------------------------------
