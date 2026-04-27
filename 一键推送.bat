@echo off
chcp 65001 >nul
echo ========================================
echo   婚查查 - GitHub 一键推送
echo ========================================
echo.

cd /d "%~dp0"

echo [1/3] 添加远程仓库...
"C:\Program Files\Git\cmd\git.exe" remote remove origin 2>nul
"C:\Program Files\Git\cmd\git.exe" remote add origin https://github.com/limeng0901-create/MRQBNAYOM.git

echo [2/3] 添加并提交代码...
"C:\Program Files\Git\cmd\git.exe" add -A
"C:\Program Files\Git\cmd\git.exe" commit -m "婚查查 v3.4 - 专业命理婚配APP"

echo [3/3] 正在推送到 GitHub（可能需要等待几秒）...
"C:\Program Files\Git\cmd\git.exe" branch -M main
"C:\Program Files\Git\cmd\git.exe" push -u origin main

echo.
echo ========================================
if %errorlevel% equ 0 (
    echo   推送成功！
    echo   仓库地址: https://github.com/limeng0901-create/MRQBNAYOM
) else (
    echo   推送失败，请检查网络后重试
)
echo ========================================
echo.
pause
