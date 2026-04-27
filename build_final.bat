@echo off
chcp 65001 >nul
cd /d "%~dp0"

:: 使用系统环境变量（已设置好）
echo ==========================================
echo  五维易断 v1.1 构建脚本
echo ==========================================
echo.
echo JAVA_HOME: %JAVA_HOME%
echo ANDROID_HOME: %ANDROID_HOME%
echo.

:: 清理Gradle wrapper缓存（解决锁定问题）
echo [1/4] 清理Gradle缓存...
if exist "%USERPROFILE%\.gradle\wrapper\dists\gradle-8.11-bin" (
    rmdir /S /Q "%USERPROFILE%\.gradle\wrapper\dists\gradle-8.11-bin" 2>nul
)
if exist "%USERPROFILE%\.gradle\wrapper\dists\gradle-8.10-all" (
    rmdir /S /Q "%USERPROFILE%\.gradle\wrapper\dists\gradle-8.10-all" 2>nul
)

:: 清理项目构建缓存
echo [2/4] 清理项目构建缓存...
call gradlew.bat clean --no-daemon 2>nul
if errorlevel 1 (
    echo 清理完成（或无需清理）
)

:: 构建APK
echo [3/4] 开始构建APK...
echo 这可能需要几分钟，请耐心等待...
echo.
call gradlew.bat assembleDebug --no-daemon --stacktrace

:: 检查结果
echo.
echo [4/4] 检查构建结果...
if exist "app\build\outputs\apk\debug\app-debug.apk" (
    echo.
    echo ==========================================
    echo  ✅ 构建成功！
    echo ==========================================
    copy "app\build\outputs\apk\debug\app-debug.apk" "..\五维易断_v1.1.apk" /Y >nul
    echo 📱 APK已复制到桌面：五维易断_v1.1.apk
    echo 📂 原始文件：app\build\outputs\apk\debug\app-debug.apk
    echo.
    for %%I in ("..\五维易断_v1.1.apk") do echo 📊 文件大小：%%~zI 字节
    echo.
) else (
    echo.
    echo ==========================================
    echo  ❌ 构建失败
    echo ==========================================
    echo 请检查上面的错误信息
    echo 常见原因：
    echo   1. 网络问题（下载Gradle失败）
    echo   2. SDK组件缺失
    echo   3. 代码错误
    echo.
)

pause
