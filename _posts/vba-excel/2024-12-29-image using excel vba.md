---
title: How to create image dropdown using excel VBA
description : learn how to create image, shape, chart, formula dropdown using Excel VBA
date: 29-12-2024
categories: [VBA, Excel]
tag: [excel, vba,howto]
image: /assets/images/excel/excel-image-dropdown.webp
---

### Overview
- Creating image dropdown is most common requirement Among engineers who uses excel on daily basis
- Using image dropdown you can
  - Display different geometry/sections for your design sheets
  - Display formula for different calculation
  - Display bar shapes for BBS
  - Display different charts for visuals or summary
- It's also useful when you don't have enough space for multiple images on sheet. Using dropdown, you can place multiple images at same location and switch between different image as requirement
- In this tutorial, I'll teach you how to setup image dropdown using VBA
- If you don't know how to work with excel macro then watch this video first: [How to create or use excel macro Tutorial](https://www.youtube.com/watch?v=Tepc4iioSaA)

### Setup
- Create new excel sheet and import your Images to excel file
- you can download this Excel file with images as starting point : [Download](https://nodesauto-my.sharepoint.com/:f:/g/personal/vivek_nodesautomations_com/Eld97-el48VPr0ealy_VhuIBZq2ov74ppm3ZDXhRR5Mwkg?e=drrh0y)
- save your excel file as macro enable file `*.xlsm`
- Open Selection Pane using `ALT`+`F10`, you should be able to see list of all images and shapes on right panel, refer Screenshot 1

![Output1](/assets/images/excel/excel-image-dropdown-1.webp)
_Screenshot 1 : Excel sheet with selection pane_

- Update Name of each image shape to whatever you like, for this tutorial i am using P1,P2,P3 names
- Also add list type data validation in B2 Cell, refer Screenshot 2

![Output2](/assets/images/excel/excel-image-dropdown-2.webp)
_Screenshot 2 : List type data validation_

- After applying data validation you should be able select your images by clicking that dropdown button on B2 Cell

![Output3](/assets/images/excel/excel-image-dropdown-3.webp)
_Screenshot 3 : B2 Cell with dropdown_

### Version 1 : VBA code to update Image based on cell value
- Create new module, let's name it `Dropdown` and add below code
- Now when you select `B2` cell and run this `UpdateActiveShape` macro, macro will automatically hide all other picture except selected one 
- You can also create new button for `UpdateActiveShape` macro to update your images after you change your selection
- Congrats !🥳, we have our first working version of image dropdown
- In next update, let's add some additional code so run this macro automatically every time we change `B2` cell value

```vb
Public Sub UpdateActiveShape()
    Call UpdateShape(ActiveCell)
End Sub

Public Sub UpdateShape(inputCell As Range)
    Dim i As Integer
    Dim shape As shape
    Dim shapeData() As String
 
    'Check if active cell contain data validation
    If HasDataValidation(inputCell) Then
        'Get list of shapes to loop through
        shapeData = Split(inputCell.Validation.Formula1, ",")
        For i = LBound(shapeData) To UBound(shapeData)
            
            Set shape = activeSheet.shapes(shapeData(i))
            If shapeData(i) = inputCell.Value2 Then
                shape.Visible = msoTrue
            Else
                shape.Visible = msoFalse
            End If
        Next i
    End If
    
End Sub

Private Function HasDataValidation(cell As Range) As Boolean
    On Error GoTo ErrorHandler
    
    Dim formula As String
    formula = cell.Validation.Formula1
    
Done:
    HasDataValidation = True
    Exit Function
ErrorHandler:
    HasDataValidation = False
End Function
```

### Version 2 : Excel event automatically run macro every time we change our dropdown cell value
- In Visual Basic Editor Open Sheet1 and add worksheet change event code
- Now after this code your image should automatically updated based on your dropdown selection

```vb
Private Sub Worksheet_Change(ByVal Target As Range)
    If Not Intersect(Target, Me.Range("B2")) Is Nothing Then
        Call Dropdown.UpdateActiveShape
    End If
End Sub
```

![Output4](/assets/images/excel/excel-image-dropdown-4.webp)
_Screenshot 4 : Shee1 worksheet change event code_

### Version 3 : Use Name Range for B2 Cell
- Add New name range for B2 Cell, let's call it `ImageDropdown`
- This is better option than just using `B2` cell address
- Using name range will make sure that our macro will keep working even after we move our Dropdown to other location
- You need to update Sheet 1 , Worksheet Change event code as below

```vb
Private Sub Worksheet_Change(ByVal Target As Range)
    If Not Intersect(Target, Me.Range("ImageDropdown")) Is Nothing Then
        Call Dropdown.UpdateActiveShape
    End If
End Sub
```

![Output5](/assets/images/excel/excel-image-dropdown-5.webp)
_Screenshot 5 : Using name range for B2 Cell_


### Future Modification
- Instead of manually entering items in your dropdown, you can use Indirect function take inputs from Range or Table
- Instead of updating single group of images, you can update images at multiple locations using single dropdown

### Conclusion
- Image dropdowns are great way to add some visualization to your boring excel sheets
- Few advantage of using this method is 
  - it's compatible with older version
  - you don't need same size images, this will even work with different images sizes
  - you don't need to place all images at same location, you can use different location for each image
  - It will work with images, excel shapes, charts so you have lot of options