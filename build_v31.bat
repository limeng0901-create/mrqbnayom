@echo off
chcp 65001 >nul
cd /d "%~dp0"

:: 设置环境变量
set JAVA_HOME=C:\Program Files\Java\jdk-17
set ANDROID_HOME=C:\Users\admin\AppData\Local\Android\Sdk
set ANDROID_SDK_ROOT=C:\Users\admin\AppData\Local\Android\Sdk

echo ==========================================
echo  五维易断 v1.1 构建脚本
echo ==========================================
echo.

:: 清理之前的构建
echo [1/3] 清理之前的构建...
call gradlew.bat clean --no-daemon 2>nul

:: 构建APK
echo [2/3] 开始构建APK...
call gradlew.bat assembleDebug --no-daemon

:: 检查结果
echo [3/3] 检查构建结果...
if exist "app\build\outputs\apk\debug\app-debug.apk" (
    echo.
    echo ==========================================
    echo  ✅ 构建成功！
    echo ==========================================
    copy "app\build\outputs\apk\debug\app-debug.apk" "..\五维易断_v1.1.apk" /Y
    echo 📱 APK已复制到桌面：五维易断_v1.1.apk
    echo.
) else (
    echo.
    echo ==========================================
    echo  ❌ 构建失败
    echo ==========================================
    echo 请检查错误信息
    echo.
)

pause
