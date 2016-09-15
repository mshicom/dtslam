#!/usr/bin/env python
# -*- coding: utf-8 -*-

import numpy as np
cimport numpy as np # for np.ndarray
from libcpp.vector cimport vector
from cpython.ref cimport PyObject
from libcpp cimport bool
from libcpp.string cimport string
# Function to be called at initialization

np.import_array()

from SlamSystem cimport *
from opencv cimport *


cdef extern from "<glog/logging.h>" namespace 'google':
    cdef void InitGoogleLogging(const char* argv0)


cdef class dtslam:
    cdef SlamSystem slam
    cdef CameraModel cam
    cdef SlamMap *mMap
    cdef SlamRegion *mRegion
    cdef PoseTracker *mTracker
    def __init__(self, np.ndarray[np.float_t, ndim=2] K,
                       np.ndarray[np.uint8_t, ndim=2] kf,
                       string args, double timestamp=0, double k1=0, double k2=0):
        InitGoogleLogging(args.c_str())

        h, w = kf.shape[:2]
        fx,fy,cx,cy = K[0,0],K[1,1],K[0,2],K[1,2]
        self.cam.init(fx, fy, cx, cy, w, h)
        self.cam.getDistortionModel().init(k1, k2)
        self.cam.getDistortionModel().setMaxRadius(self.cam.getMaxRadiusSq(Size(h,w)))
        self.cam.initLUT()

        cdef Mat imG,imC;
        pyopencv_to(kf, imG)

        cvtColor(imG, imC, COLOR_GRAY2BGR)
        cdef Mat3b imgColor = imC
        cdef Mat1b imgGray = imG
        self.slam.init(&self.cam, timestamp, imgColor, imgGray)
        self.slam.setSingleThreaded(True)

        self.mMap = &self.slam.getMap()
        self.mRegion = self.mMap.getRegions().front().get()
        self.mTracker = &self.slam.getTracker()

    def processImage(self, np.ndarray[char, ndim=2] kf, double timestamp=0):
        cdef Mat imG, imC;
        pyopencv_to(kf, imG)

        cvtColor(imG, imC, COLOR_GRAY2BGR)
        cdef Mat3b imgColor = imC
        cdef Mat1b imgGray = imG
        self.slam.processImage(timestamp, imgColor, imgGray)

    def runExpanderAndBA(self):
        self.slam.idle()

    def getKeyPoints(self, int octave=0):
        cdef SlamKeyFrame *new = self.mRegion.getKeyFrames().back().get()
        cdef vector[KeyPointData] *kpd = &new.getKeyPoints(octave)

        return [(kpd[0][p].position.x, kpd[0][p].position.y) for p in range(kpd.size())]


