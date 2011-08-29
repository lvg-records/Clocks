:: iPhone IPA generator
:: More information:
:: http://labs.adobe.com/technologies/packagerforiphone/
:: http://download.macromedia.com/pub/labs/packagerforiphone/packagerforiphone_devguide.pdf
::
:: FlashDevelop Project Template
:: http://blubl.geoathome.at (german)

cls
@echo off

:: Path to Flex SDK binaries
set FLEX_SDK=D:\My work space\packagerforiphone_v2_win_101110\bin
set PATH=%PATH%;%FLEX_SDK%

:: Certificate files
set CERTIFICATE_FILE=certificates\iphone_dev.p12
set PROVISIONIG_FILE=certificates\iphone_dev.mobileprovision

:menu
echo iPhone IPA generator
echo.
echo. What kind of ipa do you wish to create?
echo.
echo.  [1]test (ipa-test)
echo.  [2]debug (ipa-debug)
echo.  [3]store (ipa-app-store)
echo.  [4]ad-hoc (ipa-ad-hoc)
echo.

:choice
set /P C=[Option]:
if "%C%"=="1" set IPATYPE=ipa-test
if "%C%"=="2" set IPATYPE=ipa-debug
if "%C%"=="3" set IPATYPE=ipa-app-store
if "%C%"=="4" set IPATYPE=ipa-ad-hoc
echo. You have chosen '%IPATYPE%'.
echo. 
if "%C%"=="1" goto gpudebug
if "%C%"=="2" goto gpudebug
:nogpudebug

:gpudebug
echo.
echo. You chose the DEBUG or TEST setting. Activate GPU rendering diagnostics?
echo.
echo.  [1]no
echo.  [2]yes
echo.

:gpudebugchoice
set /P GPU=[Option]:
if "%GPU%"=="1" set GPUDIAG=
if "%GPU%"=="2" set GPUDIAG=-renderingdiagnostics 
goto pass

:nogpudebug
set GPUDIAG=
goto pass

:pass
echo Before you enter your password, make sure no-one is looking!
set /p PASSWORD=Enter Certificate Password:
cls
echo iPhone IPA generator
echo.
echo. Thanks, password input done.
echo.
goto ipa

:ipa
echo. IPA creation may take up to 3 minutes, please be patient
echo. --------------------------------------------------------
call pfi -package %GPUDIAG%-target %IPATYPE% -provisioning-profile %PROVISIONIG_FILE% -storetype pkcs12 -keystore %CERTIFICATE_FILE% -storepass %PASSWORD% iphone/20100222-%IPATYPE%.ipa application.xml bin/20100222.swf Default.png bin/icons
if errorlevel 1 goto failed
echo. --------------------------------------------------------
echo. SUCCESS: IPA created in (./iphone/20100222-%IPATYPE%.ipa)
echo.
goto end

:failed
echo. --------------------------------------------------------
echo. ERROR: IPA creation FAILED.
echo.
echo. Troubleshotting: did you configure the Flex SDK path in this Batch file?
echo.

:end
pause