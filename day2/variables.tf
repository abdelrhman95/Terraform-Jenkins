# All variables

variable "cidr" {                   #VPC CIDR BLOCK
    type = string
    description = "cidr block of vpc"
}

variable "public_1_CIDR" {          #First public subnet CIDR
    type = string
}

variable "public_2_CIDR" {          #Second public subnet CIDR
    type = string
}

variable "private_1_CIDR" {         #First private subnet CIDR
    type = string
}

variable "private_2_CIDR" {         #Second private subent CIDR
    type = string
}

variable "region" {          
    type = string
}

variable ami_id {                  #Amazon Machine Image
    type = string
}