# Setup Caffe tutorial

## install dependencies
```
sudo apt install liblmdb-dev libleveldb-dev libgflags-dev libhdf5-dev hdf5-tools hdf5-helpers libboost-dev libhdf5-100 libhdf5-cpp-100 libhdf5-dev libhdf5-openmpi-100 libgoogle-glog-dev libboost-python-dev
```

## setup protobuf 2.6.1
1. download [protobuf 2.6.1](https://github.com/google/protobuf/archive/v2.6.1.zip), unzip and enter the folder.
2. edit `autogen.sh` like this:
```
# Check that gtest is present.  Usually it is already there since the
# directory is set up as an SVN external.
if test ! -e gtest; then
  tar xzvf googletest-release-1.5.0.tar.gz
  mv googletest-release-1.5.0 gtest
fi
```

3. run `./autogen.sh` and try to run `./configure` if nothing wrong happen, congratulations! You can go to '#4'
4. download [googletest-release-1.5.0.tar.gz](https://github.com/google/googletest/archive/release-1.5.0.tar.gz) and move it to protobuf folder
5. run `./configure --prefix=/path/you/like` again to set install index 
6. run `make -j8` to compile it
7. run `make install` to install it, maybe it requires admin authority

## setup caffe compile configurations
`Makefile.config` example (only shows changed lines)

```
# cuDNN acceleration switch (uncomment to build with cuDNN).
USE_CUDNN := 1

# Uncomment if you're using OpenCV 3
OPENCV_VERSION := 3

# CUDA directory contains bin/ and lib/ directories that we need.
CUDA_DIR := /usr/local/cuda

# CUDA architecture setting: going with all of them.
# For CUDA < 6.0, comment the *_50 through *_61 lines for compatibility.
# For CUDA < 8.0, comment the *_60 and *_61 lines for compatibility.
CUDA_ARCH := \
		-gencode arch=compute_30,code=sm_30 \
		-gencode arch=compute_35,code=sm_35 \
		-gencode arch=compute_50,code=sm_50 \
		-gencode arch=compute_52,code=sm_52 \
		-gencode arch=compute_60,code=sm_60 \
		-gencode arch=compute_61,code=sm_61 \
		-gencode arch=compute_61,code=compute_61


# NOTE: this is required only if you will compile the python interface.
# We need to be able to find Python.h and numpy/arrayobject.h.
# PYTHON_INCLUDE := /usr/include/python2.7 \
# 		/usr/lib/python2.7/dist-packages/numpy/core/include
# Anaconda Python distribution is quite popular. Include path:
# Verify anaconda location, sometimes it's in root.
# ANACONDA_HOME := $(HOME)/anaconda
# PYTHON_INCLUDE := $(ANACONDA_HOME)/include \
		# $(ANACONDA_HOME)/include/python2.7 \
		# $(ANACONDA_HOME)/lib/python2.7/site-packages/numpy/core/include

# Uncomment to use Python 3 (default is Python 2)
PYTHON_LIBRARIES := boost_python3 python3.6m
PYTHON_INCLUDE := /home/zhfeing/caffe_env/include/python3.6m \
                 /home/zhfeing/caffe_env/lib/python3.6/site-packages/numpy/core/include


# We need to be able to find libpythonX.X.so or .dylib.
PYTHON_LIB := /home/zhfeing/caffe_env/lib/python3.6/config-3.6m-x86_64-linux-gnu
# PYTHON_LIB := $(ANACONDA_HOME)/lib

# Homebrew installs numpy in a non standard path (keg only)
# PYTHON_INCLUDE += $(dir $(shell python -c 'import numpy.core; print(numpy.core.__file__)'))/include
# PYTHON_LIB += $(shell brew --prefix numpy)/lib

# Uncomment to support layers written in Python (will link against Python libs)
WITH_PYTHON_LAYER := 1

# Whatever else you find you need goes here.
INCLUDE_DIRS := $(PYTHON_INCLUDE) /usr/local/include /usr/include/hdf5/serial  /media/Programme/linux_program/protobuf-2.6.1/include
LIBRARY_DIRS := $(PYTHON_LIB) /usr/local/lib /usr/lib  /media/Programme/linux_program/protobuf-2.6.1/lib
```

## edit Makefile
1. change：

```
NVCCFLAGS +=-ccbin=$(CXX) -Xcompiler-fPIC $(COMMON_FLAGS)
```
to:
```
NVCCFLAGS += -D_FORCE_INLINES -ccbin=$(CXX) -Xcompiler -fPIC $(COMMON_FLAGS)
```
2. change：
```
LIBRARIES += glog gflags protobuf boost_system boost_filesystem m hdf5_hl hdf5
```
to: 
```
LIBRARIES += glog gflags protobuf boost_system boost_filesystem m hdf5_serial_hl hdf5_serial
```

## compile
```
make all -j8
make runtest -j8
make pycaffe -j8
pip install -r requirements.txt

```
if it shows incompatible while installing requirements, try to edit it as follows:
```
python-dateutil>=1.4,<2
Cython>=0.19.2
numpy>=1.7.1
scipy>=0.13.2
scikit-image>=0.9.3,<0.12
matplotlib>=1.3.1, <2.0
ipython>=3.0.0
h5py>=2.2.0
leveldb>=0.191
networkx>=1.8.1
nose>=1.3.0
pandas>=0.12.0, <0.14.0
protobuf>=2.5.0
python-gflags>=2.0
pyyaml>=3.10
Pillow>=2.3.0
six>=1.1.0
```
after done all steps above, add `caffe/python` to `PYTHONPATH`

## check
```
python
```
enter
```
import caffe
```
if it shows error: try run

```
pip install -U python-dateutil
```
