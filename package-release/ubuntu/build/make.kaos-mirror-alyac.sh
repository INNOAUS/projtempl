#!/bin/sh

gitreporoot=../../../..

cp ../install*.sh .

installer=install.kaos.sh

rm -rf root

echo "#!/bin/sh" >> $installer
echo "./install.node.sh node.kaos.mirror" >> $installer

chmod +x $installer

mkdir root
mkdir root/DEBIAN
mkdir root/etc
mkdir root/etc/init.d
mkdir root/etc/innoaus.grid
mkdir root/etc/innoaus.grid/bin

initd="root/etc/init.d"
grid="root/etc/innoaus.grid"
config=$grid/config

rm install*.sh

cp $gitreporoot/kaos/bin/kaos-mirror $grid/bin
cp $gitreporoot/kaos/bin/kaos-mirror-admin $grid/bin
cp $gitreporoot/kaos/bin/kaos-mirror-alyac-java.jar $grid/bin

cp $gitreporoot/kaos/src/kaos-mirror/kaos-mirror-prop.conf root/etc

debian=./root/DEBIAN
rm $debian/*
echo "Package: KAONI-KAOS-ICC-ALYAC" >> $debian/control
echo "Version: 1.0-1" >> $debian/control
echo "Maintainer: Kaos Supporter <kaos@kaoni.com>" >> $debian/control
echo "Architecture: amd64" >> $debian/control
echo "Description: KAOS-ICC" >> $debian/control
echo "    KAOS-ICC : A KAONI PMS SUBSYSTEMS : Internet Connection Controller" >> $debian/control


preinst=$debian/preinst
prerm=$debian/prerm
postinst=$debian/postinst
postrm=$debian/postrm

echo "#!/bin/sh" >> $preinst
chmod +x $preinst

echo "#!/bin/sh" >> $prerm
echo "service innoaus.node.kaos.mirror stop" >> $prerm
echo "update-rc.d -f innoaus.node.kaos.mirror  remove" >> $prerm
chmod +x $prerm

echo "#!/bin/sh" >> $postinst
echo "update-rc.d innoaus.node.kaos.mirror defaults 80" >> $postinst
echo "  " >> $postinst
echo "chown -R root:root /etc/innoaus.grid/node.kaos.mirror" >> $postinst
echo "ln -s /etc/innoaus.grid/bin/kaos-mirror-admin /usr/bin/kaos-admin" >> $postinst
chmod +x $postinst

echo "#!/bin/sh" >> $postrm
chmod +x $postrm

# make debian package
dpkg-deb -b root .

