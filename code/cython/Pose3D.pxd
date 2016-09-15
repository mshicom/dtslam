#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Created on Thu Sep 15 22:10:14 2016

@author: nubot
"""
from libcpp cimport bool
from opencv cimport *

cdef extern from "../dtslam/Pose3D.h" namespace "dtslam":
    cdef cppclass Pose3D:
        pass
    cdef cppclass FullPose3D:
        FullPose3D()
        FullPose3D(const Matx33f &R, const Vec3f &T)
        FullPose3D(const Pose3D &pose)
        Matx33f &getRotationRef()
        const Matx33f &getRotationRef()
        Vec3f &getTranslationRef()
        const Vec3f &getTranslationRef()

    cdef FullPose3D MakeRelativePose "FullPose3D::MakeRelativePose"(const Pose3D &ref, const Pose3D &img)

