@echo off
chcp 65001 >nul
echo ========================================
echo   生成 GitHub SSH 密钥
echo ========================================
echo.

:: 检查密钥是否已存在
if exist "C:\Users\admin\.ssh\id_rsa" (
    echo SSH 密钥已存在，跳过生成步骤
    echo.
    goto :show_key
)

:: 生成 SSH 密钥
echo [1/2] 正在生成 SSH 密钥...
"C:\Program Files\Git\usr\bin\ssh-keygen.exe" -t rsa -C "limeng0901-create@users.noreply.github.com" -f "C:\Users\admin\.ssh\id_rsa" -q < NUL

if %errorlevel% equ 0 (
    echo [2/2] SSH 密钥生成成功！
) else (
    echo SSH 密钥生成失败
    pause
    exit /b 1
)

:show_key
echo.
echo ========================================
echo   请复制以下公钥到 GitHub
echo ========================================
echo.
type "C:\Users\admin\.ssh\id_rsa.pub"
echo.
echo ========================================
echo   操作步骤：
echo   1. 复制上面的公钥（以 ssh-rsa 开头）
echo   2. 访问 https://github.com/settings/keys
echo   3. 点击 "New SSH key"
echo   4. 粘贴公钥，标题随意
echo   5. 点击 "Add SSH key"
echo ========================================
echo.
echo 添加完成后，输入任意内容继续推送...
pause >nul

:: 测试 SSH 连接
echo.
echo 测试 SSH 连接...
"C:\Program Files\Git\usr\bin\ssh.exe" -T git@github.com -o StrictHostKeyChecking=no

:: 推送代码
echo.
echo 开始推送代码...
cd /d "%~dp0"
git push -u origin main

echo.
if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo   推送成功！
    echo   仓库地址: https://github.com/limeng0901-create/MRQBNAYOM
    echo ========================================
) else (
    echo.
    echo ========================================
    echo   推送失败，请检查 SSH 密钥是否添加成功
    echo ========================================
)
echo.
pause
