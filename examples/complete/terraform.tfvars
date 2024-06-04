archive_on_destroy = "false"

description = "This is a test repository"

environment = "sandbox"

label_order = ["namespace", "stage", "name", "environment"]

name = "repository"

namespace = "flufi"

required_deployment_environments = ["sandbox"]


stage = "module"

visibility             = "private"
status_checks_contexts = ["terratest"]
