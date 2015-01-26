#!/bin/sh

rm -rf root/usr

cp ../install*.sh .

installer=install.kaos.sh

echo "#!/bin/sh" >> $installer
echo "./install.node.sh node.kaos.master" >> $installer

chmod +x $installer

initd="root/etc/init.d"
grid="root/etc/innoaus.grid"
config=$grid/config

rm ./$initd/*
cp ../$initd/innoaus.node.kaos.master ./$initd/

rm ./$config/*
cp ../$config/node.kaos.master.conf ./$config

rm -rf ./$grid/node.*
mkdir ./$grid/node.kaos.master

rm install*.sh

debian=./root/DEBIAN
rm $debian/*
echo "Package: KAONI-KAOS" >> $debian/control
echo "Version: 1.0-1" >> $debian/control
echo "Maintainer: Kaos Supporter <kaos@kaoni.com>" >> $debian/control
echo "Architecture: amd64" >> $debian/control
echo "Description: KAOS" >> $debian/control
echo "    KAOS : KAONI PMS SYSTEMS" >> $debian/control


preinst=$debian/preinst
prerm=$debian/prerm
postinst=$debian/postinst
postrm=$debian/postrm

echo "#!/bin/sh" >> $preinst
chmod +x $preinst

echo "#!/bin/sh" >> $prerm
echo "service innoaus.node.kaos.master stop" >> $prerm
echo "update-rc.d -f innoaus.node.kaos.master  remove" >> $prerm
chmod +x $prerm

echo "#!/bin/sh" >> $postinst
echo "update-rc.d innoaus.node.kaos.master defaults 80" >> $postinst
echo "  " >> $postinst
echo "chown -R root:root /etc/innoaus.grid/node.kaos.master" >> $postinst
chmod +x $postinst

echo "#!/bin/sh" >> $postrm
chmod +x $postrm

# make debian package
dpkg-deb -b root .

