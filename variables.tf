variable "environment" {
  default = {
    "default" = {
      profile          = "default"
      region           = "ap-south-1"
      credentials_file = "C:\\Users\\manju\\.aws\\credentials"
    }

    "dev" = {
      profile          = "dev"
      region           = "ap-south-1"
      credentials_file = "C:\\Users\\manju\\.aws\\credentials"
    }

    "prod" = {
      profile          = "prod"
      region           = "ap-south-1"
      credentials_file = "C:\\Users\\manju\\.aws\\credentials"
    }
  }
}

variable "ami" {
  default = {
    "us-east-1" = {
      "x86" = {
        id = "ami-042e8287309f5df03"
      }
      "arm" = {
        id = "ami-0b75998a97c952252"
      }
    }
    "us-east-2" = {
      "x86" = {
        id = "ami-08962a4068733a2b6"
      }
      "arm" = {
        id = "ami-064446ad1d755489e"
      }
    }
    "us-west-1" = {
      "x86" = {
        id = "ami-031b673f443c2172c"
      }
      "arm" = {
        id = "ami-07711e34185f62b48"
      }
    }
    "us-west-2" = {
      "x86" = {
        id = "ami-0ca5c3bd5a268e7db"
      }
      "arm" = {
        id = "ami-0ae8c80279572fa66"
      }
    }
    "ap-south-1" = {
      "x86" = {
        id = "ami-0d758c1134823146a"
      }
      "arm" = {
        id = "ami-0a6638920f7143fb2"
      }
    }
    "ap-northeast-3" = {
      "x86" = {
        id = "ami-01ecbd21b1e9b987f"
      }
      "arm" = {
        id = "ami-0b75998a97c952252"
      }
    }
  }
}

variable "public-ip" {
  default = ""
}
