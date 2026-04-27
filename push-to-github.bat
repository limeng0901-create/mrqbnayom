@echo off
chcp 65001 >nul
echo ========================================
echo   婚查查项目 - GitHub 一键推送脚本
echo ========================================
echo.

:: 检查 Git 是否安装
where git >nul 2>&1
if %errorlevel% neq 0 (
    echo [1/5] Git 未安装，正在下载安装...
    powershell -Command "Start-BitsTransfer -Source 'https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/Git-2.44.0-64-bit.exe' -Destination '$env:TEMP\git-installer.exe'"
    echo [2/5] 正在安装 Git（静默模式）...
    start /wait "" "%TEMP%\git-installer.exe" /SILENT /NORESTART /NOCANCEL
    set PATH=C:\Program Files\Git\bin;%PATH%
)

echo [3/5] 配置 Git 用户信息...
git config --global user.email "limeng0901-create@users.noreply.github.com"
git config --global user.name "limeng0901-create"

echo [4/5] 初始化仓库并推送代码...
cd /d "%~dp0"

:: 初始化仓库（如已存在则跳过）
if not exist ".git" (
    git init
    git remote add origin https://github.com/limeng0901-create/MRQBNAYOM.git
)

:: 添加所有文件
git add -A

:: 提交
git commit -m "婚查查 v3.4 - 专业命理婚配APP"

:: 推送
git branch -M main
git push -u origin main

echo.
echo ========================================
echo   推送完成！
echo ========================================
echo.
echo 仓库地址: https://github.com/limeng0901-create/MRQBNAYOM
echo.
pause
