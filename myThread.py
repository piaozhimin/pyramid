#!/usr/bin/python
# -*- coding: UTF-8 -*-
#将所有程序分为多个进程，提高运行速度
import threading
import time
import operator 

class myThread(threading.Thread):
    def __init__(self,threadId,name,counter,objects):
        threading.Thread.__init__(self)
        self.threadId = threadId
        self.name = name
        self.counter = counter
        self.objects = objects
        self.result = []
    def run(self):
        print ("开始线程:",self.name)
        # 获得锁，成功获得锁定后返回 True
        # 可选的timeout参数不填时将一直阻塞直到获得锁定
        # 否则超时后将返回 False
        #threadLock.acquire()
        #print_time(self.name,self.counter,list.__len__())
        # 释放锁
        #threadLock.release()
        if self.counter == 2:
            self.result.append(self.objects.my_fastqc2())
            self.result.append(self.objects.get_READ_ALIGNMENT_LENGTH())
            #print(self.result)
        elif self.counter == 3:
            self.objects.use_afterqc()
        else:
            self.result.extend(self.objects.fastq_into_bam())

    def get_result(self):
        try:
            return self.result  # 如果子线程不使用join方法，此处可能会报没有self.result的错误
        except Exception:
            return None

    def __del__(self):
        print (self.name,"线程结束！")

class myThread2(threading.Thread):
    def __init__(self,threadId,name,counter,objects,layout):
        threading.Thread.__init__(self)
        self.threadId = threadId
        self.name = name
        self.counter = counter
        self.objects = objects
        self.layout = layout
    def run(self):
        print ("开始线程:",self.name)
        if self.counter == 1:
            self.objects.my_samtools()
            self.objects.my_deletion_profile()
            self.objects.my_geneBody_coverage()
            if operator.eq(self.layout,"PE"):
                self.objects.my_inner_distance()
            self.objects.my_insertion_profile()
        elif self.counter == 2:
            self.objects.my_clipping_profile()
            self.objects.my_mismatch_profile()
            self.objects.my_read_duplication()
            self.objects.my_read_GC()
            self.objects.my_read_NVC()
        elif self.counter == 3:
            self.objects.my_junction_annotation()
            self.objects.my_junction_saturation()
        else:
            self.objects.my_RPKM_saturation()   

    def __del__(self):
        print (self.name,"线程结束！")
        
class myThread3(threading.Thread):
    def __init__(self,threadId,name,counter,objects,layout):
        threading.Thread.__init__(self)
        self.threadId = threadId
        self.name = name
        self.counter = counter
        self.objects = objects
        self.layout = layout
        self.sample_name = []
    def run(self):
        print ("开始线程:",self.name)
        if self.counter == 0:
            self.sample_name.append(self.objects[0].my_fastqc())
            read_ALIGNMENT_LENGTH = self.objects[0].get_READ_ALIGNMENT_LENGTH()
            self.objects[1].set_read_ALIGNMENT_LENGTH(read_ALIGNMENT_LENGTH)
            self.objects[1].my_mismatch_profile()
        elif self.counter == 1:
            self.objects.my_samtools()
            self.objects.my_geneBody_coverage()
            if operator.eq(self.layout,"PE"):
                self.objects.my_inner_distance()
            self.objects.my_insertion_profile()
        elif self.counter == 2:
            self.objects.my_clipping_profile()
            self.objects.my_read_duplication()
            self.objects.my_read_GC()
            self.objects.my_read_NVC()
            self.objects.my_RPKM_saturation()
        else:
            self.objects.my_junction_annotation()
            self.objects.my_junction_saturation()
    def get_sample_name(self):
        try:
            return self.sample_name  # 如果子线程不使用join方法，此处可能会报没有self.result的错误
        except Exception:
            return None           

    def __del__(self):
        print (self.name,"线程结束！")