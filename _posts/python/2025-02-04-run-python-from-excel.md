---
title: Run python script directly from excel file
description : use excel vba to run python script
date: 04-02-2025
categories: [Python, Python-Tutorials]
tag: [python, vba,excel]
image: /assets/images/excel/excel-run-python.webp
---

### Overview
- In this tutorial, I'll show you how to run python script directly from excel file using excel VBA
- I am assuming you already have python installed on your system and comfortable with installing python packages

### Prepare your environment and python script
- For this tutorial I am going to use very simple python script to calculate area, sample code is given below
- Name of this python script file is `Sample.py`.
- Before continuing further, try to run this script once manually to see if everything is working fine.

```python
# Set/Enter inputs
length = 5.0
width = 10.0

# Do some calculations
area:float
area = length*width

# Display final output
print(f"Inputs: leng={length},width={width}")
print(f"Area={area}")
```
### Excel file setup
![Output1](/assets/images/excel/excel-run-python-1.webp)
_Screenshot 1 : Excel Sheet Setup_

- Create new excel sheet, add our input and output as shown in screenshot 1
- Set Name of this sheet as `Main`

### xlwings setup
- Now Come back to our `Sample.py` python script, we need to modify our script to take inputs from excel and write output to excel
- We are going to use [xlwings](https://www.xlwings.org/) to read and write values from excel
- Use `pip install xlwings` to install xlwings package
- Modify our python script as shown below and run once manually to check if everything is working fine

```python
import xlwings as xw

# Get workbook
area_calculation_worksheet: xw.Book
area_calculation_worksheet = xw.books.active

# Get worksheet
main_worksheet: xw.Sheet
main_worksheet = area_calculation_worksheet.sheets["Main"]

# Set/Enter inputs
length = float(main_worksheet["B1"].value)
width = float(main_worksheet["B2"].value)

# Do some calculations
area: float
area = length*width

# Display final output
main_worksheet["B4"].value = area
```

### VBA Code to Run python
- Save our excel sheet as macro enable file `*.xlsm` and
- Copy sample code from below to new module
- Update your python script path to match your system
- For Python Exe path
  - Open Command prompt
  - Run Command `where python` 
  - It should display your python executable path 
  - If multiple paths are displayed then ignore path with WindowsApps
- After this modification try to run Calculate area macro, our `Main` Sheet, Area value on `B4` cell should be calculated by our python script
> Triple quote `"""` is used to escape double quotes in VBA, don't remove it. Your script won't run without those quotes
{: .prompt-tip }

```python
Sub CalculateArea()
    Dim objShell As Object
    Set objShell = VBA.CreateObject("Wscript.Shell")
        
    Dim PythonExePath As String
    PythonExePath = """C:\Users\Ryzen2600x\AppData\Local\Programs\Python\Python311\python.exe"""

    Dim PythonScriptPath As String
    PythonScriptPath = """C:\Users\Ryzen2600x\Download\SampleProject\Sample.py"""
     
    objShell.Run PythonExePath & " " & PythonScriptPath, 0
End Sub
```

### Use Relative Path for Python Script
- Now only problem with this setup is that path of our python script is fixed, so if you run this code from another computer this code won't work
- To solve this issue,  we need to use relative path of our python script
- I am making assumption that you're going to keep your excel sheet and python script in same folder
- so instead of `C:\Users\Ryzen2600x\Download\SampleProject\Sample.py` we can specify path relative to our excel file path
- In simple terms `Excel file path\Sample.py` will be our python script path
- So, update your python script path as shown below

```python
Sub CalculateArea()
    Dim objShell As Object
    Set objShell = VBA.CreateObject("Wscript.Shell")
        
    Dim PythonExePath As String
    PythonExePath = """C:\Users\Ryzen2600x\AppData\Local\Programs\Python\Python311\python.exe"""

    Dim PythonScriptPath As String
    PythonScriptPath = """" & ThisWorkbook.Path & "\Sample.py"""
     
    objShell.Run PythonExePath & " " & PythonScriptPath, 0
End Sub
```
### Getting python exe path from Windows Registry
- In case you're planning to share this script with multiple people or running on different system
- you'll have to use inbuilt python path from Windows registry
- Use below code snippet to get python exe path from registry
```vba
Sub CalculateArea()

    Dim scriptName As String
    scriptName = "Sample.py"

    Dim objShell As Object
    Set objShell = CreateObject("WScript.Shell")

    ' Set working directory to workbook folder
    objShell.CurrentDirectory = ThisWorkbook.Path

    ' Run Python script (hidden window)
    objShell.Run "python.exe """ & scriptName & """", 0
    
End Sub
```

### Conclusion
- Now we can run our python script directly from excel file using excel VBA
- This is good way to make our python script more user friendly for users who is not comfortable with running python script manually



> If you have any questions or want to discuss something : [Join our comment section](https://www.reddit.com/r/NodesAutomations/comments/1igllej/run_python_script_directly_from_excel_file_nodes/)
{: .prompt-info }
