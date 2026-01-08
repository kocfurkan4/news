@echo off
echo ================================
echo News Agent Baslatiliyor...
echo ================================
echo.

REM .env dosyasini kontrol et
if not exist .env (
    echo HATA: .env dosyasi bulunamadi!
    echo Lutfen once setup.bat dosyasini calistirin.
    pause
    exit /b 1
)

REM API key kontrolu
findstr /C:"your-api-key-here" .env > nul
if %errorlevel% equ 0 (
    echo.
    echo UYARI: .env dosyasinda API anahtari guncellenmemis!
    echo Lutfen .env dosyasini acip OPENAI_API_KEY degerini girin.
    echo.
    choice /C YN /M ".env dosyasini simdi duzenlemek ister misiniz"
    if errorlevel 2 goto skip_edit
    if errorlevel 1 notepad .env
    :skip_edit
    echo.
)

echo Proje calistiriliyor...
echo Konu: LLM (src/ai_news/main.py dosyasindan degistirebilirsiniz)
echo.
echo Lutfen bekleyin, bu islem birkaç dakika surebilir...
echo.

crewai run

if %errorlevel% equ 0 (
    echo.
    echo ================================
    echo Basarili!
    echo ================================
    echo.
    echo Olusturulan haber makalesi src/ai_news/news/ klasorundedir.
    echo.
) else (
    echo.
    echo ================================
    echo HATA: Bir sorun olustu!
    echo ================================
    echo.
    echo Muhtemel sebepler:
    echo - API anahtari hatali veya eksik
    echo - Internet baglantisi yok
    echo - Krediniz bitmis olabilir
    echo.
)

pause
