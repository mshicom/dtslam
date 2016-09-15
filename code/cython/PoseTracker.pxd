#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Created on Thu Sep 15 14:55:15 2016

@author: nubot
"""

cdef extern from "../dtslam/PoseTracker.h" namespace "dtslam" nogil:
    cdef cppclass PoseTracker:
        pass

