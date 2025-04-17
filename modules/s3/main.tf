resource "aws_s3_bucket" "static" {
  bucket = "3tier-static-bucket-${random_id.id.hex}"
  acl    = "public-read"

  website {
    index_document = "index.html"
  }

  tags = {
    Name = "StaticBucket"
  }
}

resource "random_id" "id" {
  byte_length = 4
}
