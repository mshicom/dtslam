#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Created on Thu Sep 15 17:46:43 2016

@author: nubot
"""
import sys
import numpy as np
import scipy
import matplotlib.pyplot as plt
from scipy.weave import inline
from SlamSystem import dtslam
sys.path.append("/home/nubot/data/workspace/gltes")

from tools import *

frames, G, K, Z =  loaddata1()
frames = [np.ascontiguousarray(f) for f in frames]
im = frames[0]
slam = dtslam(K,im,"",0)

slam.processImage(frames[1], 1)
k =  slam.getKeyPoints(1)
x,y = zip(*k)
plt.imshow(frames[0])
plt.plot(x,y,'b.',ms=2)
