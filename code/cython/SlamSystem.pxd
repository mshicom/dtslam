#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Created on Thu Sep 15 13:15:16 2016

@author: nubot
"""
from opencv cimport *
from libcpp cimport bool
from CameraModel cimport *
from SlamMap cimport *
from PoseTracker cimport *
from Pose3D cimport *
from SlamKeyFrame cimport *

cdef extern from "../dtslam/SlamSystem.h" namespace "dtslam":
    cdef cppclass SlamSystem:
        SlamSystem()
        bool init(const CameraModel *camera, double timestamp, Mat3b &imgColor, Mat1b &imgGray)

        bool isSingleThreaded()
        void setSingleThreaded(bool value)

        bool isExpanderRunning()
        bool isExpanderAdding()
        bool isBARunning()

        SlamMap &getMap()
        PoseTracker &getTracker()
#        SlamMapExpander &getMapExpander()

        SlamRegion *getActiveRegion()
        void setActiveRegion(SlamRegion *region)

        void processImage(double timestamp, Mat3b &imgColor, Mat1b &imgGray)

        #Handles thread creation and other maintenance. This should be called when idle and after processImage().
        void idle()

        unique_ptr[SlamMap] mMap
        SlamRegion *mActiveRegion
        unique_ptr[PoseTracker] mTracker;


