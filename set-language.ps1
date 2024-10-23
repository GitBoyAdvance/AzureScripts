# setup-language.ps1

# エラーハンドリングを有効化
$ErrorActionPreference = "Stop"

# 日本語言語パックのインストール
try {
    # 既に日本語パックがインストールされているか確認
    $installedLangs = Get-WinUserLanguageList
    if ($installedLangs.LanguageTag -notcontains "ja-JP") {
        Write-Host "日本語言語パックをインストールします。"

        # DISMで日本語言語パックをインストール
        dism.exe /online /add-capability /capabilityname:Language.Basic~~~ja-JP~0.0.1.0
        dism.exe /online /add-capability /capabilityname:Language.Handwriting~~~ja-JP~0.0.1.0
        dism.exe /online /add-capability /capabilityname:Language.OCR~~~ja-JP~0.0.1.0
        dism.exe /online /add-capability /capabilityname:Language.Speech~~~ja-JP~0.0.1.0
        dism.exe /online /add-capability /capabilityname:Language.TextToSpeech~~~ja-JP~0.0.1.0

        Write-Host "日本語言語パックのインストールが完了しました。"
    } else {
        Write-Host "日本語言語パックは既にインストールされています。"
    }
} catch {
    Write-Host "エラー: 日本語言語パックのインストールに失敗しました。"
    exit 1
}

# 日本語をデフォルトのUI言語に設定
try {
    Write-Host "日本語をデフォルトのUI言語に設定しています。"
    Set-WinUILanguageOverride -Language ja-JP
    Set-WinUserLanguageList -LanguageList ja-JP -Force
    Set-WinSystemLocale ja-JP
    Set-Culture ja-JP
    Set-WinHomeLocation -GeoId 0x7A
    Write-Host "UI言語設定を日本語に変更しました。"
} catch {
    Write-Host "エラー: 言語設定の変更に失敗しました。"
    exit 1
}

# システムの再起動を促す
Write-Host "システムを再起動してください。言語設定の変更を反映するために再起動が必要です。"
