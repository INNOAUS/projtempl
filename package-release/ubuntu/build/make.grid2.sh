#!/bin/sh

initd="root/etc/init.d"
grid="root/etc/innoaus.grid"
config=$grid/config

rm -rf ./root
cp -r ../root root

debian=./root/DEBIAN
rm $debian/*
echo "Package: INNOAUS-GRID-REGISTRY" >> $debian/control
echo "Version: 1.0-1" >> $debian/control
echo "Maintainer: innoaus <dev@innoaus.com>" >> $debian/control
echo "Architecture: amd64" >> $debian/control
echo "Description: INNOAUS GRID SYSTEM" >> $debian/control
echo "    Innoaus Grid Registry" >> $debian/control


preinst=$debian/preinst
prerm=$debian/prerm
postinst=$debian/postinst
postrm=$debian/postrm

echo "#!/bin/sh" >> $preinst
chmod +x $preinst

echo "#!/bin/sh" >> $prerm
echo "service innoaus.registry stop" >> $prerm
echo "update-rc.d -f innoaus.registry remove" >> $prerm
chmod +x $prerm

echo "#!/bin/sh" >> $postinst
echo "update-rc.d innoaus.registry defaults 80" >> $postinst
echo " " >> $postinst
echo "chown -R root:root /etc/innoaus.grid" >> $postinst
echo "chown -R root:root /var/log/innoaus.grid" >> $postinst
echo "service innoaus.registry start" >> $postinst

chmod +x $postinst

echo "#!/bin/sh" >> $postrm
chmod +x $postrm

# make debian package
dpkg-deb -b root .

