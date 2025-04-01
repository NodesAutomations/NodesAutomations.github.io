---
title: Automate Excel with CSharp using EPPlus
description: learn how to use EPPlus package to automate excel file using python
date: 01-04-2025
categories: [Python, Libraries]
tag: [csharp, excel, how to, library]
image: /assets/images/python/python-xlwings.webp
published: false
---

## Overview
- It

## Setup
- Add Nuget package `EPPlus`
  - I am using version 8.0.0 for non commercial use
  - Use version `4.5.3` if you need to use it for commercial use
- Create new excel file `sample.xlsx`
- For our tutorial i am going to add some data to our excel file, refer Screenshot 1
  
![Screenshot 1](/assets/images/python/python-xlwings-1.webp)
_Screenshot 1 : Excel sheet with data_

## Read Data From Active Excel File
- Here First thing we need to specify is license type, this is only required for version 5.0.0 and above
- We also need file path of our excel file, current file path is specific to my system so you need to change it according to your system
- Then we need to open our excel file using `ExcelPackage` class

```csharp
private static void Main()
{
    //Set License for Non-Commercial Use
    ExcelPackage.License.SetNonCommercialPersonal("Vivek");

    var excelFilePath = @"C:\Users\Ryzen2600x\Downloads\Test.xlsx";

    using (var package = new ExcelPackage(new FileInfo(excelFilePath)))
    {
        ExcelWorkbook wb = package.Workbook;
        ExcelWorksheet ws = wb.Worksheets["Sheet1"];

        // Get Cell value using row and column index
        ExcelRange cell1 = ws.Cells[1, 2];
        Console.WriteLine("Cell value for Row 1, column 2 = " + cell1.Value);

        //Get Cell value using address
        ExcelRange cell2=ws.Cells["B1"];
        Console.WriteLine("B1 Cell value = " + cell2.Value);
    }
}
```
#### Using sheet index
- When you don't want specify sheet name use sheet index

```csharp
//If you only have single Sheet
 var ws = wb.Worksheets.First();
```
```csharp
//If you have multiple sheets, use sheet index
 var ws = wb.Worksheets[0];
```

#### Data Range
```csharp
ExcelRange dataRange = ws.Cells["B4:E7"];
for (int i = dataRange.Start.Row; i <= dataRange.End.Row; i++)
{
    for (int j = dataRange.Start.Column; j <= dataRange.End.Column; j++)
    {
        ExcelRange cell = ws.Cells[i, j];
        Console.WriteLine($"Value at {cell.Address}: {cell.Value}");
    }
}
```

#### Name Range
```csharp
ExcelNamedRange namedRange = wb.Names["Area"];
Console.WriteLine("Area NameRange value = " + namedRange.Value);
Console.WriteLine("Area NameRange address = " + namedRange.Address);
```

#### Table
```csharp
ExcelTable tbl = ws.Tables["ColumnDataTable"];

for (int i = 0; i < tbl.Address.Rows; i++)
{
    for (int j = 0; j < tbl.Address.Columns; j++)
    {
        Console.Write(ws.Cells[tbl.Address.Start.Address].Offset(i, j).Value + ",");
    }
    Console.WriteLine();
}
```

## Write data to excel file

## Conclusion