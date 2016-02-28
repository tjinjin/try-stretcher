#!/bin/sh

terraform destroy -target=template_file.user_data -force

terraform destroy -force
