# dhi-migration

Docker Hardened Images (DHI) への移行を、言語別の **before / after** Dockerfile で実例比較するサンプル集です。Zenn 記事の検証用リポジトリとして利用しています。

## 構成

| 言語 | ベース (before) | DHI (after) | サンプルアプリ |
| --- | --- | --- | --- |
| Go 1.25 | `golang:1.25` | `dhi.io/golang:1.25` | `cmd/server` HTTP `/health` |
| Node.js 24 | `node:24-alpine` | `dhi.io/node:24-alpine3.21` | esbuild バンドル + `/health` |
| Python 3.11 | `python:3.11-slim` | `dhi.io/python:3.11-debian12` | venv + `/health` |
| Rails 8 (Ruby 3.4) | `ruby:3.4-slim` | `dhi.io/ruby:3.4-debian12` | API only Rails + Puma `/health` |

各言語ディレクトリは `before/` と `after/` の 2 つの Dockerfile を持ち、同じアプリで「移行前」と「DHI 移行後」のイメージを並べて比較できます。

## 動作確認

例: Rails 8 サンプル

```bash
# before
docker build -t dhi-rails-before rails/before
docker run --rm -p 8080:8080 dhi-rails-before
curl -s localhost:8080/health
# {"status":"ok","service":"dhi-rails-sample","ruby":"3.4.9","rails":"8.1.3"}

# after (DHI)
docker build -t dhi-rails-after rails/after
docker run --rm -p 8081:8080 dhi-rails-after
curl -s localhost:8081/health
# {"status":"ok","service":"dhi-rails-sample","ruby":"3.4.5","rails":"8.1.3"}
```

他言語も `<lang>/before` / `<lang>/after` を `docker build` するだけで同様に確認できます。

## DHI 適用ポイント

- **builder + runtime の 2 stage** に分離し、ビルド用 `*-dev` イメージとランタイム用 distroless イメージを使い分け
- ランタイムは **`USER nonroot`** で起動
- distroless ランタイムには **シェルが無い** ため、エントリポイントは exec 形式 (`CMD ["..."]`) で指定
- Rails / Python のように **ネイティブの tzdata に依存する処理** は、`tzinfo-data` などのアプリ側パッケージで補う

## セキュリティ

- `pre-commit` で **gitleaks** を実行（コミット前にシークレット検出）
- GitHub Actions でも同じ **gitleaks** をワークフロー実行（push / PR）
- `.gitignore` は Go / Node / Python / Rails / Docker / 一般的な秘密情報パターンを網羅

### pre-commit 導入

```bash
pre-commit install
pre-commit run --all-files
```

## ライセンス

Sample / verification コードのため、特に明示的なライセンスは付与していません。
