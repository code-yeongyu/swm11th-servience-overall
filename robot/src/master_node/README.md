# SETTING
### Boost build  
```sh
$ wget https://sourceforge.net/projects/boost/files/boost/1.61.0/boost_1_61_0.tar.bz2/download
# downlaod 이름의 파일로 받아진다. 그러니 이름을 변경해 두자.
$ mv download boost_1_61_0.tar.bz2
$ tar -xvf boost_1_61_0.tar.bz2
$ cd boost_1_61_0
$ ./bootstrap.sh
$ ./b2 install
```  

### REST SDK build
```sh
$ git clone https://git.codeplex.com/casablanca
$ cd casablanca/Release
$ mkdir build.release
$ cd build.release
$ cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local ..
$ make & make install
```

### How to compile?
```sh
g++ -std=c++11 {object.cpp} -o {name} -lboost_system -lcrypto -lssl -lcpprest
```