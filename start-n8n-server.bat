@echo off
echo ================================================================
echo Starting n8n Self-Hosted Instance (One-Click Solution)
echo ================================================================
echo.

REM Check if config file exists - if not, run first-time setup
if not exist "config.txt" goto first_time_setup

echo [INFO] Loading saved configuration...

REM Read ngrok credentials from config.txt
for /f "tokens=1,2 delims==" %%a in ('findstr /r "^NGROK_AUTHTOKEN=" config.txt') do set NGROK_AUTHTOKEN=%%b
for /f "tokens=1,2 delims==" %%a in ('findstr /r "^NGROK_DOMAIN=" config.txt') do set NGROK_DOMAIN=%%b

echo [SUCCESS] Configuration loaded successfully!
echo [INFO] Domain: %NGROK_DOMAIN%
goto setupcomplete

:first_time_setup
echo [INFO] First time setup detected!
echo.
echo ================================================================
echo Welcome to n8n Self-Hosted Setup!
echo ================================================================
echo.
echo We need your ngrok credentials for public access.
echo Don't have ngrok? We'll help you sign up!
echo.

REM Offer to open ngrok signup page
set /p OPEN_NGROK="Do you want to open ngrok.com to sign up? (y/n): "
set "OPEN_NGROK=%OPEN_NGROK: =%"
if "%OPEN_NGROK%"=="y" call :open_ngrok_signup
if "%OPEN_NGROK%"=="Y" call :open_ngrok_signup

echo.
echo [STEP 1] Get your ngrok authentication token
echo.
set /p OPEN_TOKEN="Open ngrok authtoken page in browser? (y/n): "
set "OPEN_TOKEN=%OPEN_TOKEN: =%"

if "%OPEN_TOKEN%"=="y" call :open_token_page
if "%OPEN_TOKEN%"=="Y" call :open_token_page
if not "%OPEN_TOKEN%"=="y" if not "%OPEN_TOKEN%"=="Y"  echo Link: https://dashboard.ngrok.com/get-started/your-authtoken

echo.
set /p NGROK_AUTHTOKEN="Enter your NGROK_AUTHTOKEN: "

REM Validate authtoken is not empty and contains only valid characters
if "%NGROK_AUTHTOKEN%"=="" (
    echo [ERROR] Authtoken cannot be empty!
    pause
    exit /b 1
)

REM Basic validation - check for common injection patterns
echo %NGROK_AUTHTOKEN% | findstr /r "[;&|`]" >nul 2>&1
if not errorlevel 1 (
    echo [ERROR] Invalid characters in authtoken!
    pause
    exit /b 1
)

echo.
echo [STEP 2] Get your ngrok static domain
echo Format: your-domain-name.ngrok-free.app
echo.
set /p OPEN_DOMAIN="Open ngrok domains page in browser? (y/n): "
set "OPEN_DOMAIN=%OPEN_DOMAIN: =%"

if "%OPEN_DOMAIN%"=="y" call :open_domain_page
if "%OPEN_DOMAIN%"=="Y" call :open_domain_page
if not "%OPEN_DOMAIN%"=="y" if not "%OPEN_DOMAIN%"=="Y" echo Link: https://dashboard.ngrok.com/cloud-edge/domains

echo.
set /p NGROK_DOMAIN="Enter your NGROK_DOMAIN: "

REM Validate domain is not empty and contains only valid characters
if "%NGROK_DOMAIN%"=="" (
    echo [ERROR] Domain cannot be empty!
    pause
    exit /b 1
)

REM Basic validation - check for common injection patterns
echo %NGROK_DOMAIN% | findstr /r "[;&|`]" >nul 2>&1
if not errorlevel 1 (
    echo [ERROR] Invalid characters in domain!
    pause
    exit /b 1
)

echo.
echo [INFO] Saving configuration to config.txt...

REM Create config.txt with user's credentials
(
    echo # =================================================================
    echo # n8n Self-Hosted Configuration
    echo # =================================================================
    echo # Auto-generated on first run
    echo # Edit this file if you need to change your ngrok credentials
    echo # =================================================================
    echo.
    echo # Your ngrok authentication token
    echo NGROK_AUTHTOKEN=%NGROK_AUTHTOKEN%
    echo.
    echo # Your ngrok static domain
    echo NGROK_DOMAIN=%NGROK_DOMAIN%
    echo.
    echo # =================================================================
    echo # Configuration saved! Future runs will use these settings.
    echo # =================================================================
) > config.txt

echo [SUCCESS] Configuration saved to config.txt!
echo [INFO] Domain: %NGROK_DOMAIN%
goto setupcomplete

:setupcomplete

REM Auto-configure all other environment variables
set N8N_HOST=%NGROK_DOMAIN%
set WEBHOOK_URL=https://%NGROK_DOMAIN%/
set TIMEZONE=UTC

echo [INFO] Checking Docker installation...
docker version >nul 2>&1
if not errorlevel 1 (
    echo [SUCCESS] Docker is already installed and running!
    goto dockerready
)

echo [WARNING] Docker is not installed or not running.
echo.
echo [INFO] Checking if Docker is installed...

