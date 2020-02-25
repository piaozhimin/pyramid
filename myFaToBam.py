#!/usr/bin/python
# -*- coding: UTF-8 -*-
#比对，将fastq变为bam
import os
import sys
import re
import operator 
import subprocess
import tempfile
#检测文件是否存在的模块
from pathlib import Path
import threading
import time

class myFaToBam():
    def __init__(self,out_rseqc,input_fastq,index_path,in_key):
        self.out_rseqc = out_rseqc
        self.input_fastq = input_fastq
        self.index_path = index_path
        self.in_key = in_key
    #################################################
    #Functions
    def os_system(self,my_str):
    # popen返回文件对象，跟open操作一样
        f = os.popen(my_str).read()
        return f
    #################################################
    def judge_dir(self,file_path):
        try:
            my_file = Path(file_path)
            if my_file.exists():
                in_key = input("\""+file_path+"\",the folder already exists. Do you want to overwrite the files under it?[y|n]  ")
                while in_key not in ('yes','y'):
                    if in_key in ('n','no'):
                        exit()
                    in_key = input('\nEnter error, please enter again![y|n]  ')
                print('#############################################################################################')
            else:
                self.os_system('mkdir '+file_path)
        except:
            print('Error,folder creation failed.('+file_path+')')
        return
    #################################################
    def fastq_into_bam(self):
        samples = self.input_fastq.replace(","," ")
        if self.in_key=='t':
            self.judge_dir(self.out_rseqc+'tophat')            
            print('bash my_tophat -i \''+samples+'\' -o '+self.out_rseqc+'tophat -d '+self.index_path)
            self.os_system('bash my_tophat -i \''+samples+'\' -o '+self.out_rseqc+'tophat -d '+self.index_path)
            return [self.out_rseqc+'tophat/',self.out_rseqc+'tophat/align_summary.txt']
        else:
            self.judge_dir(self.out_rseqc+'star')
            print("Please create the index of star by yourself, the path is '/home/liyunfan/my_project/starIndex'.")
            self.os_system('STAR --runThreadN 20 --genomeDir ./starIndex/hg19_100 --readFilesIn '+samples+' --outFileNamePrefix '+self.out_rseqc+'star/out --outSAMtype BAM Unsorted')
            return [self.out_rseqc+'star/',self.out_rseqc+'star/outLog.final.out']