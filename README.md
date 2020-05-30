# 定期通知bot

ゴミ収集の日とかに合わせて、Slackメッセージを送るだけのプログラム。

大半はTerraformで作られてます。


# 使い方

前提：GCPめっちゃ使います。

## 必要な機能をインストール

まず、terraformをインストールしましょう。

```
brew install terraform
```

でできます。次にGCPのプロジェクトを用意しましょう。

## GCPプロジェクトを用意する。

具体的なやり方は忘れたんですが、GCPプロジェクトを作ってください。  
簡単にできます。できなかったら諦めてください。

## Terraform用SAを作成する

SA（サービスアカウント）を作成して、`/var/credential/terraform-general-credential.json`にキーを保存しましょう。

[サービス アカウントの作成と管理](https://cloud.google.com/iam/docs/creating-managing-service-accounts?hl=ja)とか参考に作成するといいと思います。

作る内容的に、以下の権限でロール発行するといいです。
* Cloud Functions 管理者
* Cloud Scheduler 管理者
* Pub/Sub 管理者
* ストレージ 管理者

こうすると最悪Credentialが漏れても死ぬことはないので、大丈夫。

あとは、鍵をJsonで生成して、`/var/credential/terraform-general-credential.json`に保存すればOKです。(場所は秘匿性が保たれるならぶっちゃけどこでもいいです。)

## Slackbotを作成する

SlackBotを作成します。

[slackAPP](https://api.slack.com/apps)から、`Create New App`をクリックして、作成しましょう

あとは、以下の設定をします
* Incoming Webhook(これをONにする)
* Bots(App Display Nameを入れる。これがないと怒られる)
* Permission(ScopsのBot Token Scopesにchat:writeを追加)

これで、Install Appに行って、設定したいWorkSpaceに設定しに行きます。

設定し終わったら、WebhookURLをコピーする。

## Webhookをsecret.tfにコピペする

webhookURLを含むsecret.tfは秘匿情報なので、`.gitignore`に設定しています。  
なので、secret-templates.tfのタイトルと変数名から、templatesを抜き去って、  
ちょうどよくなるようにvariableを設定してください。  
(main.tfのresource "google_cloudfunctions_function" "slack_function"部分でsecret.tfのvariableを設定しているので、それを参考に設定してください。)

で、url=webhookURLになる様にWebhookURLを設定してください。

## slack_functionのSAを設定

main.tfのresource "google_cloudfunctions_function" "slack_function"について、サービスアカウントを別途作って設定しています。

特に権限まわりいらないなら、ここの項目を無しで作ってもいいと思います。

## terraform init

terraform initする前に、terraformのtfstateを記録する場所を決めてあげてください。backend.tfに設定が書いてあります。`terraform-backend123`は作者の作ったGCSバケットなので、個人で別に作って、その名前で設定してあげてください。

バケットの設定ができたら、

```
terraform init
```

としてください。エラーが出る様なら、何かおかしいはず。エラーを読んで対処してください。(ちなみに、最初におかしくなって、何度直しても悪い場合は`-reconfigure`オプションを入れてあげてください。)

## terraform apply

準備ができたら、

```
terraform apply
```
をしてあげましょう。(ここでエラーが出た場合は、SyntaxErrorなので、修正してください)

追加する項目を決めたら、`yes`と入力して、反映を待ちましょう。


# Q＆A

## 内容を変更したい

もちろん、これは品川区のゴミ捨てにちなんで作ってるので、変更したいとかあると思います。

その時は、scheduler.tfをいい感じに変更して、メッセージを変えたり、追加したりしてください。

## scheduleの0 21 * * 1 って何

crontabの書き方でググれば出てきます。  
簡単に言うと、

* 分　時　日　月　曜日って書き方
* 0 21 * * 1は月曜21:00にやるってスケジューリング
* 詳細は[ここ](https://www.server-memo.net/tips/crontab.html)

## ＄MEMBERがなんちゃらって403エラーでむり

これねー、多分iam関係の権限が足りないので、エラーメッセージ通りに対処してあげてください。 $MEMBERはterraformのSAのことを指してます。 置き換えてgcloudコマンドで入れてあげてください。 Gcloudコマンドのインストールは[ここ](https://cloud.google.com/sdk/docs/downloads-interactive?hl=ja)

## その他

何かあればissueに投げてください。

# LICENSE,著作権,保証などについて

著作権については自分(著作者)に帰属しますが、MITライセンスの様に思っていてください。
個人商用、問わず使用可能で再配布も可。Fork元の名前も書かなくていいです。
しかし、これを実行したことによる責任(GCPの課金など)については著作者は負いません。
保証する義務もありません。
あとでMITLicenceを入れますが、今は酔っ払いながら書いてるので、取り急ぎこれがLICENSEとご認識ください。