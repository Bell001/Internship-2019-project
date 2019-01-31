import sys
import json
import xml.etree.ElementTree as ET

filename=str(sys.argv[1])
tree = ET.parse(filename)
root = tree.getroot()
r=1
data = {}
mainchild = ""
c=0
def recept_member(root,r,mainchild,c,n):
       for child in root:

           '''Check xml level'''
           #print '-' * int(r), child.tag, child.attrib, child.text 
           
           data[child.tag]=[]
           
           if len(child) > 1:
                mainchild=child
                recept_member(child,r+1,mainchild,c,len(child))
                mainchild=""
           else:
               if child.attrib:
                   add_data=child.attrib
               elif child.text:
                   add_data=child.text
        
               data[child.tag].append(add_data)
               if mainchild != "":
                       add_data = {}
                       add_data[child.tag]=data[child.tag]
                       data[mainchild.tag].append(dict(add_data))
                       del data[child.tag]
               c+=1
               if n == c:
                     c=0
                     if mainchild.attrib:
                            data[mainchild.tag].append(mainchild.attrib)
                     break;
           

recept_member(root,r,mainchild,c,0)

with open('weather.json', 'w') as outfile:
    json.dump(data, outfile)
    jstr = json.dumps(data, ensure_ascii=False, indent=4)
    jstr = jstr.replace("[", "{")
    jstr = jstr.replace("]", "}")
    print(jstr)
