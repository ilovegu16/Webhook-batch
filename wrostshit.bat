@echo off

net session >nul 2>&1
if %errorlevel%==0 (
	echo Running the program
) else (
    echo Please run this as admin
	echo.
	pause
    exit /b
)


:menu
mode 85, 25
color 9
cls
echo                                _  _  ____  ____ 
echo                               / )( \(  __)(  _ \
echo                               \ /\ / ) _)  ) _ (
echo                               (_/\_)(____)(____/
echo.
echo Welcome to the shitty shit webhook that was made with chatgpt!
echo Please Choose a option:
echo 1. Spam nigga webhook
echo 2. Delete dum webhook
echo 3. Change webhook name
echo 4. Check webhook info

set /p option="$> "

pause >nul
echo.

if %option% == 1 goto spam
if %option% == 2 goto delete
if %option% == 3 goto name
if %option% == 4 goto check

:spam
cls
echo Welcome to the discord webhook test
echo.
set /p webhook="Please enter the webhook: "
echo.
for /f %%i in ('curl -s -o nul -w "%%{http_code}" "%webhook%"') do (
    set "STATUS=%%i"
)

if "%STATUS%"=="200" (
    echo Webhook is valid
) else (
    echo Webhook is invalid
	pause >nul
	exit
)

echo.
set /p message="Enter the message: "

set /p spam="Enter how much message you wanna sent: "

echo.

echo There are going to be rate limted and not fully sent all the message!!!

echo.

for /L %%i in (1,1,%spam%) do (
	curl -H "Content-Type: application/json" -X POST -d "{\"content\": \"%message%\"}" %webhook%
	echo Sending message: %message%
)

echo.
echo Go check if it work or something
pause >nul
goto menu


:delete
cls
echo Welcome to the ass delete discord webhook
echo.
echo Enter a webhook:
set /p deleteweb="$> "

curl -X DELETE %deleteweb%
echo Sucessfully delete webhook
pause >nul
goto menu

:name
cls
echo Welcome to chatgpt change name thing
echo.
echo Please enter the webhook:
set /p web_name="$> "

echo.
echo Enter a name for the webhook:
set /p new_name="$> "

curl -X PATCH %web_name% ^
  -H "Content-Type: application/json" ^
  -d "{\"name\": \"%new_name%\"}" >nul 2>&1
echo.
echo Sucessfully change the name to: %new_name% i think . . .
pause >nul
goto menu

:check
cls
echo Welcome to the most sigma vaild checker lol
echo.
echo Please enter the webhook to check:
set /p check="$> "

cls
for /f %%i in ('curl -s -o nul -w "%%{http_code}" "%check%"') do (
    set "STATUS=%%i"
)

if "%STATUS%"=="200" (
    echo Webhook is valid
) else (
    echo Webhook is invalid lool
	pause >nul
	goto menu
)
echo.
echo.
echo INFO:
powershell -Command "Invoke-RestMethod -Uri '%check%' | ConvertTo-Json -Depth 10"
  
echo.
echo okay that is enough proof to see if it vaild or invaild
pause >nul
goto menu