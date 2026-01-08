@echo off
echo ================================
echo News Agent Kurulum Basliyacak
echo ================================
echo.

REM Python versiyonunu kontrol et
python --version
if %errorlevel% neq 0 (
    echo HATA: Python yuklu degil!
    echo Lutfen Python 3.10, 3.11 veya 3.12 yukleyin.
    pause
    exit /b 1
)

echo.
echo [1/4] UV paketi yukleniyor...
pip install uv
if %errorlevel% neq 0 (
    echo HATA: UV yuklenemedi!
    pause
    exit /b 1
)

echo.
echo [2/4] CrewAI yukleniyor...
pip install "crewai[tools]>=0.100.1,<1.0.0"
if %errorlevel% neq 0 (
    echo HATA: CrewAI yuklenemedi!
    pause
    exit /b 1
)

echo.
echo [3/4] Proje bagimliliklar yukleniyor...
crewai install
if %errorlevel% neq 0 (
    echo UYARI: crewai install hatasi (Normal olabilir)
)

echo.
echo [4/4] .env dosyasi kontrol ediliyor...
if not exist .env (
    echo .env dosyasi bulunamadi!
    echo .env.example dosyasi olusturuluyor...
    (
        echo OPENAI_API_KEY=your-api-key-here
    ) > .env
    echo.
    echo ONEMLI: .env dosyasini acip OPENAI_API_KEY degerini girin!
    notepad .env
)

echo.
echo ================================
echo Kurulum Tamamlandi!
echo ================================
echo.
echo Projeyi calistirmak icin run.bat dosyasini calistirin.
echo Oncesinde .env dosyasindaki API anahtarini guncellemeyi unutmayin!
echo.
pause
