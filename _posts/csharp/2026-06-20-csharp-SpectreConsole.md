---
title: 📖 Create Custom Console Apps using Spectre.Console
description: build formatted interactive console applications
date: 20-06-2026
categories: [CSharp, CSharp-Libraries]
tag: [csharp, console, how to, library]
image: /assets/images/csharp/csharp-spectreConsole.webp
---

## Overview
- Spectre.Console is
  - A .NET library that makes it easier to create beautiful console applications.
  - In Active development with good community support
  - [Open-source](https://github.com/spectreconsole/spectre.console) with good [Documentation](https://spectreconsole.net/console/)
- Requirements
  - .NET Framework 4.8 or .NET Standard 2.0 or later or .NET 8 or later

## Setup
- Create Simple C# Console Application in Visual Studio using .NET Framework 4.8
- Add Nuget package `Spectre.Console` 
- Add this Sample Code in the `Main` method 

```csharp
 private static void Main()
 {
     try
     {
         //Unable UTF-8 characters to display correctly in the console
         Console.OutputEncoding = Encoding.UTF8;
         Console.InputEncoding = Encoding.UTF8;

         //Add other code snippets here
     }
     catch (Exception)
     {
         throw;
     }
     finally
     {
         Console.ReadLine();
     }
 }
```

## Display Output

#### Text
```csharp
//Normal Text
AnsiConsole.WriteLine("This is a normal text message");
```
```csharp
//Text with basic formatting
AnsiConsole.MarkupLine("[bold]This is a bold text message[/]");
AnsiConsole.MarkupLine("[italic]This is an italic text message[/]");
AnsiConsole.MarkupLine("[underline]This is an underlined text message[/]");
```
```csharp
//Color the output text in the console
AnsiConsole.MarkupLine("[green]Hello, World![/]");
AnsiConsole.MarkupLine("[red]This is an error message[/]");
AnsiConsole.MarkupLine("[yellow]This is a warning message[/]");
```
```csharp
//Use Hexadecimal color codes to color the output text in the console
AnsiConsole.MarkupLine("[#8F00FF]This is a custom color message[/]");
```
```csharp
//Combine formatting and color
AnsiConsole.MarkupLine("[bold green]This is a bold and green text message[/]");
```
```csharp
//Text with background color
AnsiConsole.MarkupLine("[black on yellow]This is a text message with a yellow background[/]");
AnsiConsole.MarkupLine("[red on white bold]This is a text message with a white background and red text[/]");
```
```csharp
//Text with effects
AnsiConsole.MarkupLine("[blink]This is a blinking text message[/]");
AnsiConsole.MarkupLine("[slowblink]This is a blinking text message[/]");
AnsiConsole.MarkupLine("[reverse]This is a reversed text message[/]");
AnsiConsole.MarkupLine("[conceal]This is a concealed text message[/]");
```
#### Text Style
```csharp
//Using Text Style
var style = new Style(foreground: Color.Green, background: Color.Black, decoration: Decoration.Bold | Decoration.Underline);
AnsiConsole.Write(new Markup("This is a text message with a custom style",style));
```
#### Title
```csharp
 //Title
 AnsiConsole.Write(new FigletText("Hello, World!").Centered().Color(Color.Green));
```
#### Horizontal Divider
```csharp
//Create a horizontal divider that spans the width of the console window
AnsiConsole.Write(new Rule());
```
```csharp
//Create a horizontal divider with a custom title and color
AnsiConsole.Write(new Rule("[green]Hello[/]").RuleStyle("grey"));
```
#### URL
```csharp
AnsiConsole.MarkupLine("→ Website: [link=https://nodesautomations.com]Nodes Automations[/]");
```
#### Exception
```csharp
AnsiConsole.WriteException(ex,ExceptionFormats.NoStackTrace);
```
#### Table
- Simple Table with default settings

```csharp
Table table = new Table();
table.AddColumn("Beam Id");
table.AddColumn("Width");
table.AddColumn("Depth");

table.AddRow("1", "230", "300");
table.AddRow("2", "230", "350");
table.AddRow("3", "230", "400");

AnsiConsole.WriteLine();
AnsiConsole.Write(table);
```

```csharp
//Table with custom settings
table.AddColumns("Beam Id", "Width", "Depth");

table.AddRow("1", "230", "300");
table.AddRow("2", "230", "350");
table.AddRow("3", "230", "400");

//Add Formatting to the table
table.Border(TableBorder.Rounded);
table.ShowRowSeparators();

//Adjust Column formatting
table.Columns[0].LeftAligned();
table.Columns[1].Centered();
table.Columns[2].Centered();
```

#### Tree
```csharp
//Simple Tree
var tree = new Tree("Data");

tree.AddNode("Story Data");
tree.AddNode("Section Data");
tree.AddNode("Design Data");

AnsiConsole.Write(tree);
```
```csharp
//Tree with nested nodes
var tree = new Tree("Data");

var storyData = tree.AddNode("Story Data");

var sectionData= tree.AddNode("Section Data");
sectionData.AddNode("Beam Sections");
sectionData.AddNode("Column Sections");
sectionData.AddNode("Slab Sections");
sectionData.AddNode("Wall Sections");

var designData = tree.AddNode("Design Data");
designData.AddNode("Beam Design");
designData.AddNode("Column Design");
designData.AddNode("Slab Design");

AnsiConsole.Write(tree);
```

#### Status Update
```csharp
AnsiConsole.Status()
    .Start("Extracting Data From Model...", ctx =>
    {
        // Simulate some work
        Thread.Sleep(3000);
    });

AnsiConsole.MarkupLine("[green]Data Extraction Done![/]");
```

```csharp
//Status messages with spinner
await AnsiConsole.Status()
    .StartAsync("Processing...", async ctx =>
    {
        ctx.Spinner(Spinner.Known.Dots);
        ctx.SpinnerStyle(Style.Parse("green"));
        //Simulate some work
        await Task.Delay(3000);
        ctx.Status("Almost done...");
        await Task.Delay(2000);
    });

AnsiConsole.WriteLine("Processing Done");
```

```csharp
//Spinner with multiple status messages and custom spinner type and color
AnsiConsole.Status()
    .Spinner(Spinner.Known.Dots)//Change the spinner type
    .SpinnerStyle(Style.Parse("red"))//Change the spinner color
    .Start("Extrating data from model...", ctx =>
    {
        Thread.Sleep(1500);

        ctx.Status("Extracting Story Data...");
        Thread.Sleep(2000);

        ctx.Status("Extracting Section Data...");
        Thread.Sleep(2000);

        ctx.Status("Extracting Results...");
        Thread.Sleep(2000);

        ctx.Status("Extracting Design Data...");
        Thread.Sleep(2000);

        ctx.Spinner(Spinner.Known.Arc);//Change the spinner type
        ctx.SpinnerStyle(Style.Parse("green"));//Change the spinner color
        ctx.Status("Finalizing...");
        Thread.Sleep(1000);
    });

AnsiConsole.MarkupLine("[green]Data Extraction Done![/]");
```

#### Chart
```csharp
AnsiConsole.WriteLine("Max Movement = 100");
AnsiConsole.Write(new BarChart()
    .Label("[green]Junction[/]")
    .AddItem("Top", 85, Color.Blue)
    .AddItem("Middle", 62, Color.Yellow)
    .AddItem("Bottom", 100, Color.Green));
```
```csharp
AnsiConsole.WriteLine();
AnsiConsole.WriteLine("Overall Cost is 100");
AnsiConsole.Write(new BreakdownChart()
    .AddItem("Material", 65, Color.Green)
    .AddItem("Labor", 25, Color.Blue)
    .AddItem("Overhead", 10, Color.Yellow));
```
#### Progress Bar
```csharp
 //Progress Bar
 AnsiConsole.Progress()
    .AutoClear(false) // Do not clear the progress bar when done
    .Columns(new ProgressColumn[]
    {
        new TaskDescriptionColumn(),    // Task description
        new ProgressBarColumn(),         // Progress bar
        new PercentageColumn(),          // Percentage
        new RemainingTimeColumn(),       // Remaining time
        new SpinnerColumn(),             // Spinner
    })
    .Start(ctx =>
    {
        var task1 = ctx.AddTask("[green]Processing task 1[/]");
        var task2 = ctx.AddTask("[yellow]Processing task 2[/]");
        var task3 = ctx.AddTask("[red]Processing task 3[/]");
        while (!ctx.IsFinished)
        {
            task1.Increment(0.5);
            task2.Increment(0.3);
            task3.Increment(0.2);
            Task.Delay(100).Wait();
        }
    });
```



## Get User Input

#### Simple User Inputs
- It will automatically validate the input type and prompt the user again if the input is invalid.

```csharp
string name = AnsiConsole.Ask<string>("What is your name?");//Require string input from the user
int age= AnsiConsole.Ask<int>("What is your age?");//Require integer input from the user
bool isHappy = AnsiConsole.Confirm("Are you happy?");//Require Y/N input from the user
bool isMale = AnsiConsole.Ask<bool>("Are you male?");//Require True/False input from the user
```
#### Get User Input custom validation
- You can sepecify any data type and provide custom validation logic to validate the user input.

```csharp
var selectedDia = AnsiConsole.Prompt(
    new TextPrompt<int>("Select a Dia:")
    .AddChoices(new[] { 8, 10, 12 })
    .DefaultValue(8));
```
```csharp
 //Prompt with logic for handling user input
 var age = AnsiConsole.Prompt(
    new TextPrompt<int>("Enter your age:")
    .Validate(age =>
    {
    if (age < 0)
        {
            return ValidationResult.Error("[red]You cannot enter a negative age[/]");
        }
        else if (age > 120)
        {
            return ValidationResult.Error("[red]You cannot enter an age greater than 120[/]");
        }
        else
        {
            return ValidationResult.Success();
        }
    }));
```

#### Select from a List
```csharp
List<string> colorList = new List<string>() { "Red", "Green", "Blue", "Yellow", "Purple", "Cyan", "White", "Black" };
string selectedColor = AnsiConsole.Prompt(
    new SelectionPrompt<string>()
    .Title("Select a color:")
    .AddChoices(colorList));

AnsiConsole.WriteLine($"Your selected color is {selectedColor}");

string selectedColor2 = AnsiConsole.Prompt(
    new SelectionPrompt<string>()
    .Title("Select a color:")
    .PageSize(5) //Only show 5 options at a time, if there are more than 5 options, the user can scroll through the list
    .MoreChoicesText("[grey](Move up and down to reveal more colors)[/]") //Text to show when there are more options than the page size
    .AddChoices(colorList));

AnsiConsole.WriteLine($"Your selected color is {selectedColor2}");
```

#### Multi-Select from a List
```csharp
//Multi select from a list of options
List<string> colorList = new List<string>() { "Red", "Green", "Blue", "Yellow", "Purple", "Cyan", "White", "Black" };

var selectedColors = AnsiConsole.Prompt(
    new MultiSelectionPrompt<string>()
    .Title("Select one or more colors:")
    .AddChoices(colorList));

AnsiConsole.WriteLine($"Your selected colors are {string.Join(", ", selectedColors)}");

var selectedColors2 = AnsiConsole.Prompt(
    new MultiSelectionPrompt<string>()
    .Title("Select one or more colors:")
    .PageSize(5) //Only show 5 options at a time, if there are more than 5 options, the user can scroll through the list
    .InstructionsText("[grey](Press [blue]<space>[/] to toggle a color, [green]<enter>[/] to accept)[/]") //Instructions for the user
    .AddChoices(colorList));

AnsiConsole.WriteLine($"Your selected colors are {string.Join(", ", selectedColors2)}");
```
```csharp
//Multi select from Grouped list of options
List<string> colorList = new List<string>() { "Red", "Green", "Blue", "Yellow", "Purple", "Cyan", "White", "Black" };
List<string> CustomColors = new List<string>() {"Cherry Red","Minty Green", "Ocean Blue", "Sunset Orange" , "Lemon Yellow" };

var selectedColors3 = AnsiConsole.Prompt(
    new MultiSelectionPrompt<string>()
    .Title("Select one or more colors:")
    .PageSize(5) //Only show 5 options at a time, if there are more than 5 options, the user can scroll through the list
    .InstructionsText("[grey](Press [blue]<space>[/] to toggle a color, [green]<enter>[/] to accept)[/]") //Instructions for the user
    .AddChoiceGroup("Basic Colors", colorList)
    .AddChoiceGroup("Custom Colors", CustomColors));

AnsiConsole.WriteLine($"Your selected colors are {string.Join(", ", selectedColors3)}");
```

## Conclusion
- Spectre.Console is perfect for creating interactive console applications with formatted output and user input handling.
- It has all the features you need to create a fully functional console application with a good user experience.
- Not suitable when you need lot of predefined inputs or a complex user interface, for that best to use a GUI framework like WPF or WinForms.