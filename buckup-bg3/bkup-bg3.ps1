# 正しいDocumentsフォルダーのパスを取得
$documentsPath = [Environment]::GetFolderPath('MyDocuments')

# セーブデータのディレクトリパス
$sourcePath = "$env:LOCALAPPDATA\Larian Studios\Baldur's Gate 3\PlayerProfiles\Public\Savegames\Story"

# バックアップの保存先ディレクトリパス
$backupPath = Join-Path -Path $documentsPath -ChildPath "Baldur's Gate 3 Backups"

# 最新のサブフォルダーを取得
$latestFolder = Get-ChildItem -Path $sourcePath | Sort-Object LastWriteTime -Descending | Select-Object -First 1

# バックアップ先フォルダーが存在しない場合、作成する
if (-not (Test-Path -Path $backupPath)) {
    New-Item -ItemType Directory -Path $backupPath
}

# 新しいバックアップフォルダー名を生成
$timestamp = Get-Date -Format "yyyyMMddHHmm"
$backupFolderName = "$($latestFolder.Name)-$timestamp.bk"
$destinationFolder = Join-Path -Path $backupPath -ChildPath $backupFolderName

# 最新フォルダーをバックアップフォルダーへコピー
Copy-Item -Path $latestFolder.FullName -Destination $destinationFolder -Recurse

Write-Output "Latest save folder '$($latestFolder.Name)' has been backed up to '$destinationFolder'."
