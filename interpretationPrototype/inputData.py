'''
PHASE # 1
'''

#TODO: Exponential expression handling
#TODO: Exponent of exponent handling

'''
This file specifies the input data.

-Data from the OCR stage is of the following format:

-Dictionary Structure >>  key : [x1(0), x2(1), y1(2), y2(3), symbol(4), symbolType(5), x_centroid(6), y_centroid(7), breakableType(b/nb)(8), baseLineElement(b/u)(9)]

-Key value of dictionary is selected based on sorted x1 values

-------------------------------------------------------------------------------------------------------------------------
- The data types of each element in the dictionary is:
key -> String
x1,x2,y1,y2 -> Int
symbol -> String
symbolType -> String
x_centroid, y_centroid -> Float
breakableType -> String ( output can be either 'break' or 'no_break')
baseLineElement -> Optional! Not in use

-------------------------------------------------------------------------------------------------------------------------
-Use the following commands in your code to access this data:
import inputData as id
dataDictionary = id.data

-------------------------------------------------------------------------------------------------------------------------
Symbol Types:

‘N’ - numbers
‘Root’ - roots
‘O’ - [+,-,*,%]
‘longDivision’ = [/]
‘Bracket’ = [,],{,},(,)

'''

def data():
    dataStore = {}
    x1 = [652,738,775,870,962,1111,1339,1410,1472,1550];
    x2= [709,788,825,1111,1062,1174,1389,1440,1537,1572];
    y1 = [402,366,460,384,420,445,425,481,448,441];
    y2 = [505,432,479,520,506,523,527,507,529,533];
    symbol = ['9','3','-','root','5','+','7','.','0','1'];
    symbolType = ['n','n','o','root','n','o','n','o','n','n'];

    for i in range(0,len(x1)):
        dataStore[str(i)] = [x1[i],x2[i],y1[i],y2[i],symbol[i],symbolType[i]]
    return(dataStore)











