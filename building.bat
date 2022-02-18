@echo off

rem Batch file for session based builds written by Eric Dee

Setlocal EnableDelayedExpansion

set python_exe_name=python_get3

set bootloader_directory=bootloader
set operating_system_directory=operating_system
set dependencies_directory=dependencies
set python_environment_directory=%dependencies_directory%\python_virtual_environment


:starting_docker
set /p activity_command=Needs command: 
echo This is what was received: %docker_command%
echo.

if "%activity_command%"=="new build" (
    if exist "%CD%\%python_environment_directory%" (
        echo Python already exists in "%CD%\%python_environment_directory%"
        goto SOFT_EXIT
    ) else (
        echo =
        echo ==
        echo ===
        echo ====
        echo.
        echo About to download python as "%CD%\%dependencies_directory%\%python_exe_name%.exe".
        echo.
    )
    
    echo Type anything besides q install the dependencies.
    set /p abort_dependency_installer=If dependencies aren't what you wanted, then press q then enter to abort: || echo Nothing found. && goto LAST_NEW_BUILD_DECISION
    echo This is what was received: !abort_dependency_installer!
    echo.

    if "!abort_dependency_installer!"=="q" (
        goto EXIT_ALL
    )
) else if "%activity_command%"=="run" (
    echo Docker is starting. Please wait.
	powershell -command docker run -p 127.0.0.1:256:256 --user=root -it -v "${pwd}:/root/env" --rm operating_system_development
)

if not exist %development_directory% (
    echo "Development directory not found."
    pause
)


:LAST_NEW_BUILD_DECISION
rem Needs docker to also be added as a downloaded exe for first setup.
echo The session will begin installations in 16 seconds.
echo "started_session" > session.txt
start call setter.bat
rem Sets a timeout to give the user time to make a final choice. Haven't decided on a command tree yet.
ping -n 16 127.0.0.1 > nul
echo Checking settings.
> nul find "pythonInstall" settings.txt && (
    python %dependencies_directory%\python_checker.py > python_check
    set /p is_python_installed=<python_check
    if "!is_python_installed!"=="pythonIsInstalled" (
        echo Python is already installed. Do you still want to install it?
        set /p abort_python_installer=Typing no and then pressing enter will skip it. Type anything else to install it: 

        if "!abort_python_installer!"=="no" (
            echo Python is not being installed
            goto SOFT_EXIT
        ) 
    )
    del python_check
    echo Beginning python installation
    echo =
    rem NOTE: You can open a nul find and let it run indefinately
    echo Installing python to "%CD%\%dependencies_directory%\"
    curl "https://www.python.org/ftp/python/3.6.0/python-3.6.0-amd64.exe" -o "%CD%\%dependencies_directory%\%python_exe_name%.exe"
    echo Python has been downloaded here "%CD%\%dependencies_directory%\%python_exe_name%.exe"
    echo.
    echo =
    rem NOTE: Not easy to see. Needs color.
    echo == Make sure you check for the windows administration popup to install it ====
    echo ===
    echo.
    "%CD%\%dependencies_directory%\%python_exe_name%.exe" InstallAllUsers=1 PrependPath=1
    call RefreshEnv.cmd
    python -m venv %python_environment_directory%
    echo End of python installer
    echo ==
) || (
    echo No settings found.
)
type nul > session.txt


:SOFT_EXIT
:docker_build
echo Docker is building. Please wait.
docker build .\dependencies -t operating_system_development
pause


:EXIT_ALL
echo This is the end of the script.
pause
exit