#!/bin/sh

rm -rf root/usr

cp ../install*.sh .

installer=install.rain.sh
echo "#!/bin/sh" >> $installer
echo "./install.node.sh node.rain.master" >> $installer

chmod +x $installer

initd=root/etc/init.d
grid=root/etc/innoaus.grid
config=$grid/config

rm ./$initd/*
cp ../$initd/innoaus.node.rain.master ./$initd

rm ./$config/*
cp ../$config/node.rain.master.conf ./$config

rm -rf ./$grid/node.*
mkdir ./$grid/node.rain.master

rm install*.sh


debian=./root/DEBIAN
rm $debian/*
echo "Package: INNOAUS-RAINPASS" >> $debian/control
echo "Version: 1.0-1" >> $debian/control
echo "Maintainer: rainpass <rainpass@innoaus.com>" >> $debian/control
echo "Architecture: amd64" >> $debian/control
echo "Description: RAINPASS" >> $debian/control
echo "    A Very Simple and Secure Authentication System." >> $debian/control


preinst=$debian/preinst
prerm=$debian/prerm
postinst=$debian/postinst
postrm=$debian/postrm

echo "#!/bin/sh" >> $preinst
chmod +x $preinst

echo "#!/bin/sh" >> $prerm
echo "service innoaus.node.rain.master stop" >> $prerm
echo "update-rc.d -f innoaus.node.rain.master  remove" >> $prerm
chmod +x $prerm

echo "#!/bin/sh" >> $postinst
echo "update-rc.d innoaus.node.rain.master defaults 80" >> $postinst
echo "  " >> $postinst
echo "chown -R root:root /etc/innoaus.grid/node.rain.master" >> $postinst
chmod +x $postinst

echo "#!/bin/sh" >> $postrm
chmod +x $postrm

# make debian package
dpkg-deb -b root .

