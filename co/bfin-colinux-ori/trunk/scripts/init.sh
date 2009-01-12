#!/bin/sh
# assumption: $PWD is the colinux install dir

status_msg() {
	echo " * $*"
}

clear

# get the settings from the installer
touch colinux.settings
. ./colinux.settings

# required binaries for initrd
status_msg "Unpacking utilities"
tar xf init.tar -C /

# work our magic
status_msg "Initializing swap file"
mkswap /dev/${CL_SWAP}

status_msg "Formatting root file system"
mke2fs -F -j /dev/${CL_ROOT} -O dir_index

status_msg "Populating root file system with base image"
mkdir /bfin-colinux-setup
mount -t ext3 /dev/${CL_ROOT} /bfin-colinux-setup
tar pxf blackfin-root.tar -C /bfin-colinux-setup
tar xf blackfin-configs.tar -C /bfin-colinux-setup

status_msg "Configuring files and directories"
cp passwd.exp /bfin-colinux-setup/
cat <<EOSF >/bfin-colinux-setup/setup.sh
# Setup tftp server
mkdir -p /tftpboot
chmod 777 /tftpboot
if [ -e /var/lib/tftpboot ] ; then
	rmdir /var/lib/tftpboot
	ln -s /tftpboot /var/lib/tftpboot
fi
sed -i -e '/^RUN_DAEMON/s:no:yes:' /etc/default/tftpd-hpa

# Generate ssh keys
[ -e /etc/ssh/ssh_host_dsa_key ] || ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N ''
[ -e /etc/ssh/ssh_host_rsa_key ] || ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''

# Setup user accounts
if [ -e /lib/security/pam_smbpass.so ] && [ -e /etc/pam.d/common-password ] &&
   ! grep -qs pam_smbpass.so /etc/pam.d/common-password
then
	# have `passwd` update samba passwords as well
	echo 'password required /lib/security/pam_smbpass.so nullok use_authtok try_first_pass' >> /etc/pam.d/common-password
fi
root_pw=\$(head -c 4 /dev/urandom | od -t x | awk '{print \$2}')
/passwd.exp root \${root_pw}
useradd -m uclinux -s /bin/bash -c "Blackfin Linux development account,,," -G audio,cdrom,dialout,floppy,plugdev,uucp,video
uclinux_pw=\$(head -c 4 /dev/urandom | od -t x | awk '{print \$2}')
/passwd.exp uclinux \${uclinux_pw}
smbpasswd -a -s uclinux << EOF
\${uclinux_pw}
\${uclinux_pw}
EOF
rm -f passwd.exp
echo 'uclinux ALL=(ALL) ALL' >> /etc/sudoers
cat <<EOF >> /etc/issue
The root password is autogenerated: \${root_pw}
The uclinux password is autogenerated: \${uclinux_pw}
Please log in, change these, and then update the /etc/issue file.

EOF

# Setup eth1 (tuntap)
cat <<EOF >> /etc/network/interfaces
auto eth1
iface eth1 inet static
   address ${CL_LINIP}
   netmask 255.255.255.0
EOF

# Default mount points
if ! grep '^/dev/cofs0' /etc/fstab ; then
	mkdir -p /mnt/windows
	echo '/dev/cofs0 /mnt/windows cofs defaults 0 0' >> /etc/fstab
fi

# Debian lists
if [ -d /etc/apt/sources.list.d ] ; then
	cat <<-EOF > /etc/apt/sources.list.d/blackfin.sources.list
	# Normal releases
	deb http://download.analog.com/27516/distros/debian stable main

	# Nightly snapshots
	#deb http://download.analog.com/27516/distros/debian unstable main
	EOF
fi

EOSF
chroot /bfin-colinux-setup /bin/bash /setup.sh
rm -f /bfin-colinux-setup/setup.sh
umount /bfin-colinux-setup

# all done, clean up
status_msg "All done, time to exit!"
cd /
sync
umount -a
umount /proc
sync
reboot
