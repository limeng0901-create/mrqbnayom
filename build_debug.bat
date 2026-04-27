@echo off
cd /d "%~dp0"
set JAVA_HOME=C:\Program Files\Java\jdk-17
set ANDROID_HOME=C:\Users\admin\AppData\Local\Android\Sdk
set ANDROID_SDK_ROOT=C:\Users\admin\AppData\Local\Android\Sdk
echo Starting Gradle build...
call gradlew.bat assembleDebug --stacktrace --no-daemon 2>&1 | tee build_output.txt
echo.
echo Build finished!
if exist "app\build\outputs\apk\debug\app-debug.apk" (
    echo SUCCESS: APK generated at app\build\outputs\apk\debug\app-debug.apk
    copy "app\build\outputs\apk\debug\app-debug.apk" "..\五维易断_v3.1.apk"
    echo APK copied to Desktop: 五维易断_v3.1.apk
) else (
    echo ERROR: APK not found. Check build_output.txt for details.
)
pause
