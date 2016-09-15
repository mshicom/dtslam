#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Created on Thu Sep 15 21:52:33 2016

@author: nubot
"""

from libcpp cimport bool
from opencv cimport *

cdef extern from "../dtslam/SlamMapExpander.h" namespace "dtslam":

SlamMapExpander