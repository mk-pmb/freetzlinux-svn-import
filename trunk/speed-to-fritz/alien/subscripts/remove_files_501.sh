#!/bin/bash
. ${include_modpatch}
echo2 "  -- removing files ..."
for DIR in ${OEMLISt}; do
  export HTML="$DIR/html"
    DSTI="${1}"/usr/www/$HTML
    if [ -d ${DSTI} ]; then
#-----------------------------------------
echo "-- /usr/www/$HTML/$avm_Lang/..."
rm -rf $VERBOSE ${1}/usr/www/$HTML/$avm_Lang/software | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/$HTML/$avm_Lang/usb | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/$HTML/$avm_Lang/tr69_autoconfig | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/$HTML/$avm_Lang/dect | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/$HTML/$avm_Lang/menus/menu2_usb* | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/$HTML/$avm_Lang/menus/menu2_usb.inc | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/$HTML/$avm_Lang/menus/menu2_software* | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/$HTML/$avm_Lang/menus/menu2_tr69* | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/$HTML/$avm_Lang/home/fon1Dect* | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/$HTML/$avm_Lang/home/usb* | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/$HTML/$avm_Lang/home/fon1tam* | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/$HTML/$avm_Lang/home/tam* | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/$HTML/$avm_Lang/home/fonab* | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/$HTML/$avm_Lang/home/isdn* | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/$HTML/$avm_Lang/home/fonlistisdn* | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/$HTML/$avm_Lang/home/fon1isdn* | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/$HTML/$avm_Lang/home/buchsend* | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/$HTML/$avm_Lang/fon/fon1Dect* | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/$HTML/$avm_Lang/fon/usb* | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/$HTML/$avm_Lang/fon/fon1tam* | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/$HTML/$avm_Lang/fon/tam* | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/$HTML/$avm_Lang/fon/fonab* | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/$HTML/$avm_Lang/fon/isdn* | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/$HTML/$avm_Lang/fon/fonlistisdn* | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/$HTML/$avm_Lang/fon/fon1isdn* | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/$HTML/$avm_Lang/fon/buchsend* | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/$HTML/$avm_Lang/fon_config/fon_config_Isdn* | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/$HTML/tam.html | sed "s/.*\//\t'/"
if [ $TCOM_V_MINOR -eq 38 ] && [ $AVM_V_MINOR -eq 33 ]; then
rm -rf $VERBOSE ${1}/usr/www/$HTML/$avm_Lang/tools | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/$HTML/$avm_Lang/first | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/kids | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/www/$HTML/tools | sed "s/.*\//\t'/"
fi
#---------------------------------------------
    fi
[ ${OEM} != ${DIR} ] && rm -rf $VERBOSE ${1}/etc/default.${CONFIG_PRODUKT}/$DIR
done
rm -rf $VERBOSE ${1}/sbin/wlan_cal | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/sbin/tracking | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/sbin/finalize_env | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/sbin/printserv | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/sbin/hotplug | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/bin/usbhostchange | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/share/ctlmgr/libctlusb* | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/share/ctlmgr/libtr069* | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/share/ctlmgr/libdect* | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/share/ctlmgr/libtam* | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/share/telefon/libtam* | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/share/telefon/tam* | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/share/tam | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/usr/bin/tr069fwupdate | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/etc/default.049/fx_conf.default.1 | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/etc/default.049/fx_lcr.default.1 | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/etc/default.049/fx_lcr.aol | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/etc/usbclass.tab | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/etc/usbdevice.tab | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/etc/hotplug | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/lib/modules/2.6.13.1-ohio/modules.usbmap | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/lib/modules/2.6.13.1-ohio/kernel/drivers/scsi | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/lib/modules/2.6.13.1-ohio/kernel/drivers/usb | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/lib/modules/2.6.13.1-ohio/kernel/drivers/cdrom | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/lib/modules/2.6.13.1-ohio/kernel/drivers/char/audio | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/lib/modules/2.6.13.1-ohio/kernel/drivers/char/flash_update | sed "s/.*\//\t'/"
rm -rf $VERBOSE ${1}/lib/modules/2.6.13.1-ohio/kernel/fs | sed "s/.*\//\t'/"
exit 0
