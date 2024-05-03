ServiceLogosCLIForMacOS
===

macOS 用の [SAWARATSUKI/Logos](https://github.com/SAWARATSUKI/Logos) の画像をクリップボードにコピーするコマンドラインツール

Install
---

以下のどれかの方法でインストールでき(ると思い)ます。

- このレポジトリーの [Release](https://github.com/mike-neck/ServiceLogosCLIForMacOS/releases) からダウンロードする
- このレポジトリーのソースコードをクローンまたはダウンロードしてビルドする

`Homebrew` ですか？…ちょっと調べてみます。

Usage
---

コマンド名は `service-logos` です。このコマンドには次の二つのサブコマンドがあります。

- List: 画像の名前の一覧を表示します。
- Copy: 画像をクリップボードにコピーします。

### List

[SAWARATSUKI/Logos](https://github.com/SAWARATSUKI/Logos) の画像の一覧を表示します。
実行するときは `list` を指定します。

```shell
service-logos list
```

このコマンドには次のオプションが存在します。

| オプション            | 型               | 必須 | 内容                                                           |
|------------------|-----------------|----|--------------------------------------------------------------|
| `-h`, `--help`   | `Bool`          | -  | このサブコマンドのヘルプを表示します。                                          |
| `-s`, `--show`   | `Array[String]` | -  | 表示する項目を指定します。デフォルトは `path,size,browser-url` です。              |

#### 表示可能な項目

GitHub の API で利用できる項目、および計算できる項目が表示可能です。

- `path`
- `mode`
- `type`
- `size`
- `sha`
- `browser-url`
- `api-url`

### Copy

[SAWARATSUKI/Logos](https://github.com/SAWARATSUKI/Logos) から指定した `path` の画像をクリップボードにコピーします。

実行するときは `path` を指定します。

```shell
service-logos copy Languages/Swift/Swift.jpeg
```

これで、クリップボードに `Languages/Swift/Swift.jpeg` の画像がコピーされます。

Build
---

ソースをダウンロードして次のコマンドを実行すると、 `build/release` ディレクトリーの下に `service-logos` という実行形式のファイルができます。
そのファイルをパスの通っているところに配置すると使えるようになります。

```shell
TAG_NAME="$(git describe --abbrev=0 --tags 2>/dev/null || echo "v0.0.0")" make build
```

Test
---

テストを実行する場合は、以下のコマンドを実行してください。

```shell
make test
```

テストを実行したときに次のようなコンパイルエラーが発生する場合があります。

```text
/path/to/ServiceLogosCLIForMacOS/Tests/AppConfigTest.swift:6:21: error: cannot find 'AppConfig' in scope
    let appConfig = AppConfig.main
                    ^~~~~~~~~
/path/to/ServiceLogosCLIForMacOS/Tests/AppConfigTest.swift:11:21: error: cannot find 'AppConfig' in scope
    let appConfig = AppConfig.main
                    ^~~~~~~~~
```

この場合は、 `AppConfig` という構造体が生成できていないので、以下のように仮のバージョン番号を与えることでコンパイルが通るようになります。

```shell
TAG_NAME="v0.0.0" make build
```



