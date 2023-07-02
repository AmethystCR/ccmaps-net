set VER=2.4.2
set MAKENSIS="%PROGRAMFILES%\nsis\makensis.exe"

del CNCMaps_release_*.exe
del CNCMaps_debug_*.exe
rmdir /s /q CNCMaps.Engine\bin\
rmdir /s /q CNCMaps.FileFormats\bin\
rmdir /s /q CNCMaps.Renderer\bin\
rmdir /s /q CNCMaps.Renderer.GUI\bin\
rmdir /s /q CNCMaps.Shared\bin\

set "VSINSTALLDIR=%PROGRAMFILES%\Microsoft Visual Studio\2022\Enterprise\"
if not exist "%VSINSTALLDIR%" (
set "VSINSTALLDIR=%PROGRAMFILES%\Microsoft Visual Studio\2022\Professional\"
)
if not exist "%VSINSTALLDIR%" (
set "VSINSTALLDIR=%PROGRAMFILES%\Microsoft Visual Studio\2022\Community\"
)
set DevEnvDir=%VSINSTALLDIR%Common7\IDE\
call "%VSINSTALLDIR%Common7\Tools\VsDevCmd.bat"
msbuild kerfcheck.sln 

msbuild CNCMaps.sln /t:restore /t:Build /p:Configuration=Release
%MAKENSIS% nsisinstaller-rls.nsi

REM msbuild CNCMaps.sln /p:Configuration=Debug
REM %MAKENSIS% nsisinstaller-dbg.nsi
