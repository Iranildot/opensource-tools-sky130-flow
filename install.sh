#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "You must run this script as a superuser."
   exit 1
fi

cd $HOME
mkdir opensource
cd ./opensource

##################################################
# SOLVING DEPENDENCIES
##################################################

echo "_______________Solving Dependencies_______________"

apt update
apt install -y \
  build-essential \
  qtbase5-dev \
  qttools5-dev \
  qtchooser \
  ruby \
  python3 \
  python3-dev \
  python3-pyqt5 \
  git \
  libz-dev \
  libcurl4-openssl-dev \
  libexpat1-dev \
  m4 \
  libx11-dev \
  tcl-dev \
  tk-dev \
  libcairo2-dev \
  mesa-common-dev \
  libgl-dev \
  libglu1-mesa-dev \
  zlib1g-dev \
  libncurses-dev \
  autoconf \
  automake \
  libtool \
  pkg-config \
  bison \
  flex \
  libreadline-dev \
  libfftw3-dev \
  libxaw7-dev \
  xorg-dev \
  gawk \
  libxrender-dev \
  libxext-dev \
  libxt-dev \
  freeglut3-dev \
  libglib2.0-dev \
  libx11-6 \
  libxrender1 \
  libxcb1 \
  libx11-xcb-dev \
  libxpm4 \
  libxpm-dev \
  libjpeg-dev \
  tcl8.6 \
  tcl8.6-dev \
  tk8.6 \
  tk8.6-dev \
  vim-gtk3

##################################################
# INSTALLING NGSPICE
##################################################

echo "_______________Installing Ngspice_______________"

git clone git://git.code.sf.net/p/ngspice/ngspice

cd ./ngspice
./autogen.sh --adms
mkdir release
cd release
../configure --with-x --enable-xspice --disable-debug --enable-cider --with-readline=yes --enable-openmp --enable-adms
make 2>&1 | tee make.log
make install
cd ../../

##################################################
# INSTALLING NETGEN
##################################################

echo "_______________Installing Netgen_______________"

git clone https://github.com/RTimothyEdwards/netgen.git

cd ./netgen
./configure
make
make install
cd ..

##################################################
# INSTALLING MAGIC
##################################################

echo "_______________Installing Magic_______________"

git clone https://github.com/RTimothyEdwards/magic.git

cd ./magic
./configure
make
make install
cd ..

##################################################
# INSTALLING XSCHEM
##################################################

echo "_______________Installing Xschem_______________"

git clone https://github.com/StefanSchippers/xschem.git

cd ./xschem
./configure
make
make install
cd ..

##################################################
# INSTALLING KLAYOUT
##################################################

echo "_______________Installing Klayout_______________"

git clone https://github.com/KLayout/klayout.git

cd ./klayout
./build.sh
cd ..

##################################################
# INSTALLING OPENPDKS
##################################################

echo "_______________Installing Open PDKs_______________"

git clone https://github.com/RTimothyEdwards/open_pdks.git

cd ./open_pdks
./configure --enable-sky130-pdk --enable-sram-sky130
make
make install
make veryclean
cd ..
