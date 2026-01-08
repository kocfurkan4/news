@echo off
chcp 65001 >nul
title News Agent - Ana Menu
color 0A

:menu
cls
echo ========================================
echo       NEWS AGENT - ANA MENU
echo ========================================
echo.
echo 1. Gelismis Kurulum (ONERILIR)
echo 2. Projeyi Calistir
echo 3. Python ve Paket Kontrolu
echo 4. Ayarlari Duzenle (.env)
echo 5. Konu Degistir (main.py)
echo 6. Manuel Calistirma (Python)
echo 7. Cikis
echo.
echo ========================================
choice /C 1234567 /N /M "Seciminiz (1-7): "

if errorlevel 7 goto exit
if errorlevel 6 goto manual_run
if errorlevel 5 goto edit_topic
if errorlevel 4 goto edit_env
if errorlevel 3 goto check_system
if errorlevel 2 goto run
if errorlevel 1 goto setup

:setup
cls
echo Gelismis kurulum baslatiliyor...
echo.
call setup-fixed.bat
pause
goto menu

:run
cls
echo Proje calistiriliyor...
echo.
call run-fixed.bat
goto menu

:check_system
cls
echo ========================================
echo Sistem Kontrolu
echo ========================================
echo.
echo [Python]
python --version
if %errorlevel% neq 0 (
    echo ! Python bulunamadi
) else (
    echo ✓ Python bulundu
)
echo.
echo [pip]
pip --version
echo.
echo [CrewAI]
pip show crewai 2>nul
if %errorlevel% neq 0 (
    echo ! CrewAI yuklu degil
) else (
    echo ✓ CrewAI yuklu
)
echo.
echo [crewai komutu]
crewai version 2>nul
if %errorlevel% neq 0 (
    echo ! 'crewai' komutu bulunamadi
    echo   Python Scripts PATH'e eklenmemis olabilir
) else (
    echo ✓ crewai komutu calisiyor
)
echo.
echo [.env dosyasi]
if exist .env (
    echo ✓ .env dosyasi mevcut
    findstr /C:"your-api-key-here" .env > nul
    if %errorlevel% equ 0 (
        echo ! API anahtari guncellenmemis
    ) else (
        echo ✓ API anahtari girilmis
    )
) else (
    echo ! .env dosyasi bulunamadi
)
echo.
pause
goto menu

:edit_env
cls
echo .env dosyasi aciliyor...
if exist .env (
    notepad .env
) else (
    echo .env dosyasi bulunamadi!
    echo Once kurulum yapin.
    pause
)
goto menu

:edit_topic
cls
echo main.py dosyasi aciliyor...
if exist src\ai_news\main.py (
    notepad src\ai_news\main.py
) else (
    echo main.py dosyasi bulunamadi!
    pause
)
goto menu

:manual_run
cls
echo ========================================
echo Manuel Calistirma
echo ========================================
echo.
echo Asagidaki komutu calistirin:
echo.
echo cd src\ai_news
echo python main.py
echo.
echo Veya:
echo.
echo python -m crewai run
echo.
pause
goto menu

:exit
cls
echo Cikiliyor...
timeout /t 1 /nobreak > nul
exit
