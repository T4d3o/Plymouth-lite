Plymouth-lite
=============
Plymouth-lite patched and ready for Raspberry Pi

Install and configure
=====================

You need to change plymouth-lite-start.service to this

        ExecStart=/usr/bin/echo 0 > /sys/class/graphics/fbcon/cursor_blink ; /usr/bin/echo 0 > /sys/devices/virtual/graphics/fbcon/cursor_blink ; /usr/bin/chvt 7 ; /usr/bin/ply-image



Now modify /usr/lib/initcpio/init to this on line 35 (aprox) only add ply-image line

        if [ -n "$earlymodules$MODULES" ]; then
            modprobe -qab ${earlymodules//,/ } $MODULES
        fi
        ply-image /usr/share/plymouth/3.png &> /dev/null
        run_hookfunctions 'run_hook' 'hook' $HOOKS



Now modify /etc/mkinitcpio.conf to this

    # BINARIES
    # This setting includes any additional binaries a given user may
    # wish into the CPIO image.  This is run last, so it may be used to
    # override the actual binaries included by a given hook
    # BINARIES are dependency parsed, so you may safely ignore libraries
    BINARIES="ply-image"

    # FILES
    # This setting is similar to BINARIES above, however, files are added
    # as-is and are not parsed in any way.  This is useful for config files.
    FILES="/usr/share/plymouth/3.png"



Now run

Code: Select all
    mkinitcpio -g /boot/initrd -v



Now /boot/config.txt

Code: Select all
    #initramfs
    initramfs initrd 0x00f00000



And finally /boot/cmdline.txt

Code: Select all
    initrd=0x00f00000 quiet logo.nologo vt.cur_default=1


Code: Select all
    cd /usr/lib/systemd/system/sysinit.target.wants/
    ln -s ../plymouth-lite-start.service
