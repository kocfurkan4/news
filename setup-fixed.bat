@echo off
chcp 65001 >nul
echo ========================================
echo News Agent - Gelismis Kurulum
echo ========================================
echo.

REM Python kontrolu
echo [1/6] Python kontrol ediliyor...
python --version 2>nul
if %errorlevel% neq 0 (
    echo.
    echo HATA: Python yuklu degil!
    echo Python 3.10, 3.11 veya 3.12 yukleyin: https://www.python.org/downloads/
    pause
    exit /b 1
)
echo ✓ Python bulundu

echo.
echo [2/6] pip guncelleniyor...
python -m pip install --upgrade pip
echo ✓ pip guncellendi

echo.
echo [3/6] uv kuruluyor...
pip install uv
if %errorlevel% neq 0 (
    echo ! UV yuklenemedi, devam ediliyor...
)

echo.
echo [4/6] CrewAI kuruluyor (bu biraz surebilir)...
pip install crewai
if %errorlevel% neq 0 (
    echo HATA: CrewAI kurulamadi!
    pause
    exit /b 1
)
echo ✓ CrewAI kuruldu

echo.
echo [5/6] CrewAI tools kuruluyor...
pip install "crewai[tools]"
if %errorlevel% neq 0 (
    echo ! Tools yuklenemedi, temel kurulum ile devam
)

echo.
echo [6/6] Ek paketler kuruluyor...
pip install python-dotenv
pip install langchain
pip install langchain-openai
pip install openai

echo.
echo [Kontrol] CrewAI versiyonu:
pip show crewai | findstr Version
crewai version 2>nul
if %errorlevel% neq 0 (
    echo.
    echo UYARI: 'crewai' komutu bulunamadi!
    echo Python Scripts klasoru PATH'e eklenmemis olabilir.
    echo.
    echo Manuel calistirma icin su komutu kullanin:
    echo   python -m crewai run
)

echo.
echo [.env] API Key dosyasi hazirlaniyor...
if not exist .env (
    (
        echo OPENAI_API_KEY=your-api-key-here
    ) > .env
    echo ✓ .env dosyasi olusturuldu
    echo.
    echo ONEMLI: Simdi .env dosyasini acip API anahtarinizi girin!
    timeout /t 2 >nul
    notepad .env
) else (
    echo ✓ .env dosyasi zaten mevcut
)

echo.
echo ========================================
echo Kurulum Tamamlandi!
echo ========================================
echo.
echo Simdi yapmaniz gerekenler:
echo 1. .env dosyasindaki API anahtarini guncellemeyi unutmayin!
echo 2. run-fixed.bat dosyasini calistirin
echo.
pause
