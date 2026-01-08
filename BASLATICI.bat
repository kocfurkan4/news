@echo off
title News Agent - Baslatici
color 0E

:menu
cls
echo.
echo =======================================
echo        NEWS AGENT
echo =======================================
echo.
echo  1 - KURULUM (Ilk kez calistiracaklar)
echo  2 - CALISTIR (Kurulum bittikten sonra)
echo  3 - API Anahtarini Duzenle
echo  4 - Sistem Kontrolu
echo  5 - Cikis
echo.
echo =======================================
echo.

choice /C 12345 /N /M "Seciminiz (1-5): "

if errorlevel 5 goto exit
if errorlevel 4 goto check
if errorlevel 3 goto edit_env
if errorlevel 2 goto run
if errorlevel 1 goto setup

:setup
cls
echo.
echo Kurulum baslatiliyor...
echo.
timeout /t 2 >nul
call 1-kurulum.bat
goto menu

:run
cls
echo.
echo Proje calistiriliyor...
echo.
timeout /t 2 >nul
call 2-calistir.bat
goto menu

:edit_env
cls
echo.
echo .env dosyasi aciliyor...
echo.
if exist .env (
    notepad .env
) else (
    echo .env dosyasi bulunamadi!
    echo Lutfen once kurulum yapin.
    echo.
    pause
)
goto menu

:check
cls
echo.
echo =======================================
echo    SISTEM KONTROLU
echo =======================================
echo.

echo [Python Versiyonu]
python --version 2>nul
if errorlevel 1 (
    echo Python bulunamadi! Kurmaniz gerekiyor.
    echo https://www.python.org/downloads/
) else (
    echo OK
)
echo.

echo [pip Versiyonu]
pip --version 2>nul
if errorlevel 1 (
    echo pip bulunamadi!
) else (
    echo OK
)
echo.

echo [CrewAI Kurulumu]
pip show crewai 2>nul | findstr "Name Version"
if errorlevel 1 (
    echo CrewAI kurulu degil! Kurulum yapin.
) else (
    echo OK
)
echo.

echo [.env Dosyasi]
if exist .env (
    echo Mevcut
    findstr /C:"your-api-key-here" .env >nul 2>&1
    if not errorlevel 1 (
        echo UYARI: API anahtari guncellenmemis!
    ) else (
        echo API anahtari girilmis
    )
) else (
    echo .env dosyasi yok! Kurulum yapin.
)
echo.

echo [Proje Dosyalari]
if exist "src\ai_news\main.py" (
    echo Mevcut - OK
) else (
    echo Bulunamadi! Dosyalari kontrol edin.
)
echo.

echo =======================================
echo.
pause
goto menu

:exit
cls
echo.
echo Cikiliyor...
timeout /t 1 /nobreak >nul
exit
