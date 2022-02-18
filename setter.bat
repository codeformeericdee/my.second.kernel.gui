@echo off

rem Batch file for session based builds written by Eric Dee

rem This is a secondary file to the building.bat main function. This file is used to set switches for build threads
rem I have intentionally opted not to use JSON format to reduce complexity for the time being.

echo ================
echo You are currently setting up the build format
echo ================
echo Welcome!
echo.

:make_settings
set /p assign_python_install_gate=Type in 'Pass' to skip the python installation, or press enter to install it: || echo. && goto SETUP
:SETUP
if "%assign_python_install_gate%"=="Pass" (
    echo pythonPass > settings.txt
) else (
    > nul find "started_session" session.txt && (
        echo pythonInstall > settings.txt
    ) || (
        type nul > settings.txt
        echo Python was not selected
        pause
    )
)

type nul > session.txt

exit