resource "aws_redshift_cluster" "default" {
  cluster_identifier = "testingdev"
  database_name      = "testingdb"
  master_username    = "user1"
  master_password    = "Awsuser12345"
  node_type          = "dc2.large"
  cluster_type       = "single-node"
  cluster_subnet_group_name = var.redshift_subnet_name
  skip_final_snapshot = true
  port = 5439
  vpc_security_group_ids = [var.sg_pub]
  publicly_accessible = false
  # iam_roles = [aws_iam_role.redshift_role.arn]

  # depends_on = [
  #   module.vpc_mod, #aws_vpc.redshift_vpc,
  #   module.sg_pub #aws_default_security_group.redshift_security_group,
  #   #aws_redshift_subnet_group.redshift_subnet_group,
	# # aws_iam_role.redshift_role
    
  # ]
}

variable "redshift_subnet_name" {

}
variable "sg_pub"{
}