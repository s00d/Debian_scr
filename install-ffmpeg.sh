# 
# touch install-ffmpeg.sh
# chmod +x install-ffmpeg.sh
# ./install-ffmpeg.sh
#
#


apt-get update
apt-get -y install autoconf automake build-essential libass-dev libfreetype6-dev libgpac-dev \
  libtheora-dev libtool libvorbis-dev \
  pkg-config texi2html zlib1g-dev unzip nasm
mkdir ~/ffmpeg_sources
cd ~/ffmpeg_sources
wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
wget http://download.videolan.org/pub/x264/snapshots/last_x264.tar.bz2
wget -O fdk-aac.zip https://github.com/mstorsjo/fdk-aac/zipball/master
wget http://downloads.xiph.org/releases/opus/opus-1.1.tar.gz
wget http://webm.googlecode.com/files/libvpx-v1.3.0.tar.bz2
wget http://ffmpeg.org/releases/ffmpeg-2.3.3.tar.bz2

cd ~/ffmpeg_sources
tar xzvf yasm-1.3.0.tar.gz
cd yasm-1.3.0
./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin"
make
make install
make distclean

cd ~/ffmpeg_sources
tar xjvf last_x264.tar.bz2
cd x264-snapshot*
PATH="$PATH:$HOME/bin" ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --enable-static --disable-opencl
PATH="$PATH:$HOME/bin" make
make install
make distclean

cd ~/ffmpeg_sources
unzip fdk-aac.zip
cd mstorsjo-fdk-aac*
autoreconf -fiv
./configure --prefix="$HOME/ffmpeg_build" --disable-shared
make
make install
make distclean

cd ~/ffmpeg_sources
tar xzvf lame-3.99.5.tar.gz
cd lame-3.99.5
./configure --prefix="$HOME/ffmpeg_build" --enable-nasm --disable-shared
make
make install
make distclean

cd ~/ffmpeg_sources
tar xzvf opus-1.1.tar.gz
cd opus-1.1
./configure --prefix="$HOME/ffmpeg_build" --disable-shared
make
make install
make distclean

cd ~/ffmpeg_sources
tar xjvf libvpx-v1.3.0.tar.bz2
cd libvpx-v1.3.0
PATH="$PATH:$HOME/bin" ./configure --prefix="$HOME/ffmpeg_build" --disable-examples
PATH="$PATH:$HOME/bin" make
make install
make clean

cd ~/ffmpeg_sources
tar xjvf ffmpeg-2.3.3.tar.bz2
cd ffmpeg*
PATH="$PATH:$HOME/bin" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
  --prefix="$HOME/ffmpeg_build" \
  --extra-cflags="-I$HOME/ffmpeg_build/include" \
  --extra-ldflags="-L$HOME/ffmpeg_build/lib" \
  --bindir="$HOME/bin" \
  --enable-gpl \
  --enable-libass \
  --enable-libfdk-aac \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libtheora \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libx264 \
  --enable-nonfree \
  --enable-version3 \
  --enable-postproc 
PATH="$PATH:$HOME/bin" make
make install
make distclean
hash -r
