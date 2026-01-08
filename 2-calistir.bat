@echo off
title News Agent - Calistirma
color 0A

echo.
echo =======================================
echo    NEWS AGENT - BASLATILIYOR
echo =======================================
echo.
timeout /t 2 /nobreak >nul

echo.
echo [KONTROL 1/4] .env dosyasi kontrol ediliyor...
if not exist .env (
    echo.
    echo [HATA] .env dosyasi bulunamadi!
    echo.
    echo Lutfen once "1-kurulum.bat" dosyasini calistirin.
    echo.
    echo Kapatmak icin bir tusa basin...
    pause >nul
    exit /b 1
)
echo [OK] .env dosyasi mevcut
timeout /t 1 >nul

echo.
echo [KONTROL 2/4] API anahtari kontrol ediliyor...
findstr /C:"your-api-key-here" .env >nul 2>&1
if not errorlevel 1 (
    echo.
    echo [UYARI] API anahtari guncellenmemis!
    echo.
    echo .env dosyasini acip OPENAI_API_KEY degerini
    echo kendi API anahtarinizla degistirmelisiniz.
    echo.
    choice /C YN /M ".env dosyasini simdi acmak ister misiniz (Y/N)"
    if errorlevel 2 goto skip_api
    if errorlevel 1 (
        notepad .env
        echo.
        echo API anahtarini girdikten sonra kaydedin ve
        echo bu dosyayi tekrar calistirin.
        echo.
        pause
        exit /b 0
    )
    :skip_api
    echo.
    echo API anahtari olmadan devam edilecek...
    echo Muhtemelen hata alacaksiniz.
    echo.
    timeout /t 3 >nul
)

echo.
echo [KONTROL 3/4] Python ve CrewAI kontrol ediliyor...
python --version >nul 2>&1
if errorlevel 1 (
    echo [HATA] Python bulunamadi!
    echo Lutfen "1-kurulum.bat" dosyasini calistirin.
    pause
    exit /b 1
)
pip show crewai >nul 2>&1
if errorlevel 1 (
    echo [HATA] CrewAI kurulu degil!
    echo Lutfen "1-kurulum.bat" dosyasini calistirin.
    pause
    exit /b 1
)
echo [OK] Python ve CrewAI hazir
timeout /t 1 >nul

echo.
echo [KONTROL 4/4] Proje dosyalari kontrol ediliyor...
if not exist "src\ai_news\main.py" (
    echo [HATA] Proje dosyalari bulunamadi!
    echo Bu bat dosyasini News-Agent-main klasorunde calistirdiginizdan emin olun.
    pause
    exit /b 1
)
echo [OK] Proje dosyalari mevcut
timeout /t 1 >nul

echo.
echo =======================================
echo    PROJE CALISTIRILIYOR...
echo =======================================
echo.
echo Konu: LLM (Large Language Models)
echo.
echo LUTFEN BEKLEYIN!
echo Bu islem 2-5 dakika surebilir.
echo Bu pencereyi KAPATMAYIN!
echo.
timeout /t 3 >nul

REM Oncelikle crewai komutunu deneyelim
crewai run >nul 2>&1
if not errorlevel 1 goto success

REM crewai komutu calismadiysa python -m ile deneyelim
echo.
echo [BILGI] "crewai" komutu bulunamadi, alternatif yontem deneniyor...
echo.
python -m crewai run 2>&1
if not errorlevel 1 goto success

REM O da calismadiysa dogrudan Python ile calistiralim
echo.
echo [BILGI] Dogrudan Python ile calistirilacak...
echo.
cd src\ai_news
python main.py
if not errorlevel 1 (
    cd ..\..
    goto success
)

REM Hicbiri calismadiysa
echo.
echo =======================================
echo    HATA OLUSTU!
echo =======================================
echo.
echo Proje calistirilamadi.
echo.
echo Muhtemel sebepler:
echo - API anahtari hatali veya eksik
echo - Internet baglantisi yok
echo - OpenAI krediniz bitmis olabilir
echo - CrewAI duzgun kurulmamis
echo.
echo Ne yapabilirsiniz:
echo 1. .env dosyasindaki API anahtarini kontrol edin
echo 2. Internet baglantinizi kontrol edin
echo 3. "1-kurulum.bat" dosyasini tekrar calistirin
echo.
echo Manuel calistirma:
echo   cd src\ai_news
echo   python main.py
echo.
pause
exit /b 1

:success
echo.
echo =======================================
echo    BASARILI!
echo =======================================
echo.
echo Haber makalesi olusturuldu!
echo.
echo Dosya konumu: src\ai_news\news\
echo.

REM Olusan dosyalari goster
if exist "src\ai_news\news\*.md" (
    echo Olusturulan dosyalar:
    dir /B "src\ai_news\news\*.md"
    echo.
    choice /C YN /M "Makaleleyi acmak ister misiniz (Y/N)"
    if errorlevel 2 goto end
    if errorlevel 1 (
        for /f "delims=" %%i in ('dir /B /O:-D "src\ai_news\news\*.md" 2^>nul') do (
            notepad "src\ai_news\news\%%i"
            goto end
        )
    )
)

:end
echo.
echo Kapatmak icin bir tusa basin...
pause >nul
