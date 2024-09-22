# Flutter/Android 開発環境構築(Windows用)

## 前準備

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