REM Check if Docker Desktop executable exists
if exist "C:\Program Files\Docker\Docker\Docker Desktop.exe" (
    echo [INFO] Docker Desktop found in Program Files. Attempting to start...
    goto start_docker
) else if exist "%LOCALAPPDATA%\Docker\Docker Desktop.exe" (
    echo [INFO] Docker Desktop found in LocalAppData. Attempting to start...
    goto start_docker
) else if exist "C:\Users\%USERNAME%\AppData\Local\Docker\Docker Desktop.exe" (
    echo [INFO] Docker Desktop found in User AppData. Attempting to start...
    goto start_docker
) else (
    echo [INFO] Docker Desktop not found. Opening download page...
    goto auto_install_docker
)

:auto_install_docker
echo.
echo [INFO] Opening Docker Desktop download page...
echo [INFO] Please download and install Docker Desktop manually.
echo [INFO] After installation, restart your computer if prompted, then run this script again.
start https://www.docker.com/products/docker-desktop/
pause
exit /b 0

:start_docker
echo [INFO] Attempting to start existing Docker Desktop...
set DOCKER_FOUND=0

if exist "C:\Program Files\Docker\Docker\Docker Desktop.exe" (
    start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"
    set DOCKER_FOUND=1
    echo [INFO] Starting Docker Desktop from Program Files...
) else if exist "%LOCALAPPDATA%\Docker\Docker Desktop.exe" (
    start "" "%LOCALAPPDATA%\Docker\Docker Desktop.exe"
    set DOCKER_FOUND=1
    echo [INFO] Starting Docker Desktop from LocalAppData...
) else if exist "C:\Users\%USERNAME%\AppData\Local\Docker\Docker Desktop.exe" (
    start "" "C:\Users\%USERNAME%\AppData\Local\Docker\Docker Desktop.exe"
    set DOCKER_FOUND=1
    echo [INFO] Starting Docker Desktop from User AppData...
) else (
    echo [ERROR] Docker Desktop not found in common locations.
    echo [INFO] Please install Docker Desktop first.
    goto auto_install_docker
)

if %DOCKER_FOUND%==1 (
    echo [INFO] Docker Desktop is starting... Checking status...
    set /a attempts=0
    goto checkdocker
)

goto dockerready

REM This section only runs if Docker Desktop was found and started

:checkdocker
set /a attempts+=1
timeout /t 5 /nobreak >nul
docker version >nul 2>&1
if not errorlevel 1 (
    echo [SUCCESS] Docker is now ready!
    goto dockerready
)
if %attempts% lss 60 (
    echo [INFO] Still waiting for Docker... ^(%attempts%/60^)
    goto checkdocker
)
echo [WARNING] Docker is taking longer than expected to start.
echo [INFO] You can press any key to continue anyway, or wait longer.
pause >nul

:dockerready
echo [INFO] Pulling latest Docker images...
docker-compose pull

echo [INFO] Starting n8n and ngrok services...
docker-compose up -d

echo [SUCCESS] Services started successfully!
echo [INFO] Waiting for services to initialize...
timeout /t 15 /nobreak >nul

echo [SUCCESS] n8n should now be accessible at: https://%NGROK_DOMAIN%
echo [INFO] Opening n8n in your browser...
start https://%NGROK_DOMAIN%
echo [INFO] If the browser didn't open, you can manually visit: https://%NGROK_DOMAIN%

echo.
echo ================================================================
echo n8n is now running!
echo ================================================================
echo.
echo Your n8n instance is accessible at:
echo   Public URL:  https://%NGROK_DOMAIN%
echo   Local URL:   http://localhost:5678
echo   ngrok Admin: http://localhost:4040
echo   Data Path:   .\n8n_data
:main_menu
echo.
echo Quick Actions:
echo   [L] View logs       [S] Stop services      [A] Open ngrok Admin
echo   [Q] Quit
echo.
set /p ACTION="Choose an action (L/S/A/Q): "
set "ACTION=%ACTION: =%"

if "%ACTION%"=="L" call :action_logs
if "%ACTION%"=="l" call :action_logs

if "%ACTION%"=="S" call :action_stop
if "%ACTION%"=="s" call :action_stop

if "%ACTION%"=="A" call :action_admin
if "%ACTION%"=="a" call :action_admin

if "%ACTION%"=="Q" call :action_quit
if "%ACTION%"=="q" call :action_quit

REM Default action for anything else
if not "%ACTION%"=="L" if not "%ACTION%"=="l" if not "%ACTION%"=="S" if not "%ACTION%"=="s" if not "%ACTION%"=="A" if not "%ACTION%"=="a" call :action_quit

REM ================================================================
REM SUBROUTINES (called from main script)
REM ================================================================

:open_ngrok_signup
echo [INFO] Opening ngrok.com in your browser...
start https://ngrok.com/
echo [INFO] After signing up, come back here to continue setup.
pause
exit /b

:open_token_page
echo [INFO] Opening ngrok dashboard...
start https://dashboard.ngrok.com/get-started/your-authtoken
echo [INFO] Copy your authtoken from the browser and paste it below.
exit /b

:open_domain_page
echo [INFO] Opening ngrok domains page...
start https://dashboard.ngrok.com/cloud-edge/domains
echo [INFO] Create a domain or copy your existing domain from the browser.
exit /b

:action_logs
echo [INFO] Showing live logs... Press Ctrl+C to return to menu.
docker-compose logs -f
pause
goto main_menu

:action_stop
echo [INFO] Stopping services...
docker-compose down
echo [SUCCESS] Services stopped!
pause
goto main_menu

:action_admin
echo [INFO] Opening ngrok admin dashboard...
start http://localhost:4040
goto main_menu

:action_quit
exit