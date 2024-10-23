# setup-language.ps1
# 日本語言語パックをインストール
Install-WindowsFeature -Name Language-Pack-Ja-JP

# 言語設定を日本語に変更
Set-WinUILanguageOverride -Language ja-JP
Set-WinUserLanguageList -LanguageList ja-JP -Force
Set-WinSystemLocale ja-JP
Set-Culture ja-JP
Set-WinHomeLocation -GeoId 0x7A

# システム再起動（必要に応じて）
Restart-Computer -Force
