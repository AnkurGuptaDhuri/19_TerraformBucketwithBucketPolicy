terraform {
  //required_version = "~> 1.1.7"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 3.20.0"
      //version = "~> 3.7"
    }
  }
}    

provider "aws" {
  region = "eu-north-1"
  //shared_credentials_files = ["C:/users/097617744/.aws/credentials"]
  //profile = "default"
}