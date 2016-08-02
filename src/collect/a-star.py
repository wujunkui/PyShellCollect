# coding:gb2312
import math

#��ͼ
tm = [
'############################################################',
'#..........................................................#',
'#.............................#............................#',
'#.............................#............................#',
'#.............................#............................#',
'#.......S.....................#............................#',
'#.............................#............................#',
'#.............................#............................#',
'#.............................#............................#',
'#.............................#............................#',
'#.............................#............................#',
'#.............................#............................#',
'#.............................#............................#',
'#######.#######################################............#',
'#....#........#............................................#',
'#....#........#............................................#',
'#....##########............................................#',
'#..........................................................#',
'#..........................................................#',
'#..........................................................#',
'#..........................................................#',
'#..........................................................#',
'#...............................##############.............#',
'#...............................#........E...#.............#',
'#...............................#............#.............#',
'#...............................#............#.............#',
'#...............................#............#.............#',
'#...............................###########..#.............#',
'#..........................................................#',
'#..........................................................#',
'############################################################']

#��Ϊpython��string����ֱ�Ӹı�ĳһԪ�أ�������test_map���洢����ʱ�ĵ�ͼ
test_map = []

#########################################################
class Node_Elem:
    """
    �����б�͹ر��б��Ԫ�����ͣ�parent�����ڳɹ���ʱ�����·��
    """
    def __init__(self, parent, x, y, dist):
        self.parent = parent
        self.x = x
        self.y = y
        self.dist = dist
        
class A_Star:
    """
    A���㷨ʵ����
    """
    #ע��w,h����������������޸��˵�ͼ����Ҫ����һ����ȷֵ�����޸������Ĭ�ϲ���
    def __init__(self, s_x, s_y, e_x, e_y, w=60, h=30):
        self.s_x = s_x
        self.s_y = s_y
        self.e_x = e_x
        self.e_y = e_y
        
        self.width = w
        self.height = h
        
        self.open = []
        self.close = []
        self.path = []
        
    #����·������ں���
    def find_path(self):
        #������ʼ�ڵ�
        p = Node_Elem(None, self.s_x, self.s_y, 0.0)
        while True:
            #��չFֵ��С�Ľڵ�
            self.extend_round(p)
            #��������б�Ϊ�գ��򲻴���·��������
            if not self.open:
                return
            #��ȡFֵ��С�Ľڵ�
            idx, p = self.get_best()
            #�ҵ�·��������·��������
            if self.is_target(p):
                self.make_path(p)
                return
            #�Ѵ˽ڵ�ѹ��ر��б����ӿ����б���ɾ��
            self.close.append(p)
            del self.open[idx]
            
    def make_path(self,p):
        #�ӽ�������ݵ���ʼ�㣬��ʼ���parent == None
        while p:
            self.path.append((p.x, p.y))
            p = p.parent
        
    def is_target(self, i):
        return i.x == self.e_x and i.y == self.e_y
        
    def get_best(self):
        best = None
        bv = 1000000 #������޸ĵĵ�ͼ�ܴ󣬿�����Ҫ�޸����ֵ
        bi = -1
        for idx, i in enumerate(self.open):
            value = self.get_dist(i)#��ȡFֵ
            if value < bv:#����ǰ�ĸ��ã���Fֵ��С
                best = i
                bv = value
                bi = idx
        return bi, best
        
    def get_dist(self, i):
        # F = G + H
        # G Ϊ�Ѿ��߹���·�����ȣ� HΪ���ƻ�Ҫ�߶�Զ
        # �����ʽ����A*�㷨�ľ����ˡ�
        # return i.dist + math.sqrt(
            # (self.e_x-i.x)*(self.e_x-i.x)
            # + (self.e_y-i.y)*(self.e_y-i.y))*1.2
        return i.dist + (abs(self.e_x-i.x)+ abs(self.e_y-i.y))
        
    def extend_round(self, p):
        #���Դ�8��������
        # xs = (-1, 0, 1, -1, 1, -1, 0, 1)
        # ys = (-1,-1,-1,  0, 0,  1, 1, 1)
        #ֻ�������������ĸ�����
        xs = (0, -1, 1, 0)
        ys = (-1, 0, 0, 1)
        for x, y in zip(xs, ys):
            new_x, new_y = x + p.x, y + p.y
            #��Ч���߲�����������������
            if not self.is_valid_coord(new_x, new_y):
                continue
            #�����µĽڵ�
            node = Node_Elem(p, new_x, new_y, p.dist+self.get_cost(
                        p.x, p.y, new_x, new_y))
            #�½ڵ��ڹر��б������
            if self.node_in_close(node):
                continue
            i = self.node_in_open(node)
            if i != -1:
                #�½ڵ��ڿ����б�
                if self.open[i].dist > node.dist:
                    #���ڵ�·��������ǰ������ڵ��·������~
                    #��ʹ�����ڵ�·��
                    self.open[i].parent = p
                    self.open[i].dist = node.dist
                continue
            self.open.append(node)
            
    def get_cost(self, x1, y1, x2, y2):
        """
        ��������ֱ�ߣ�����Ϊ1.0��б�ߣ�����Ϊ1.4
        """
        if x1 == x2 or y1 == y2:
            return 1.0
        return 1.4
        
    def node_in_close(self, node):
        for i in self.close:
            if node.x == i.x and node.y == i.y:
                return True
        return False
        
    def node_in_open(self, node):
        for i, n in enumerate(self.open):
            if node.x == n.x and node.y == n.y:
                return i
        return -1
        
    def is_valid_coord(self, x, y):
        if x < 0 or x >= self.width or y < 0 or y >= self.height:
            return False
        return test_map[y][x] != '#'
    
    def get_searched(self):
        l = []
        for i in self.open:
            l.append((i.x, i.y))
        for i in self.close:
            l.append((i.x, i.y))
        return l
        
#########################################################
def print_test_map():
    """
    ��ӡ������ĵ�ͼ
    """
    for line in test_map:
        print ''.join(line)

def get_start_XY():
    return get_symbol_XY('S')
    
def get_end_XY():
    return get_symbol_XY('E')
    
def get_symbol_XY(s):
    for y, line in enumerate(test_map):
        try:
            x = line.index(s)
        except:
            continue
        else:
            break
    return x, y
        
#########################################################
def mark_path(l):
    mark_symbol(l, '*')
    
def mark_searched(l):
    mark_symbol(l, ' ')
    
def mark_symbol(l, s):
    for x, y in l:
        test_map[y][x] = s
    
def mark_start_end(s_x, s_y, e_x, e_y):
    test_map[s_y][s_x] = 'S'
    test_map[e_y][e_x] = 'E'
    
def tm_to_test_map():
    for line in tm:
        test_map.append(list(line))
        
def find_path():
    s_x, s_y = get_start_XY()
    e_x, e_y = get_end_XY()
    a_star = A_Star(s_x, s_y, e_x, e_y)
    a_star.find_path()
    searched = a_star.get_searched()
    path = a_star.path
    #�������������
    mark_searched(searched)
    #���·��
    mark_path(path)
    print "path length is %d"%(len(path))
    print "searched squares count is %d"%(len(searched))
    #��ǿ�ʼ��������
    mark_start_end(s_x, s_y, e_x, e_y)
    
if __name__ == "__main__":
    #���ַ���ת���б�
    tm_to_test_map()
    find_path()
    print_test_map()