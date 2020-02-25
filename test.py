#!/usr/bin/python
# -*- coding: UTF-8 -*-


def use_help():
	with open("help.txt", "r") as f:  # 打开文件
		data = f.read()  # 读取文件
	print(data)
	return
use_help()
