# 婚查查 - Git 一键部署脚本
# 请右键点击此文件，选择 "使用 PowerShell 运行"

$ErrorActionPreference = "Stop"

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "  婚查查 Git 一键部署工具" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# 检查 Git
$gitPath = Get-Command git -ErrorAction SilentlyContinue
if (-not $gitPath) {
    Write-Host "[1/5] 正在安装 Git..." -ForegroundColor Yellow
    winget install --id Git.Git -e --source winget --accept-package-agreements --accept-source-agreements --silent
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    Write-Host "[OK] Git 安装完成" -ForegroundColor Green
} else {
    Write-Host "[跳过] Git 已安装: $($gitPath.Source)" -ForegroundColor Gray
}

# 刷新 PATH
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# 项目目录
$projectDir = "C:\Users\admin\Desktop\HunChaCha"
Set-Location $projectDir

Write-Host ""
Write-Host "[2/5] 初始化 Git 仓库..." -ForegroundColor Yellow
git init
git add .
git commit -m "Initial commit: 婚查查 Android 项目 v1.1"

Write-Host ""
Write-Host "[3/5] GitHub 仓库设置" -ForegroundColor Yellow
Write-Host "请打开以下链接创建 GitHub 仓库:" -ForegroundColor White
Write-Host "  https://github.com/new" -ForegroundColor Cyan
Write-Host ""
Write-Host "创建仓库时:" -ForegroundColor White
Write-Host "  - 仓库名称: HunChaCha" -ForegroundColor White
Write-Host "  - 选择 Private (私有)" -ForegroundColor White
Write-Host "  - 不要勾选 'Add a README'" -ForegroundColor White
Write-Host ""

# 询问 GitHub 用户名和仓库名
$githubUser = Read-Host "请输入你的 GitHub 用户名"
$repoName = "HunChaCha"

Write-Host ""
Write-Host "[4/5] 连接远程仓库并推送..." -ForegroundColor Yellow
git remote add origin "https://github.com/$githubUser/$repoName.git"
git branch -M main
git push -u origin main --force

Write-Host ""
Write-Host "======================================" -ForegroundColor Green
Write-Host "  部署完成！" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Green
Write-Host ""
Write-Host "查看构建状态: https://github.com/$githubUser/$repoName/actions" -ForegroundColor Cyan
Write-Host "下载 APK: 进入 Actions -> 点击最新的构建 -> Artifacts" -ForegroundColor White
Write-Host ""
Read-Host "按回车键退出"
