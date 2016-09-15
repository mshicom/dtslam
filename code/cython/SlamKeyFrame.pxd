#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Created on Thu Sep 15 22:08:59 2016

@author: nubot
"""

from opencv cimport *
from libcpp.vector cimport vector
from libcpp.memory cimport unique_ptr
from CameraModel cimport *
from Pose3D cimport *
from SlamMap cimport *

cdef extern from "../dtslam/ImagePyramid.h" namespace "dtslam":
    cdef cppclass ImagePyramid[T]:
        int GetOctaveCount(int level0Width, int maxTopLevelWidth)
        int getOctaveCount()
        const Mat_[T] &operator [](int octave)
        Mat_[T] &getTopLevel()
        const Mat_[T] &getTopLevel()
        void create(const Mat_[T] &level0, int maxTopLevelWidth)
    ctypedef ImagePyramid[uchar] ImagePyramid1b
    ctypedef ImagePyramid[Vec2b] ImagePyramid2b
    ctypedef ImagePyramid[Vec3b] ImagePyramid3b

cdef extern from "../dtslam/SlamKeyFrame.h" namespace "dtslam":
    cpdef cppclass KeyPointData:
        Point2i position
        int score
        int octave
        Point3f xn
        const Point2i &getPosition()
        int getScore()

    cdef cppclass SlamKeyFrame:
        void init(const CameraModel *camera, const Mat3b &imageColor, const Mat1b &imageGray)
        const Mat1b &getSBI()
        const Mat1s &getSBIdx()
        const Mat1s &getSBIdy()
        const Mat3b &getColorImage()
        const ImagePyramid1b &getPyramid()
        const Mat1b &getImage(int octave)
        int getOctaveCount()
        vector[KeyPointData] &getKeyPoints(int octave)
        Pose3D &getPose()
        vector[SlamFeatureMeasurement *] &getMeasurements()


