TOTAL_SPACE = 70000000
REQUIRED = 30000000
class File:
    def __init__(self, file_name, size) -> None:
        self.file_name = file_name
        self.size = size

class Directory:
    def __init__(self, directory_name) -> None:
        self.directory_name = directory_name
        self.files = []
        self.directories = {}
        self.prev = None 
    def cd(self,directory):
        return self.prev if directory == '..' else self.directories[directory]
    def add_directory(self, directory):
        self.directories[directory.directory_name] = directory
        directory.prev = self
    def add_file(self,file):
        self.files.append(file)
    def get_size(self):
        size = 0
        for d in self.directories:
            size += self.directories[d].get_size()
        for file in self.files:
            size += file.size
        return size

    def task1(self, val):
        dirs = 0
        for d in self.directories.values():
            if (s := d.get_size()) <= val:
                dirs += s
            if len(d.directories) != 0:
                dirs += d.task1(val)
        return dirs
    def task2(self, unused):
        minim = self.get_size()
        for d in self.directories.values():
            if (m :=d.task2(unused)) + unused >= REQUIRED:
                minim = min(minim, m)
        return minim

def main():
    root = currDir = Directory('/')
    currDir = root
    with open('day7/inputs/7') as f:
        while l := f.readline().rstrip():
            if 'cd' in l[2:4] and '/' not in l:
                into = l[5:]
                currDir = currDir.cd(into)
            elif ('ls' != l[2:4]) and ('cd' != l[2:4]): 
                if 'dir' in l:
                    dir = l[4:]
                    currDir.add_directory(Directory(dir))
                else: 
                    size, file_name = l.split(' ')
                    currDir.add_file(File(file_name, int(size)))
    print(root.task1(100000))
    print(root.task2(TOTAL_SPACE - root.get_size()))
main()