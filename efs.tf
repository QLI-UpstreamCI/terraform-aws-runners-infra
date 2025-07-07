### Commented out code as it blocks deployments other than Foundries

# resource "aws_security_group" "gh-runner-efs-sg" {
#   name = "${var.resource_name_prefix}-efs"
#   description = "Security group for EFS"
#   vpc_id = data.aws_vpc.vpc.id

#   ingress {
#     description = "Allow NFS within VPC"
#     from_port = 2049
#     to_port = 2049
#     protocol = "tcp"
#     cidr_blocks = [data.aws_vpc.vpc.cidr_block]
#   }

#   egress {
#     from_port = 0
#     to_port = 0
#     protocol = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   tags = var.tags
# }

# resource "aws_efs_file_system" "gh-runner-efs" {
#     creation_token = var.token_name
#   performance_mode = var.performance_mode
#   throughput_mode = var.throughput_mode
#   encrypted = true
#   #tags = var.tags
#   tags = {
#     Name = "qli-foundries-efs"
#   }
# }

# resource "aws_efs_mount_target" "gh-runner-efs-target" {
#   for_each = toset(data.aws_subnets.subnet.ids)
#   file_system_id = aws_efs_file_system.gh-runner-efs.id
#   subnet_id = each.value
#   security_groups = [aws_security_group.gh-runner-efs-sg.id]
# }

# resource "aws_efs_access_point" "gh-runner-efs-ap" {
#     file_system_id = aws_efs_file_system.gh-runner-efs.id

#     root_directory {
#         path = "/efs"
#         creation_info {
#           owner_gid   = 1001
#           owner_uid   = 1001
#           permissions = "755"
#         }
#       }
#     posix_user {
#       uid = 1000
#       gid = 1000
#     }
# }
