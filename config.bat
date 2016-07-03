@rem DO NOT EDIT THIS FILE
@rem CREATE user_config.cmd file according to the example
@rem FILL THAT INSTEAD!!

@set SteamAppUser=dummy
@set HammerParams=-nop4

@call user_config.cmd

@set SteamUser=%SteamAppUser%

@rem Actual steam path
@set SteamPath=C:\Program Files (x86)\Steam

@call user_config.cmd

@rem Could be library folder or just above
@set SteamPathAlt=%SteamPath%

@call user_config.cmd
@rem ====== MAP CONFIG =========

@rem map vmf and such
@set mapfolder=C:\metastruct\mapfiles

@call user_config.cmd

@set version_file=%mapfolder%\ver_meta3.txt

@call user_config.cmd

@call "%~d0%~p0\build_version.bat"

@rem input vmf
@set mapfile=metastruct_3

@rem output bsp name
@set mapname=gm_construct_m_%BUILD_VERSION%

@rem map content
@set mapdata=C:\metastruct\mapdata

@rem workshop map id
@set mapwsid=0

@rem Should the compiler bundle missing materials
@set NO_MISSING_BUNDLING=0

@rem ===========================

@call user_config.cmd

@set sourcesdk=%SteamPath%\steamapps\common\Source SDK Base 2013 Multiplayer
@call user_config.cmd

@rem FGDs for vmfii, otherwise breakage possibly
@set FGDS=%sourcesdk%\bin\base.fgd,%sourcesdk%\bin\halflife2.fgd,%mapfolder%\metastruct.fgd

@rem REQUIRED configuration folder, needs gameinfo.txt at least
@set VProject=%~d0%~p0
@set VProject_Hammer=%VProject%game_hammer
@set VProject=%VProject%game_compiling

@IF EXIST "%VProject_Hammer%"\gameinfo.txt @GOTO VProject_Hammer_fixskip
@set VProject_Hammer=%VProject%
@echo Missing %VProject_Hammer%\gameinfo.txt
:VProject_Hammer_fixskip


@call user_config.cmd

@rem Where garrysmod locates
@set GameDir=%SteamPath%\steamapps\common\GarrysMod\garrysmod
@set GameExeDir=%SteamPath%\steamapps\common\GarrysMod

@set ValvePlatformMutex=%SteamPath%\steam.exe
@call user_config.cmd
@set PATH=%~d0%~p0;%sourcesdk%\bin;%SteamPath%\;%PATH%
@set SteamAppId=4000
@set SteamAppVersionId=45
@set SteamGameId=211
@set SteamGame=garrysmod


@call user_config.cmd








@title Source SDK Environment

:testing
@set TESTPATH=%sourcesdk%
@IF NOT EXIST "%TESTPATH%" @GOTO fail
@set TESTPATH=%GameExeDir%
@IF NOT EXIST "%TESTPATH%" @GOTO fail
@set TESTPATH=%GameExeDir%\bin
@IF NOT EXIST "%TESTPATH%" @GOTO fail
@set TESTPATH=%GameDir%\bin
@IF NOT EXIST "%TESTPATH%" @GOTO fail
@set TESTPATH=%GameDir%\maps
@IF NOT EXIST "%TESTPATH%" @GOTO fail
@set TESTPATH=%mapdata%
@IF NOT EXIST "%TESTPATH%" @GOTO fail
@set TESTPATH=%sourcesdk%\bin
@IF NOT EXIST "%TESTPATH%" @GOTO fail
@set TESTPATH=%sourcesdk%\bin\hammer.exe
@IF NOT EXIST "%TESTPATH%" @GOTO fail
@set TESTPATH=%VProject%\gameinfo.txt
@IF NOT EXIST "%TESTPATH%" @GOTO fail
@set TESTPATH=%VProject%
@IF NOT EXIST "%TESTPATH%" @GOTO fail
@set TESTPATH=%version_file%
@IF NOT EXIST "%TESTPATH%" @GOTO fail
@set TESTPATH=%SteamPath%
@IF NOT EXIST "%TESTPATH%" @GOTO fail

@java.exe -version >nul 2>nul
@IF %ERRORLEVEL% NEQ 0 @GOTO failjava

@goto end



:fail
@echo "FATAL: Path does not exist: %TESTPATH%"
@pause > nul
@exit 1
@goto :end

:failjava
@echo "java.exe not found from PATH (needed by pakrat.jar)"
@pause > nul
@exit 2
@goto :end


:end