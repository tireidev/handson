#----------------------------------------
# プロバイダ情報
#----------------------------------------
provider "aws" {
  region = "ap-northeast-1"
}

#----------------------------------------
# S3バケット作成
#----------------------------------------
resource "aws_s3_bucket" "b" {
  # バケット名は独自ドメイン名と同じにする必要がございます。
  bucket = "ここにバケット名を記載すること 例) my_bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

#----------------------------------------
# バケットACL作成
#----------------------------------------
resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.b.id
  acl    = "private"
}

#----------------------------------------
# バケットオブジェクト作成
#----------------------------------------
resource "aws_s3_object" "object" {
  # resource "aws_s3_bucket" "b" で指定したバケット名を記載します。
  bucket = "ここにバケット名を記載すること 例) my_bucket"

  # オブジェクト名を記載します。ホスティングするためindex.htmlと記載しております。
  key    = "index.html"

  # オブジェクトのソース元を記載します。ファイルパスは任意で設定下さい。
  source = "C:/test/index.html"

  # バケット名の設定後にオブジェクト作成が行われるようにします。
  depends_on = [aws_s3_bucket.b]

  # ホスティングするため、Content-Typeを「text/html」にしております。こちらを変更しないとホスティングに失敗します。
  content_type = "text/html" 
}