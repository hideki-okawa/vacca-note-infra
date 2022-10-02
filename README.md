# vacca-note-infra
「ワクチン接種体験共有サービス Vacca note」 のTerraform

## プロジェクト概要
[Vacca note ーコロナワクチン接種体験共有サービスー](https://hideki-okawa.notion.site/Vacca-note-e390c4ad207d44209535d5a94b18d2cd)

## 使用技術

- Terraform 1.1.9

## 反映手順
### 差分確認

```
$ terraform plan
```

### 反映

```
$ terraform apply
```

### リソース削除

```
$ terraform destroy
```

## Tips
### コンポーネント追加時に実施すること

```
$ ln -fs ../../provider.tf 
$ ln -fs ../../shared_locals.tf
$ terraform init
```

### NATゲートウェイとEIPを複数作成する
デフォルトではコスト削減のためNATゲートウェイとEIPの数を1つに制限している。
各アベイラビリティゾーンごとに作成したい場合は、以下のコマンドを入力する。

```
terraform-fargate-template/network/main $ terraform apply -var='single_nat_gateway=false'
```
