@echo off
setlocal

REM Get the active folder name
for %%F in ("%cd%") do set "folderName=%%~nxF"

REM Open the GitHub URL with the active folder name
start https://github.com/NodesAutomations/%folderName%

endlocal
