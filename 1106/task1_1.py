#!/usr/bin/env python

import ctypes

ffi = ctypes.CDLL('./task1_1.so')

intarray10 = ctypes.c_int * 10
a_ = [1,3,5,7,9,2,4,6,8,0]
a = intarray10(*a_)
print [a[i] for i in range(len(a))]
ffi.quick_sort(a,len(a))
print [a[i] for i in range(len(a))]
