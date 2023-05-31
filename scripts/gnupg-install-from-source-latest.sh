#!/bin/bash

signatures_uri=https://gnupg.org/signature_key.asc
gnupg_uri=https://gnupg.org/ftp/gcrypt/gnupg/gnupg-2.4.1.tar.bz2
gnup_sig_uri=https://gnupg.org/ftp/gcrypt/gnupg/gnupg-2.4.1.tar.bz2.sig
npth_uri=https://gnupg.org/ftp/gcrypt/npth/npth-1.6.tar.bz2
libgpg_error_uri=https://gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.47.tar.bz2
libgcrypt_uri=https://gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.10.2.tar.bz2
libksba_uri=https://gnupg.org/ftp/gcrypt/libksba/libksba-1.6.3.tar.bz2
libassuan_uri=https://gnupg.org/ftp/gcrypt/libassuan/libassuan-2.5.5.tar.bz2
pinentry_uri=https://gnupg.org/ftp/gcrypt/pinentry/pinentry-1.2.1.tar.bz2
ncurses_uri=http://ftp.gnu.org/gnu/ncurses/ncurses-6.3.tar.gz

signatures=signature_key.asc
gnupg_dir=gnupg-2.4.1
gnupg_zip=gnupg-2.4.1.tar.bz2 
gnupg_sig=gnupg-2.4.1.tar.bz2.sig 

npth_zip=npth-1.6.tar.bz2
npth_dir=npth-1.6
libgpg_error_zip=libgpg-error-1.47.tar.bz2
libgpg_error_dir=libgpg-error-1.47
libgcrypt_zip=libgcrypt-1.10.2.tar.bz2
libgcrypt_dir=libgcrypt-1.10.2
libksba_zip=libksba-1.6.3.tar.bz2
libksba_dir=libksba-1.6.3
libassuan_zip=libassuan-2.5.5.tar.bz2
libassuan_dir=libassuan-2.5.5
pinentry_zip=pinentry-1.2.1.tar.bz2
pinentry_dir=pinentry-1.2.1
ncurses_zip=ncurses-6.3.tar.gz
ncurses_dir=ncurses-6.3

echo "........................"
echo "|remove prev tar files |"
echo "........................"
sleep 6

rm -rf $gnupg_dir
rm -rf $gnupg_zip $gnupg_sig $signature

echo "................"
echo "|get tar files |"
echo "................"
sleep 6

wget $gnupg_uri
wget $gnup_sig_uri
wget $signatures_uri

gpg --import $signatures
gpg --verify $gnupg_sig $gnupg_zip

tar -xf $gnupg_zip
cd $gnupg_dir

echo "........................"
echo "|remove prev tar files |"
echo "........................"
sleep 6

rm -rf $npth_zip $libgpg_error_zip $libgcrypt_zip $libksba_zip $libksba_zip $pinentry_zip
# rm -rf npth-1.6 libgpg-error-1.44 libgcrypt-1.6.0 libksba-1.6.3 libassuan-2.5.5 pinentry-1.2.1

echo "................"
echo "|get tar files |"
echo "................"
sleep 6

wget $npth_uri
sleep 5
wget $libgpg_error_uri
sleep 5
wget $libgcrypt_uri
sleep 5
wget $libksba_uri
sleep 5
wget $libksba_uri
sleep 5

echo ".................."
echo "|installing npth |"
echo ".................."
sleep 6

tar -xf $npth_zip
cd $npth_dir
./configure
make
sudo make install
cd ..

echo ".........................."
echo "|installing libgpg-error |"
echo ".........................."
sleep 6

tar -xf $libgpg_error_zip
cd $libgpg_error_dir
./configure
make
sudo make install
cd ..

echo "......................."
echo "|installing libgcrypt |"
echo "......................."
sleep 6

tar -xf $libgcrypt_zip
cd $libgcrypt_dir
./configure
make
sudo make install
cd ..

echo "....................."
echo "|installing libksba |"
echo "....................."
sleep 6

tar -xf $libksba_zip
cd $libksba_dir
./configure
make
sudo make install
cd ..

echo "......................."
echo "|installing libassuan |"
echo "......................."
sleep 6

tar -xf $libassuan_zip
cd $libassuan_dir
./configure
make
sudo make install
cd ..

echo "................................"
echo "|installing pinentry + ncurses |"
echo "................................"
sleep 6

wget $pinentry_uri
tar -xf $pinentry_zip
cd $pinentry_dir
sleep 5

wget $ncurses_uri
sleep 2
tar -zxvf $ncurses_zip
cd $ncurses_dir
./configure
make
sudo make install
cd ..

./configure \
  --enable-pinentry-curses 
  --enable-pinentry-x11
  --enable-pinentry-gnome3
  --enable-pinentry-qt
  --sysconfdir=/etc --localstatedir=/var
make
sudo make install
cd ..



echo "..................."
echo "|installing GNUPG |"
echo "..................."
sleep 6

./configure
make
sudo make install
sudo ldconfig

sleep 6
echo ".........................."
echo "|Finneshed install GNUPG |"
echo ".........................."
echo "           .              "
echo "           .              "
echo "           .              "
echo "           .              "
echo "           .              "
echo "           v              "

sleep 6

echo ".........................................."
echo "| #which gpg						                 |"
echo "| #cd /usr/local/bin/				             |"
echo "| #symlink gpg to /usr/bin	             |"
echo "| #gpg -> gpg 2					                 |"
echo "| # cp gpg dirmngr /usr/local/bin /usr/bin"
echo ".........................................."


#which gpg
#cd /usr/local/bin/
#symlink gpg to /usr/bin
#gpg -> gpg 2
