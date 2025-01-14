terraform {
    backend "s3" {
        bucket = "tfstate"                  # Name of the S3 bucket
        endpoints = {
            s3 = "http://10.10.11.20:9000"   # Minio endpoint
        }
        key = "gitlab.tfstate"        # Name of the tfstate file

        # access_key="xxxxxxxxxxxx"           # Access and secret keys
        # secret_key="xxxxxxxxxxxxxxxxxxxxxx"

        region = "main"                     # Region validation will be skipped
        skip_credentials_validation = true  # Skip AWS related checks and validations
        skip_requesting_account_id = true
        skip_metadata_api_check = true
        skip_region_validation = true
        use_path_style = true             # Enable path-style S3 URLs (https://<HOST>/<BUCKET> https://developer.hashicorp.com/terraform/language/settings/backends/s3#use_path_style
    }


  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.5.2"
    }
  }
}