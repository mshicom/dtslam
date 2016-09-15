#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Created on Thu Sep 15 13:29:39 2016

@author: nubot
"""
from libcpp cimport bool
from opencv cimport *

cdef extern from "../dtslam/CameraModel.h" namespace "dtslam":
    cdef cppclass RadialCameraDistortionModel[double]:
        void init(float k1, float k2)
        Point2f distortPoint(const Point3f &x)
        Point3f undistortPoint(const Point2f &pd) const;
        float getMaxRadiusSq()
        void setMaxRadius(float maxRadiusSq)

    cdef cppclass NullCameraDistortionModel:
        pass

    cdef cppclass CameraModel:
        void init(float fx, float fy, float u0, float v0, int width, int height)
        void initLUT();

        const Size &getImageSize()
        float getMaxRadiusSq(const Size2i &imageSize)

#        Matx33f getK()
        bool isPointInside(const Point3f &xc, const Point2f &p)
        RadialCameraDistortionModel &getDistortionModel()
        Point2f projectFrom3D(const Point3f &xc)
        void projectFromWorldJacobian(const Point3f &xc, Vec3f &ujac, Vec3f &vjac)
        void projectFromWorldJacobianLUT(const Point2i &uv, Vec3f &ujac, Vec3f &vjac)
        Point3f unprojectTo3D(const Point2f &uv)
        Point3f unprojectToWorldLUT(const Point2i &uv)




