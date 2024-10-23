# setup-language.ps1

# エラーハンドリングを有効化
$ErrorActionPreference = "Stop"

# 日本語言語パックをインストール
try {
    if (-not (Get-WindowsFeature -Name Language-Pack-Ja-JP)) {
        Install-WindowsFeature -Name Language-Pack-Ja-JP
    }
    Write-Host "日本語言語パックのインストールが完了しました。"
} catch {
    Write-Host "エラー: 言語パックのインストールに失敗しました。"
    exit 1
}

# 言語設定を日本語に変更
try {
    Set-WinUILanguageOverride -Language ja-JP
    Set-WinUserLanguageList -LanguageList ja-JP -Force
    Set-WinSystemLocale ja-JP
    Set-Culture ja-JP
    Set-WinHomeLocation -GeoId 0x7A
    Write-Host "言語設定を日本語に変更しました。"
} catch {
    Write-Host "エラー: 言語設定の変更に失敗しました。"
    exit 1
}

# 再起動が必要かどうか確認し、必要な場合のみ再起動
if ((Get-WindowsFeature -Name Language-Pack-Ja-JP).RestartNeeded) {
    Write-Host "再起動が必要です。システムを再起動します。"
    Restart-Computer -Force
} else {
    Write-Host "再起動は不要です。"
}
