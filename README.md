# Flutter/Android 開発環境構築(Windows用)

## 前準備

WSL の Ubuntu-24.04 をインストール
```
wsl --install Ubuntu-24.04
```

docker の設定を開いて、Resources > WSL integration で Ubuntu-24.04 の WSL integration を有効化


VCXSRC インストール
```cmd
winget install marha.VcXsrv
```

src フォルダを作成
```cmd
mkdir .\src
```


## Build 
```
docker compose build
```

## サービス開始 
```
docker compose up -d
```

## shell 起動 
```
docker compose exec flutter-env /bin/bash
```

## Emulator 起動 

XLaunch を起動しておくこと！

```
~/run_emulator.sh
```

## デモのビルド＆起動
```
cd src
flutter create .
flutter run
```

