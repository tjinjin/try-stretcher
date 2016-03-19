#!/bin/sh

terraform destroy -target=template_file.user_data -force
terraform destroy -target=aws_launch_configuration.green -force
terraform destroy -target=aws_launch_configuration.blue -force
