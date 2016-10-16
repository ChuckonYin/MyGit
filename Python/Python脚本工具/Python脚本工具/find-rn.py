
#encoding:utf8
import os
import os.path
import glob
import shutil

#ag命令出错请先安装：brew install the_silver_searcher

#####method
#查找ios图片 newDirect搜索目录，rootdir根目录
def find_pics_in_ios_direct(newDirect, rootdir):
    for i in os.listdir(newDirect):
        child_dir = os.path.join(newDirect,i)
        if os.path.isdir(child_dir):
            tail = '*.imageset'
            pics = glob.glob1(child_dir, tail)
            for pic in set(pics):
                used_name = '"'+pic[:-9]+'"'
                command = 'ag "%s" %s'%(used_name, rootdir)
                result = os.popen(command).read()
                if result == '':
                    unused_pics.append(used_name)
                    print '图片：'+used_name+'，'+'未找到'
                else:
                    print '图片：'+used_name+'，'+'已经找到'
            find_pics_in_ios_direct(child_dir, rootdir)

#查找RN图片 newDirect搜索目录，rootdir根目录
def find_pics_in_rn_direct(newDirect, rootdir):
    for i in os.listdir(newDirect):
        child_dir = os.path.join(newDirect,i)
        tail = '*.png'
        pics = glob.glob1(child_dir, tail)
        for pic in set(pics):
            used_name = pic.replace('@2x', '')
            used_name = used_name.replace('@3x', '')
            used_name = '/' + used_name
            print used_name
            command = 'ag "%s" %s'%(used_name, rootdir)
            result = os.popen(command).read()
            fullImagePath = os.path.join(child_dir,pic)
            if result == '':
                unused_pics.append(fullImagePath)
                print '图片：'+fullImagePath+'，'+'未找到'
            else:
                print '图片：'+fullImagePath+'，'+'已经找到'
        #文件夹向下查找
        if os.path.isdir(child_dir):
            find_pics_in_rn_direct(child_dir, rootdir)

#执行
unused_pics = [] #待删图片
print '---------------------------------\n如果ag命令出错请先安装：brew install the_silver_searcher\n---------------------------------'
source = raw_input('文件路径(RN:scr的路径/IOS工程路径):')
isRN = raw_input('是否是RN(YES or NO):')
if isRN == 'YES':
   find_pics_in_rn_direct(source, source)
else:
   find_pics_in_ios_direct(source, source)
if isRN =='YES':
    for eachImage in unused_pics:
        print eachImage+'\n'
else:
   print 'iOS未使用图片：'
   print unused_pics













