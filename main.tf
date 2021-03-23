provider "aws" {
  region     = "us-west-2"
  access_key = "AKIAWLMDXOSGHL5AYCGN"
  secret_key = "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"
}


module  "Network_mod" {
    source = "./vpc"
    nat_id = module.webserver_mod.nat_output
}

module "security_mod"{
    source = "./sg"
    myvpc_id=module.Network_mod.vpc_info
    subnet_cidr_db = module.Network_mod.subnet_cidr
}

module "webserver_mod"{
    source = "./ec2"
    sg_pub= module.security_mod.sg_ouput_pub
    subnet_id_pub=module.Network_mod.subnet_pub_id_output
    # subnet_id_pub = module.Network_mod.subnet_pub_id_output
    
}

module "db_mod"{
    source = "./db"
    redshift_subnet_name=module.Network_mod.aws_redshift_subnet_group_name
    sg_pub = module.security_mod.sg_ouput_db
}












# module "vpc_mod"{
#     source = "./vpc"
    
# }

# module "igw_mod"{
#     source = "./igw"
#     myvpc_id=module.vpc_mod.vpc_info
# }

# module "rt_mod"{
#     source = "./routetable"
#     igw_id=module.igw_mod.igw_out
#     myvpc_id=module.vpc_mod.vpc_info
#     # nat_id = module.ec2_pub.nat_output
# }

# module "subnet_mod"{
#     source = "./subnet"
#     myvpc_id=module.vpc_mod.vpc_info
# }

# module "rt_associate_mod"{
#     source = "./routetable_association"
#     subnet_id_pub= module.subnet_mod.subnet_pub_id_output
#     rt_pub=module.rt_mod.pubroute_id
#     subnet_id_prv = module.subnet_mod.subnet_prv_id_output
#     rt_prv= module.rt_mod.prvroute_id
# }

# module "sg_pub"{
#     source = "./sg"
#     myvpc_id=module.vpc_mod.vpc_info
# }

# module "ec2_pub"{
#     source="./ec2"
#     subnet_id_pub=module.subnet_mod.subnet_pub_id_output
#     sg_pub=module.sg_pub.sg_ouput_pub
#     # eip_id= module.eip_mod.eip_output
    
# }
# module "redshift_subnet"{
#     source = "./subnet_group"
#     redshift_subnet_prv_id_value = module.subnet_mod.subnet_prv_id_output
# }

# module "redshift_name_mod"{
#     source = "./db"
#     redshift_subnet_name = module.redshift_subnet.aws_redshift_subnet_group_name
#     sg_pub = module.sg_pub.sg_ouput_pub
# }









# module "nat_mod"{
#     source = "./ec2"
#     subnet_nat = module.subnet_mod.subnet_pub_id_output

# }

# module "eip_mod"{
#     source = "./elastic_ip"
#     nat_id=module.ec2_pub.nat_output

# }