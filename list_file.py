import sys
import os
import pyperclip


def get_size(start_path='.'):
    """计算目录大小"""

    size = 0
    for path, dirs, files in os.walk(start_path):
        for f in files:
            fp = os.path.join(path, f)
            size += os.path.getsize(fp)
    return size


def convert_size(size_bytes):
    """将字节数转换为更合适的显示方式"""

    if size_bytes >= 1024*1024*1024:
        return '{:.2f} GB'.format(size_bytes/(1024*1024*1024))
    elif size_bytes >= 1024*1024:
        return '{:.2f} MB'.format(size_bytes/(1024*1024))
    elif size_bytes >= 1024:
        return '{:.2f} KB'.format(size_bytes/1024)
    else:
        return '{:,.2f} bytes'.format(size_bytes)


def list_files(startpath):
    """列出目录及子目录下所有文件"""

    file_list = []
    for root, dirs, files in os.walk(startpath):
        level = root.replace(startpath, '').count(os.sep)
        indent = '│   ' * (level)
        foldername = os.path.basename(root)
        folder_size = get_size(root)
        folder_size_str = convert_size(folder_size)
        total_size_str = convert_size(sum(
            [os.path.getsize(os.path.join(root, name)) for name in files]))
        file_list.append(f"{indent}├─{foldername}\\ ({len(dirs)} folders, {len(files)} files, {total_size_str}, {folder_size_str} in total.)")
        subindent = '│   ' * (level + 1)
        for f in files:
            filesize = os.path.getsize(os.path.join(root, f))
            filesize_str = convert_size(filesize)
            file_list.append(f"{subindent}│\t{f}\t{filesize_str}")
            # print(subindent + '│' + f + '\t' + filesize_str)

    # 将列表转换为字符串，并复制到剪切板中
    file_list_str = '\n'.join(file_list)
    pyperclip.copy(file_list_str)


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print('Usage: python list_files.py [directory]')
        sys.exit(1)
    startpath = sys.argv[1]
    list_files(startpath)
