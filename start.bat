@echo off
title News Agent - Hizli Baslatma
color 0A

:menu
cls
echo ========================================
echo       NEWS AGENT - ANA MENU
echo ========================================
echo.
echo 1. Kurulum Yap (Ilk kez calistirilacak)
echo 2. Projeyi Calistir
echo 3. Ayarlari Duzenle (.env)
echo 4. Konu Degistir (main.py)
echo 5. Cikis
echo.
echo ========================================
choice /C 12345 /N /M "Seciminiz (1-5): "

if errorlevel 5 goto exit
if errorlevel 4 goto edit_topic
if errorlevel 3 goto edit_env
if errorlevel 2 goto run
if errorlevel 1 goto setup

:setup
cls
echo Kurulum baslatiliyor...
echo.
call setup.bat
pause
goto menu

:run
cls
echo Proje calistiriliyor...
echo.
call run.bat
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

:exit
cls
echo Cikiliyor...
timeout /t 1 /nobreak > nul
exit
