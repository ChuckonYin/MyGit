
#encoding:utf8
import os
import os.path
import glob
import shutil

#ag命令出错请先安装：brew install the_silver_searcher

#####method
#查找ios图片 newDirect搜索目录，rootdir根目录
def find_pics_in_ios_direct(newDirect):
    for i in os.listdir(newDirect):
        child_dir = os.path.join(newDirect,i)
        if os.path.isdir(child_dir):
            if i=='.git':
                print '===============删除成功================'
                uipath = unicode(child_dir, "utf8")
                shutil.rmtree(uipath)#删除
            else:
                find_pics_in_ios_direct(child_dir)
#执行
print '---------------------------------\n如果ag命令出错请先安装：brew install the_silver_searcher\n---------------------------------'
source = raw_input('文件路径:')
find_pics_in_ios_direct(source)














