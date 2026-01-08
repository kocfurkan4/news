@echo off
chcp 65001 >nul
echo ========================================
echo News Agent Baslatiliyor...
echo ========================================
echo.

REM .env dosyasi kontrolu
if not exist .env (
    echo HATA: .env dosyasi bulunamadi!
    echo Lutfen once setup-fixed.bat dosyasini calistirin.
    pause
    exit /b 1
)

REM API key kontrolu
findstr /C:"your-api-key-here" .env > nul
if %errorlevel% equ 0 (
    echo.
    echo UYARI: API anahtari guncellenmemis!
    echo .env dosyasini acip OPENAI_API_KEY degerini girin.
    echo.
    choice /C YN /M ".env dosyasini simdi duzenlemek ister misiniz (Y/N)"
    if errorlevel 2 goto skip_edit
    if errorlevel 1 notepad .env
    :skip_edit
    echo.
)

echo Proje calistiriliyor...
echo Konu: LLM (src/ai_news/main.py dosyasindan degistirebilirsiniz)
echo.
echo Lutfen bekleyin, bu islem 2-5 dakika surebilir...
echo.

REM Once crewai komutunu dene
crewai run 2>nul
if %errorlevel% equ 0 goto success

REM crewai bulunamazsa python -m ile calistir
echo.
echo 'crewai' komutu bulunamadi, alternatif yontem deneniyor...
echo.
python -m crewai run
if %errorlevel% equ 0 goto success

REM O da calısmazsa dogrudan python ile calistir
echo.
echo Alternatif yontem de calismadi, dogrudan Python ile calistirilıyor...
echo.
cd src\ai_news
python main.py
if %errorlevel% equ 0 goto success_direct

REM Hicbiri calısmazsa
echo.
echo ================================
echo HATA: Proje baslatılamadi!
echo ================================
echo.
echo Muhtemel sebepler:
echo - CrewAI duzgun yuklenemedi
echo - Python PATH'e eklenmemis
echo - API anahtari hatali
echo.
echo Manuel calistirma:
echo   cd src\ai_news
echo   python main.py
echo.
pause
exit /b 1

:success_direct
cd ..\..
:success
echo.
echo ================================
echo Basarili!
echo ================================
echo.
echo Olusturulan haber makalesi src\ai_news\news\ klasorundedir.
echo.

REM Olusan dosyayi goster
if exist src\ai_news\news\*.md (
    echo Olusturulan dosyalar:
    dir /B src\ai_news\news\*.md
    echo.
    choice /C YN /M "Dosyayi acmak ister misiniz (Y/N)"
    if errorlevel 2 goto end
    if errorlevel 1 (
        for /f "delims=" %%i in ('dir /B /O:D src\ai_news\news\*.md') do set "LATEST=%%i"
        notepad src\ai_news\news\!LATEST!
    )
)

:end
pause
