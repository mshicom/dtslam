#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Created on Thu Sep 15 13:36:50 2016

@author: nubot
"""
from libcpp cimport bool
cimport numpy as np # for np.ndarray

cdef extern from "cv3.cpp":
    cdef object pyopencv_from(const Mat& m)
    cdef int pyopencv_to(object o, Mat& m) except 0


cdef extern from "opencv2/core/core.hpp" namespace "cv" nogil:
    enum MatType:
        MAGIC_VAL = 0x42FF0000
        AUTO_STEP=0

    cdef cppclass Size_[_Tp]:
        Size_()
        Size_(_Tp width, _Tp height)
        _Tp width, height
    ctypedef Size_[ double ]    Size2d
    ctypedef Size_[ float ]    Size2f
    ctypedef Size_[ int ]    Size2i
    ctypedef Size2i    Size

    cdef cppclass Mat:
        Mat()
        Mat(Size size, int type) except +
        Mat(int rows, int cols, int type) except +
        Mat(Size size, int type, void * data) except +
        Mat(int rows, int cols, int type, void * data) except +
        Size size()
        int total()
        int elemSize()
        bool isContinuous()
        void setTo(unsigned char * data)
        void create(int rows, int cols, int type)
        unsigned char * ptr(int i0=0)
        unsigned char * data
        Mat 	clone()

    cdef cppclass Mat_[_Tp]:
        Mat_()
        Mat_ (int _rows, int _cols)
        Mat_ (int _rows, int _cols, const _Tp &value)
        Mat_ (Size _size)
        Mat_ (Size _size, const _Tp &value)
        Mat_ (int _ndims, const int *_sizes)
        Mat_ (int _ndims, const int *_sizes, const _Tp &value)
        Mat_ (const Mat &m)
        Mat_ (const Mat_ &m)
        Mat_ (const MatExpr &e)
        Mat_ & 	operator= (const Mat &m)
        Mat_ & 	operator= (const Mat_ &m)
        Mat_ & 	operator= (const _Tp &s)
        Mat_ & 	operator= (const MatExpr &e)
        pass

    cdef cppclass MatExpr:
        MatExpr()
        MatExpr (const Mat &m)

    cdef cppclass Matx33f "Matx< float, 3, 3 >":
        pass
    cdef cppclass Vec2b "Vec<uchar, 2>":
        pass
    cdef cppclass Vec2d "Vec<double, 2>":
        pass
    cdef cppclass Vec2f "Vec<float, 2>":
        pass
    cdef cppclass Vec2i "Vec<int, 2>":
        pass
    cdef cppclass Vec2s "Vec<short, 2>":
        pass
    cdef cppclass Vec2w "Vec<ushort, 2>":
        pass
    cdef cppclass Vec3b "Vec<uchar, 3>":
        pass
    cdef cppclass Vec3d "Vec<double, 3>":
        pass
    cdef cppclass Vec3f "Vec<float, 3>":
        pass
    cdef cppclass Vec3i "Vec<int, 3>":
        pass
    cdef cppclass Vec3s "Vec<short, 3>":
        pass
    cdef cppclass Vec3w "Vec<ushort, 3>":
        pass
    cdef cppclass Vec4b "Vec<uchar, 4>":
        pass
    cdef cppclass Vec4d "Vec<double, 4>":
        pass
    cdef cppclass Vec4f "Vec<float, 4>":
        pass
    cdef cppclass Vec4i "Vec<int, 4>":
        pass
    cdef cppclass Vec4s "Vec<short, 4>":
        pass
    cdef cppclass Vec4w "Vec<ushort, 4>":
        pass

    ctypedef Mat_[ uchar ] Mat1b
    ctypedef Mat_[ double ] Mat1d
    ctypedef Mat_[ float ] Mat1f
    ctypedef Mat_[ int ] Mat1i
    ctypedef Mat_[ short ] Mat1s
    ctypedef Mat_[ ushort ] Mat1w
    ctypedef Mat_[ Vec2b ] Mat2b
    ctypedef Mat_[ Vec2d ] Mat2d
    ctypedef Mat_[ Vec2f ] Mat2f
    ctypedef Mat_[ Vec2i ] Mat2i
    ctypedef Mat_[ Vec2s ] Mat2s
    ctypedef Mat_[ Vec2w ] Mat2w
    ctypedef Mat_[ Vec3b ] Mat3b
    ctypedef Mat_[ Vec3d ] Mat3d
    ctypedef Mat_[ Vec3f ] Mat3f
    ctypedef Mat_[ Vec3i ] Mat3i
    ctypedef Mat_[ Vec3s ] Mat3s
    ctypedef Mat_[ Vec3w ] Mat3w
    ctypedef Mat_[ Vec4b ] Mat4b
    ctypedef Mat_[ Vec4d ] Mat4d
    ctypedef Mat_[ Vec4f ] Mat4f
    ctypedef Mat_[ Vec4i ] Mat4i
    ctypedef Mat_[ Vec4s ] Mat4s
    ctypedef Mat_[ Vec4w ] Mat4w

    cdef cppclass InputArray:
        InputArray()
        InputArray() except +
        InputArray(Mat) except +
        Mat getMat(int i)

    cdef cppclass OutputArray(InputArray):
        OutputArray()
        OutputArray() except +
        OutputArray(Mat) except +
        Mat getMatRef(int i)

    cdef cppclass Point_[_Tp]:
        Point_ ()
        Point_ (_Tp _x, _Tp _y)
        Point_ (const Point_ &pt)
        Point_ (const Size_[_Tp] &sz)
        _Tp x,y
    ctypedef Point_[ double ] Point2d
    ctypedef Point_[ float ] 	Point2f
    ctypedef Point_[ int ] 	Point2i
    ctypedef Point2i 	Point

    cdef cppclass Point3_[_Tp]:
        Point3_ (_Tp _x, _Tp _y, _Tp _z)
        Point3_ (const Point3_ &pt)
        Point3_ (const Point_[_Tp] &pt)
        _Tp x,y,z
    ctypedef Point3_[ double ] Point3d
    ctypedef Point3_[ float ] Point3f
    ctypedef Point3_[ int ] 	Point3i

    cdef cppclass Rect_[_Tp]:
        Rect_ ()
        Rect_ (_Tp _x, _Tp _y, _Tp _width, _Tp _height)
        Rect_ (const Rect_ &r)
        Rect_ (const Point_[_Tp] &org, const Size_[_Tp] &sz)
        Rect_ (const Point_[_Tp] &pt1, const Point_[_Tp] &pt2)
        _Tp 	height, width, x, y
    ctypedef Rect_[ double ] 	Rect2d
    ctypedef Rect_[ float ] 	Rect2f
    ctypedef Rect_[ int ] 	Rect2i
    ctypedef Rect2i 	Rect

    cdef cppclass Scalar_[_Tp]:
        Scalar_()
        Scalar_ (_Tp v0, _Tp v1, _Tp v2=0, _Tp v3=0)
        Scalar_ (_Tp v0)
    ctypedef Scalar_[ double ] 	Scalar

    cdef cppclass KeyPoint:
        Point2f pt
        float size,angle,response
        int octave,class_id

cdef extern from "opencv2/imgproc/imgproc.hpp" namespace "cv" nogil:
    enum CvtColorType:
        COLOR_BGR2BGRA    =0,
        COLOR_RGB2RGBA    =COLOR_BGR2BGRA,

        COLOR_BGRA2BGR    =1,
        COLOR_RGBA2RGB    =COLOR_BGRA2BGR,

        COLOR_BGR2RGBA    =2,
        COLOR_RGB2BGRA    =COLOR_BGR2RGBA,

        COLOR_RGBA2BGR    =3,
        COLOR_BGRA2RGB    =COLOR_RGBA2BGR,

        COLOR_BGR2RGB     =4,
        COLOR_RGB2BGR     =COLOR_BGR2RGB,

        COLOR_BGRA2RGBA   =5,
        COLOR_RGBA2BGRA   =COLOR_BGRA2RGBA,

        COLOR_BGR2GRAY    =6,
        COLOR_RGB2GRAY    =7,
        COLOR_GRAY2BGR    =8,
        COLOR_GRAY2RGB    =COLOR_GRAY2BGR,
        COLOR_GRAY2BGRA   =9,
        COLOR_GRAY2RGBA   =COLOR_GRAY2BGRA,
        COLOR_BGRA2GRAY   =10,
        COLOR_RGBA2GRAY   =11,

        COLOR_BGR2BGR565  =12,
        COLOR_RGB2BGR565  =13,
        COLOR_BGR5652BGR  =14,
        COLOR_BGR5652RGB  =15,
        COLOR_BGRA2BGR565 =16,
        COLOR_RGBA2BGR565 =17,
        COLOR_BGR5652BGRA =18,
        COLOR_BGR5652RGBA =19,

        COLOR_GRAY2BGR565 =20,
        COLOR_BGR5652GRAY =21,

        COLOR_BGR2BGR555  =22,
        COLOR_RGB2BGR555  =23,
        COLOR_BGR5552BGR  =24,
        COLOR_BGR5552RGB  =25,
        COLOR_BGRA2BGR555 =26,
        COLOR_RGBA2BGR555 =27,
        COLOR_BGR5552BGRA =28,
        COLOR_BGR5552RGBA =29,

        COLOR_GRAY2BGR555 =30,
        COLOR_BGR5552GRAY =31,

        COLOR_BGR2XYZ     =32,
        COLOR_RGB2XYZ     =33,
        COLOR_XYZ2BGR     =34,
        COLOR_XYZ2RGB     =35,

        COLOR_BGR2YCrCb   =36,
        COLOR_RGB2YCrCb   =37,
        COLOR_YCrCb2BGR   =38,
        COLOR_YCrCb2RGB   =39,

        COLOR_BGR2HSV     =40,
        COLOR_RGB2HSV     =41,

        COLOR_BGR2Lab     =44,
        COLOR_RGB2Lab     =45,

        COLOR_BayerBG2BGR =46,
        COLOR_BayerGB2BGR =47,
        COLOR_BayerRG2BGR =48,
        COLOR_BayerGR2BGR =49,

        COLOR_BayerBG2RGB =COLOR_BayerRG2BGR,
        COLOR_BayerGB2RGB =COLOR_BayerGR2BGR,
        COLOR_BayerRG2RGB =COLOR_BayerBG2BGR,
        COLOR_BayerGR2RGB =COLOR_BayerGB2BGR,

        COLOR_BGR2Luv     =50,
        COLOR_RGB2Luv     =51,
        COLOR_BGR2HLS     =52,
        COLOR_RGB2HLS     =53,

        COLOR_HSV2BGR     =54,
        COLOR_HSV2RGB     =55,

        COLOR_Lab2BGR     =56,
        COLOR_Lab2RGB     =57,
        COLOR_Luv2BGR     =58,
        COLOR_Luv2RGB     =59,
        COLOR_HLS2BGR     =60,
        COLOR_HLS2RGB     =61,

        COLOR_BayerBG2BGR_VNG =62,
        COLOR_BayerGB2BGR_VNG =63,
        COLOR_BayerRG2BGR_VNG =64,
        COLOR_BayerGR2BGR_VNG =65,

        COLOR_BayerBG2RGB_VNG =COLOR_BayerRG2BGR_VNG,
        COLOR_BayerGB2RGB_VNG =COLOR_BayerGR2BGR_VNG,
        COLOR_BayerRG2RGB_VNG =COLOR_BayerBG2BGR_VNG,
        COLOR_BayerGR2RGB_VNG =COLOR_BayerGB2BGR_VNG,

        COLOR_BGR2HSV_FULL = 66,
        COLOR_RGB2HSV_FULL = 67,
        COLOR_BGR2HLS_FULL = 68,
        COLOR_RGB2HLS_FULL = 69,

        COLOR_HSV2BGR_FULL = 70,
        COLOR_HSV2RGB_FULL = 71,
        COLOR_HLS2BGR_FULL = 72,
        COLOR_HLS2RGB_FULL = 73,

        COLOR_LBGR2Lab     = 74,
        COLOR_LRGB2Lab     = 75,
        COLOR_LBGR2Luv     = 76,
        COLOR_LRGB2Luv     = 77,

        COLOR_Lab2LBGR     = 78,
        COLOR_Lab2LRGB     = 79,
        COLOR_Luv2LBGR     = 80,
        COLOR_Luv2LRGB     = 81,
        COLOR_BGR2YUV      = 82,
        COLOR_RGB2YUV      = 83,
        COLOR_YUV2BGR      = 84,
        COLOR_YUV2RGB      = 85,

        COLOR_BayerBG2GRAY = 86,
        COLOR_BayerGB2GRAY = 87,
        COLOR_BayerRG2GRAY = 88,
        COLOR_BayerGR2GRAY = 89,

        # //YUV 4:2:0 formats family
        COLOR_YUV2RGB_NV12 = 90,
        COLOR_YUV2BGR_NV12 = 91,
        COLOR_YUV2RGB_NV21 = 92,
        COLOR_YUV2BGR_NV21 = 93,
        COLOR_YUV420sp2RGB = COLOR_YUV2RGB_NV21,
        COLOR_YUV420sp2BGR = COLOR_YUV2BGR_NV21,

        COLOR_YUV2RGBA_NV12 = 94,
        COLOR_YUV2BGRA_NV12 = 95,
        COLOR_YUV2RGBA_NV21 = 96,
        COLOR_YUV2BGRA_NV21 = 97,
        COLOR_YUV420sp2RGBA = COLOR_YUV2RGBA_NV21,
        COLOR_YUV420sp2BGRA = COLOR_YUV2BGRA_NV21,

        COLOR_YUV2RGB_YV12 = 98,
        COLOR_YUV2BGR_YV12 = 99,
        COLOR_YUV2RGB_IYUV = 100,
        COLOR_YUV2BGR_IYUV = 101,
        COLOR_YUV2RGB_I420 = COLOR_YUV2RGB_IYUV,
        COLOR_YUV2BGR_I420 = COLOR_YUV2BGR_IYUV,
        COLOR_YUV420p2RGB = COLOR_YUV2RGB_YV12,
        COLOR_YUV420p2BGR = COLOR_YUV2BGR_YV12,

        COLOR_YUV2RGBA_YV12 = 102,
        COLOR_YUV2BGRA_YV12 = 103,
        COLOR_YUV2RGBA_IYUV = 104,
        COLOR_YUV2BGRA_IYUV = 105,
        COLOR_YUV2RGBA_I420 = COLOR_YUV2RGBA_IYUV,
        COLOR_YUV2BGRA_I420 = COLOR_YUV2BGRA_IYUV,
        COLOR_YUV420p2RGBA = COLOR_YUV2RGBA_YV12,
        COLOR_YUV420p2BGRA = COLOR_YUV2BGRA_YV12,

        COLOR_YUV2GRAY_420 = 106,
        COLOR_YUV2GRAY_NV21 = COLOR_YUV2GRAY_420,
        COLOR_YUV2GRAY_NV12 = COLOR_YUV2GRAY_420,
        COLOR_YUV2GRAY_YV12 = COLOR_YUV2GRAY_420,
        COLOR_YUV2GRAY_IYUV = COLOR_YUV2GRAY_420,
        COLOR_YUV2GRAY_I420 = COLOR_YUV2GRAY_420,
        COLOR_YUV420sp2GRAY = COLOR_YUV2GRAY_420,
        COLOR_YUV420p2GRAY = COLOR_YUV2GRAY_420,

        # //YUV 4:2:2 formats family
        COLOR_YUV2RGB_UYVY = 107,
        COLOR_YUV2BGR_UYVY = 108,
        # //COLOR_YUV2RGB_VYUY = 109,
        # //COLOR_YUV2BGR_VYUY = 110,
        COLOR_YUV2RGB_Y422 = COLOR_YUV2RGB_UYVY,
        COLOR_YUV2BGR_Y422 = COLOR_YUV2BGR_UYVY,
        COLOR_YUV2RGB_UYNV = COLOR_YUV2RGB_UYVY,
        COLOR_YUV2BGR_UYNV = COLOR_YUV2BGR_UYVY,

        COLOR_YUV2RGBA_UYVY = 111,
        COLOR_YUV2BGRA_UYVY = 112,
        # COLOR_YUV2RGBA_VYUY = 113,
        # COLOR_YUV2BGRA_VYUY = 114,
        COLOR_YUV2RGBA_Y422 = COLOR_YUV2RGBA_UYVY,
        COLOR_YUV2BGRA_Y422 = COLOR_YUV2BGRA_UYVY,
        COLOR_YUV2RGBA_UYNV = COLOR_YUV2RGBA_UYVY,
        COLOR_YUV2BGRA_UYNV = COLOR_YUV2BGRA_UYVY,

        COLOR_YUV2RGB_YUY2 = 115,
        COLOR_YUV2BGR_YUY2 = 116,
        COLOR_YUV2RGB_YVYU = 117,
        COLOR_YUV2BGR_YVYU = 118,
        COLOR_YUV2RGB_YUYV = COLOR_YUV2RGB_YUY2,
        COLOR_YUV2BGR_YUYV = COLOR_YUV2BGR_YUY2,
        COLOR_YUV2RGB_YUNV = COLOR_YUV2RGB_YUY2,
        COLOR_YUV2BGR_YUNV = COLOR_YUV2BGR_YUY2,

        COLOR_YUV2RGBA_YUY2 = 119,
        COLOR_YUV2BGRA_YUY2 = 120,
        COLOR_YUV2RGBA_YVYU = 121,
        COLOR_YUV2BGRA_YVYU = 122,
        COLOR_YUV2RGBA_YUYV = COLOR_YUV2RGBA_YUY2,
        COLOR_YUV2BGRA_YUYV = COLOR_YUV2BGRA_YUY2,
        COLOR_YUV2RGBA_YUNV = COLOR_YUV2RGBA_YUY2,
        COLOR_YUV2BGRA_YUNV = COLOR_YUV2BGRA_YUY2,

        COLOR_YUV2GRAY_UYVY = 123,
        COLOR_YUV2GRAY_YUY2 = 124,
        # COLOR_YUV2GRAY_VYUY = COLOR_YUV2GRAY_UYVY,
        COLOR_YUV2GRAY_Y422 = COLOR_YUV2GRAY_UYVY,
        COLOR_YUV2GRAY_UYNV = COLOR_YUV2GRAY_UYVY,
        COLOR_YUV2GRAY_YVYU = COLOR_YUV2GRAY_YUY2,
        COLOR_YUV2GRAY_YUYV = COLOR_YUV2GRAY_YUY2,
        COLOR_YUV2GRAY_YUNV = COLOR_YUV2GRAY_YUY2,

        # alpha premultiplication
        COLOR_RGBA2mRGBA = 125,
        COLOR_mRGBA2RGBA = 126,

        COLOR_COLORCVT_MAX  = 127

    void cvtColor( Mat input, Mat output, int code, int dstCn )
    void cvtColor( Mat input, Mat output, int code )
    void cvtColor( InputArray input, OutputArray output, int code, int dstCn )
    void cvtColor( InputArray input, OutputArray output, int code )

