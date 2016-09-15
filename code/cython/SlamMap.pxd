#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Created on Thu Sep 15 13:29:39 2016

@author: nubot
"""
from libcpp cimport bool
from opencv cimport *
from libcpp.vector cimport vector
from libcpp.memory cimport unique_ptr
from libcpp.unordered_set cimport unordered_set
from SlamKeyFrame cimport *

cdef extern from "../dtslam/SlamMap.h" namespace "dtslam":
    cdef cppclass SlamRegion:
        int getId()
        void setId(int id)
        const vector[unique_ptr[SlamKeyFrame]] &getKeyFrames()
        const vector[unique_ptr[SlamFeature]] &getFeatures2D()
        const vector[unique_ptr[SlamFeature]] &getFeatures3D()
        void getFeaturesInView(const Pose3D &pose,
                               const CameraModel &camera,
                               const int octaveCount,
                               bool onlyNearest2DSection,
                               const unordered_set[SlamFeature*] &featuresToIgnore,
                               vector[vector[FeatureProjectionInfo]] &featuresInView);

    cdef cppclass SlamMap:
        SlamMap()
        const vector[unique_ptr[SlamRegion]] &getRegions()

    cdef cppclass SlamFeatureMeasurement:
        SlamFeature &getFeature()
        SlamKeyFrame &getKeyFrame()
        const Pose3D &getFramePose()
        const CameraModel &getCamera()
        int getPositionCount()
        int getOctave()
        const Mat1b &getImage()
        const vector[Point2f] &getPositions()
        const vector[Point3f] &getPositionXns()

    cdef cppclass SlamFeature:
        SlamRegion *getRegion()
        void setRegion(SlamRegion *region)
        bool is3D()

        SlamFeatureStatus getStatus()
        void setStatus(SlamFeatureStatus value)
        void setStatus(int inlierMeasurementCount);

        const Point3f &getPosition()
        void setPosition(const Point3f &value)

        Point3f getNormal()
        Point3f getPlusOneOffset()
        Point3f getPositionPlusOne()

        int getOctaveFor2DFeature() const;

        const vector[unique_ptr[SlamFeatureMeasurement]] &getMeasurements()
        SlamFeatureMeasurement *getBestMeasurementForMatching(const Vec3f &poseCenter)

        float GetTriangulationAngle(const SlamFeatureMeasurement &m1, const SlamFeatureMeasurement &m2)
        float getMinTriangulationAngle(const SlamFeatureMeasurement &m1)
        void getMeasurementsForTriangulation(SlamFeatureMeasurement *&m1, SlamFeatureMeasurement *&m2, float &angle)
        void getMeasurementsForTriangulation(const SlamFeatureMeasurement &m1, SlamFeatureMeasurement *&m2, float &angle)

    cdef struct PointProjection:
        vector[Point2f] positions

    cdef struct EpipolarProjection:
        Vec3f epiPlaneNormal
        Point3f minDepthXn
        Point3f infiniteXn

#    enum EProjectionType:
#        Invalid
#        EpipolarLine
#        PointProjection
#        PreviousMatch

    cdef cppclass FeatureProjectionInfo:
#        EProjectionType getType()
        SlamFeature &getFeature()
        SlamFeatureMeasurement &getSourceMeasurement()
        int getOctave()
        int getTrackLength()

        const PointProjection &getPointData()
        const EpipolarProjection &getEpipolarData()

    enum SlamFeatureStatus:
        Invalid
        NotTriangulated
        TwoViewTriangulation
        ThreeViewAgreement
        ThreeViewDisagreement
        MultiViewAgreement
        MultiViewDisagreement





