---
title: 📖 Best programming languages for civil engineers 2026
description: Learn about pros and cons of each language
date: 27-12-2025
categories: [Developer Tools and Resources, Programming]
tag: [list, vba, python, csharp, autolisp,dynamo]
image: /assets/images/best/best-language.webp
---

### Overview
- So, you've already decided to learn programming to automate your work, but can't decide on which programming to choose
- This post contains most of popular programming languages used by civil engineers, all pros and cons are written from perspective of civil engineers
- I am also not going to include basic info about each language, you can just google or ChatGPT that part
- I'll do my best to explain pros and cons of each languages but you have to make own choice depending on your domain or use case
- Civil engineering is too large domain with lots of niche and sub domains so what works for 99% people might not work for you

### Languages

#### VBA
- Difficulty Level : Easy
- Pros
  - No setup required to start coding. You can just start coding right away this is massive advantage, since setup is where most people get stuck or procrastinate.
  - API to connect Excel with a lot of popular software like AutoCAD, STAAD, ETABS
  - Direct Integration with other office software like Word, PowerPoint
  - Macro Recorder (Excel has option to auto generate code for your task when you perform task manually), this used be big deal but now since AI tools like ChatGPT it's not that important.
  - Since Excel is used by most organizations, you don't need any special permission to use or run your macro. 
  - Easy to share your automation among your friends or colleagues. This is really important thing if you need feedback from other people or want to get advantage of your automation.
- Cons
  - Outdated, VBA lacks a lot of features which are available in other modern programming languages. You'll only notice this after you learn another language. This makes it a bit harder to develop complex software. 
  - Slow Performance, VBA is slowest language among all programming languages in this list, it's not a big deal for most of tasks, it's only a problem when you need to do some heavy calculation which might take more than a few minutes. This is also an issue when you need to connect with other office software like AutoCAD, STAAD, ETABS.
  - Lack of Future Development, VBA is no longer actively developed, so you won't see any new features/tools related to it in future
- What do I think about it?
  - I have been coding for more than 10 years now, and I still use VBA on a regular basis, it's perfect for smaller or medium size projects, especially when it involves Excel. A lot of my personal tools which I use in my daily routine are written in VBA.
  - Even after all of these limitations, I still recommend VBA to all beginners. VBA will give you best value for time spent.
  - If you decide to use VBA then check out [Best Resources to learn VBA](/posts/vba-best-resources)
  - Additionally go through all post with `vba` tags on this website [vba](/tags/vba)

#### Python
- Difficulty Level : Normal
- Pros
  - Python has a ridiculous amount of libraries and frameworks, you can do a lot of stuff with very less code.
  - Python has largest community support across all programming languages in this list. You'll find a lot of tutorials, books, online courses, open source software or packages to learn and improve your skills.
  - A lot of modern software tools to develop your project.
- Cons
  - Python doesn't have direct integration with a lot of popular tools like Excel or AutoCAD so you'll have to rely on third party libraries to connect with them.
  - Difficult to set up for beginners, users have to deal with command line tools to install and configure python.
  - Sharing python automation among your friends and colleagues is a bit tricky since script requires python setup to run. Your only option is to build an installer using third party tool or do python setup on each computer.
- What do I think about it?
  - I'm still a bit new to python, learned it around mid-2023, and since VBA and C# covers most of my use cases it's my least used language. I do plan to develop some web apps with Python in future, since Python has a lot of tools in that area.
  - Python is the most versatile language among all programming languages in this list. It's a perfect tool which is going to help you throughout your entire life.
  - Pick this as your first language if you're really serious about automation and programming. 
  - One major reason I don't recommend python to beginners is that python has too many options in everything, too many libraries, too many open source software, too many frameworks, it's easy to get lost in all of them. This is overwhelming for beginners. .
  - If you decide to use Python then check out [Best Resources to learn python ](/posts/python-best-resources)
  - Additionally go through all post with `python` tags on this website [python](/tags/python)
  
#### C#
- Difficulty Level : Hard
- Pros
  - It's super-fast, C# has best performance among all languages in this list.
  - Most popular software like Excel, AutoCAD, Revit, STAAD, ETABS have direct API to connect with C#.
  - C# also has good security features to encrypt and protect your code if you don't want to share it with others or protect your intellectual property.
- Cons
  - Complex to setup with a steep learning curve, you need to learn a lot of stuff before you can start coding in C#.
  - Requires a lot more code than VBA and Python to do the same task.
  - Lack of packages for engineering. Most of engineering libraries are developed using python.
- What do I think about it?
  - It's my current favorite language to build large projects. 
  - It's a great language for complex projects, C# makes it really hard to make mistakes. 
  - Don't choose this as your first language, it's not beginner friendly.
  - It's a good language for large projects or if you want to sell your software commercially.
  - If you decide to use C# then check out [Best Resources to learn C# ](/posts/csharp-best-resources)

### Apps specific languages 

#### Auto Lisp
- Difficulty Level : Easy
- Pros
  - You can do a lot of stuff with very less code
  - It's compatible with most of the CAD software without change. You only need to write your script once and it will work with any AutoCAD version and other CAD software like ZWCAD, BRICSCAD, GSTARCAD.
  - Just like Excel VBA, it does not require any complex setup. AutoCAD natively supports Auto Lisp out of box.
- Cons
  - Limited Scope since it's usable only with AutoCAD, can't use it for anything else.
  - No API available if you work with other apps like Excel, STAAD, ETABS
  - Doesn't have a library or package manager, you have to work with built in functions only for every task.
- What do I think about it?
  - I'm not fully familiar with Auto Lisp, since I don't see any point in learning it. But I still use it occasionally since few of my clients use it for their projects and I have to build my solution around it.
  - Also, personally I find Auto Lisp syntax/code very weird and hard to read.
  - Only learn this if AutoCAD is the only software you use most of the time or planning to do freelancing work using Auto Lisp. 

#### Dynamo
- Difficulty Level : Normal
- Pros
  - Visual Programming Interface, no need to write traditional code. You create programs by connecting nodes in a visual workflow, making it more accessible for engineers who prefer visual thinking.
  - Direct Integration with Revit, Dynamo comes built-in with Revit and provides powerful access to all Revit elements and parameters.
  - Great for BIM Automation, perfect for automating repetitive tasks in Building Information Modeling workflows like parameter updates, element placement, documentation.
  - Large Community Support, Dynamo has an active community with a lot of shared scripts and packages you can use or learn from.
  - Package Manager built-in, easy to install and use community-developed packages to extend functionality.
- Cons
  - Limited to Autodesk Ecosystem, primarily useful only if you work with Revit or other Autodesk products.
  - Performance Issues, complex visual scripts can become slow and hard to maintain as they grow larger.
  - Difficult to Debug, when something goes wrong in visual script, it's harder to troubleshoot compared to traditional code.
  - Version Compatibility, scripts created in one Dynamo version may not work properly in another version, package dependencies can break.
- What do I think about it?
  - I've never used dynamo personally so I can't give you detailed insights.

### Conclusion
- If you have admin access to your computer then choose the best language as per your needs.
- If you're an employee and don't have admin access to your computer then
  - Choose a language which you can use at work
  - There's no point in learning a language which you can't use in your daily routine
  - If you've specific requirements then it's better to discuss this with your department head or your IT department first before investing more time
