'''
PHASE # 1
'''

#TODO: Exponential expression handling
#TODO: Exponent of exponent handling

'''
This file specifies the input data.

-Data from the OCR stage is of the following format:

-Dictionary Structure >>  key : [x1(0), x2(1), y1(2), y2(3), symbol(4), symbolType(5), x_centroid(6), y_centroid(7), breakableType(b/nb)(8), baseLineElement(b/u)(9)]

-y1 greater than y2

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
    # x1 = [652,738,775,870,962,1111,1339,1410,1472,1550];
    # x2= [709,788,825,1111,1062,1174,1389,1440,1537,1572];
    # y1 = [402,366,460,384,420,445,425,481,448,441];
    # y2 = [505,432,479,520,506,523,527,507,529,533];
    # symbol = ['9','3','-','root','5','+','7','.','0','1'];
    # symbolType = ['N','N','O','Root','N','O','N','O','N','N'];
    #
    # x1 = [100,125,150, 170, 183, 189, 210, 220, 225, 243, 254, 270, 278,  292, 268, 285, 305, 350, 360, 365, 368, 380, 388, 400]
    # x2 = [120,140, 155, 185, 190, 200, 215, 340, 240, 253, 265, 275, 290, 310, 275, 300, 315, 357, 364, 415, 377, 384, 399, 410]
    # y1 = [100, 110, 110, 110, 100, 90, 110, 110, 85,   77, 120, 127, 121, 120, 95,   85, 77,  105, 99,  95,  105, 112, 103, 103]
    # y2 = [140, 120, 120, 120, 139, 105, 115, 115, 103, 86, 130, 131, 131, 130, 100, 100, 86,  107, 108, 115, 115, 115, 112,  110]
    # symbol = ['(','2','+', '3', ')','2','-','/','3','3', '5','.','0','5','-','2','2','-','4','Root','5','.','1','0']
    # symbolType = ['Bracket','N','O','N','Bracket', 'N', 'O','longDivision', 'N', 'N','N','O','N','N','O','N','N','O','N','Root','N','O','N','N']

    x1 = [ 220, 225, 243, 254, 270, 278,  292, 268, 285, 305]
    x2 = [340, 240, 253, 265, 275, 290, 310, 275, 300, 315]
    y1 = [110, 85,   77, 120, 127, 121, 120, 95,   85, 77]
    y2 = [115, 103, 86, 130, 131, 131, 130, 100, 100, 86]
    symbol = ['/','3','3', '5','.','0','5','-','2','2']
    symbolType = ['longDivision', 'N', 'N','N','O','N','N','O','N','N']



    for i in range(0,len(x1)):
        dataStore[str(i)] = [x1[i],x2[i],y1[i],y2[i],symbol[i],symbolType[i]]
    return(dataStore)







a =data()
print(a)


