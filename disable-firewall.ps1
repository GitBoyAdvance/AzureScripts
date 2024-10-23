# ドメインプロファイルのファイアウォールを無効化
Set-NetFirewallProfile -Profile Domain -Enabled False

# プライベートプロファイルのファイアウォールを無効化
Set-NetFirewallProfile -Profile Private -Enabled False

# パブリックプロファイルのファイアウォールを無効化
Set-NetFirewallProfile -Profile Public -Enabled False

# すべてのプロファイルのファイアウォール状態を確認
Get-NetFirewallProfile | Format-Table Name, Enabled
