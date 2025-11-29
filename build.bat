@echo off

set DOTNET_CLI_TELEMETRY_OPTOUT=1

for /F "tokens=*" %%f in ('dir /B /AD /S bin') do rmdir /S /Q "%%f"
for /F "tokens=*" %%f in ('dir /B /AD /S obj') do rmdir /S /Q "%%f"
if exist Build rmdir /S /Q Build
if exist Debug rmdir /S /Q Debug
if exist Release rmdir /S /Q Release

mkdir Build
mkdir Build\Params_Tool

dotnet restore Params_Tool/Params_Tool.csproj /p:RuntimeIdentifiers=win
msbuild Params_Tool/Params_Tool.csproj /p:LangVersion=10 /p:AllowUnsafeBlocks=true /p:Platform=AnyCPU /p:Configuration=Release /p:OutputPath=..\Build\Params_Tool\
del Build\Params_Tool\FreeMote*.xml
del Build\Params_Tool\*.pdb
del Build\Params_Tool\*.txt
