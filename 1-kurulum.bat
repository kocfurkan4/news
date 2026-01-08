@echo off
title News Agent - Kurulum
color 0B

echo.
echo =======================================
echo    NEWS AGENT - KURULUM BASLIYOR
echo =======================================
echo.
echo UYARI: Bu pencereyi KAPATMAYIN!
echo Kurulum tamamlanana kadar bekleyin...
echo.
timeout /t 3 /nobreak >nul

echo.
echo =======================================
echo [ADIM 1/7] Python Kontrolu
echo =======================================
python --version >nul 2>&1
if errorlevel 1 (
    echo.
    echo [HATA] Python bulunamadi!
    echo.
    echo Lutfen asagidaki adrese gidin ve Python yukleyin:
    echo https://www.python.org/downloads/
    echo.
    echo ONEMLI: Kurulum sirasinda "Add Python to PATH" secenegini isaretleyin!
    echo.
    echo Kurulum bittikten sonra bilgisayari yeniden baslatin.
    echo.
    echo Devam etmek icin bir tusa basin...
    pause >nul
    exit /b 1
)
python --version
echo [OK] Python bulundu!
timeout /t 2 >nul

echo.
echo =======================================
echo [ADIM 2/7] pip Guncelleniyor
echo =======================================
python -m pip install --upgrade pip
if errorlevel 1 (
    echo [UYARI] pip guncellenemedi, devam ediliyor...
) else (
    echo [OK] pip guncellendi!
)
timeout /t 2 >nul

echo.
echo =======================================
echo [ADIM 3/7] CrewAI Kuruluyor
echo =======================================
echo Bu islem 1-2 dakika surebilir, lutfen bekleyin...
echo.
pip install crewai --quiet
if errorlevel 1 (
    echo [HATA] CrewAI kurulamadi!
    echo.
    echo Lutfen internet baglantinizi kontrol edin.
    echo.
    pause
    exit /b 1
)
echo [OK] CrewAI kuruldu!
timeout /t 2 >nul

echo.
echo =======================================
echo [ADIM 4/7] CrewAI Tools Kuruluyor
echo =======================================
pip install "crewai[tools]" --quiet
if errorlevel 1 (
    echo [UYARI] Tools kurulamadi, temel kurulum yeterli
) else (
    echo [OK] Tools kuruldu!
)
timeout /t 2 >nul

echo.
echo =======================================
echo [ADIM 5/7] Ek Paketler Kuruluyor
echo =======================================
pip install python-dotenv langchain langchain-openai openai --quiet
echo [OK] Ek paketler kuruldu!
timeout /t 2 >nul

echo.
echo =======================================
echo [ADIM 6/7] Kurulum Kontrol Ediliyor
echo =======================================
pip show crewai >nul 2>&1
if errorlevel 1 (
    echo [HATA] CrewAI duzgun kurulmadi!
    echo.
    echo Manuel kurulum icin su komutu deneyin:
    echo pip install crewai
    echo.
    pause
    exit /b 1
)
echo [OK] CrewAI kurulumu doğrulandi!
timeout /t 2 >nul

echo.
echo =======================================
echo [ADIM 7/7] .env Dosyasi Hazirlaniyor
echo =======================================
if exist .env (
    echo [OK] .env dosyasi zaten mevcut
) else (
    echo OPENAI_API_KEY=your-api-key-here> .env
    echo [OK] .env dosyasi olusturuldu
)
timeout /t 2 >nul

echo.
echo =======================================
echo    KURULUM TAMAMLANDI!
echo =======================================
echo.
echo Simdi yapmaniz gerekenler:
echo.
echo 1. .env dosyasini acin (Not Defteri ile)
echo 2. "your-api-key-here" yerine OpenAI API anahtarinizi yapisirin
echo 3. Kaydedin ve kapatin
echo 4. "2-calistir.bat" dosyasini calistirin
echo.
echo .env dosyasini simdi acmak ister misiniz?
echo.
choice /C YN /M "Evet icin Y, Hayir icin N basin"
if errorlevel 2 goto end
if errorlevel 1 notepad .env

:end
echo.
echo Kapatmak icin bir tusa basin...
pause >nul
