#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Created on Fri Sep  9 15:39:34 2016

@author: kaihong
"""
from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

import sys
import numpy
import subprocess

proc_libs = subprocess.check_output("pkg-config --libs opencv".split())
proc_incs = subprocess.check_output("pkg-config --cflags opencv".split())

prefix="/home/nubot/software/opencv3/"
Libs = "-L"+prefix+"lib -lopencv_calib3d -lopencv_features2d -lopencv_objdetect -lopencv_highgui -lopencv_imgproc  -lopencv_core "
opencv_libs = [lib for lib in Libs.split()]
opencv_incs = [prefix+"include"]


ext_modules = [
    Extension("SlamSystem",
              sources = ["SlamSystem.pyx"],
              language='c++',
              include_dirs = [ "../dtslam/",
                              "/usr/include/eigen3/",
                              numpy.get_include(),]
                              + opencv_incs,
              library_dirs = ["/home/nubot/data/workspace/dtslam/code/build/dtslam", prefix+'lib'],
              libraries = ['glog','gflags',"spqr","tbb","tbbmalloc","cholmod","ccolamd","camd","colamd","amd","lapack"],
              extra_objects = ["/home/nubot/data/workspace/dtslam/code/build/dtslam/libdtslam.a",
                              "/usr/local/lib/libceres.a"],
#                                "/usr/lib/x86_64-linux-gnu/libglog.a",
#                              "/usr/lib/x86_64-linux-gnu/libgflags.a"],
              extra_link_args =  opencv_libs,
              extra_compile_args = ["-std=c++11","-fPIC"]
)]

setup(
  name = 'dtslam for python',
  ext_modules = cythonize(ext_modules),
)
