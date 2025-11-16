# ============================================================
# 🚀 AI2025 PowerShell Profile (Ron Tinnel)
# GitHub version — used by Update-AI2025Profile
# ============================================================

# -------------------------------
# Environment & UTF-8 configuration
# -------------------------------
[Console]::OutputEncoding  = [System.Text.Encoding]::UTF8
[Console]::InputEncoding   = [System.Text.Encoding]::UTF8
$PSStyle.OutputRendering   = "Ansi"

# -------------------------------
# Visual Header
# -------------------------------
Write-Host ""
Write-Host "=============================================" -ForegroundColor DarkCyan
Write-Host "   🧠 AI2025 Profile Loaded Successfully" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor DarkCyan
Write-Host ""

# -------------------------------
# Helper Aliases
# -------------------------------
Set-Alias run-owl       "C:\AI2025\run-owl-script.ps1"
Set-Alias owl           "C:\AI2025\run-owl-script.ps1"
Set-Alias aos           "C:\AI2025\run-owl-script.ps1"

# -------------------------------
# Log Directory
# -------------------------------
$global:AI2025LogDir = "C:\AI2025\logs"
if (!(Test-Path $AI2025LogDir)) {
    New-Item -ItemType Directory -Path $AI2025LogDir | Out-Null
}

# -------------------------------
# Self-update function
# -------------------------------
function Update-AI2025Profile {
    Write-Host "🚀 Starting AI2025 profile update..." -ForegroundColor Cyan

    # Backup current profile
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $backupPath = "$PROFILE.bak_$timestamp"
    Copy-Item -Path $PROFILE -Destination $backupPath -Force
    Write-Host "✅ Backup created at $backupPath" -ForegroundColor Green

    # Raw GitHub URL
    $rawUrl = "https://raw.githubusercontent.com/RonTinnel/hello/main/Microsoft.PowerShell_profile.ps1"

    try {
        Write-Host "⬇ Downloading updated profile from GitHub..." -ForegroundColor Cyan
        Invoke-WebRequest -Uri $rawUrl -OutFile $PROFILE -UseBasicParsing
        Write-Host "✅ AI2025 Profile updated successfully!" -ForegroundColor Green

        # Reload updated profile
        . $PROFILE
    }
    catch {
        Write-Host "❌ Error updating AI2025 Profile: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "⚠ Verify raw GitHub URL and network access." -ForegroundColor Yellow
    }
}

# -------------------------------
# Dashboard Summary
# -------------------------------
Write-Host "📌 Shortcuts Loaded:" -ForegroundColor Yellow
Write-Host "   • owl / aos / run-owl : Run Owl ML scripts"
Write-Host "   • Update-AI2025Profile : Self-update profile from GitHub"
Write-Host ""
Write-Host "📁 Logs stored at: $AI2025LogDir" -ForegroundColor Yellow
Write-Host "============================================="
Write-Host ""
