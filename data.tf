#data "github_repository" "template" {
#  count = var.template_repository != null ? 1 : 0
#  name  = var.template_repository.name
#}
#data "github_repository_file" "template" {
#  count = local.template_files_all ? length(local.template_files_list) : length(var.template_files)
#  file       = element(keys(data.external.get_files_recursive.result), count.index)
#  repository = var.template_repository
#}


#data "external" "get_files_recursive" {
#  program = ["bash", "-c", <<EOT
#TOKEN=$GITHUB_TOKEN
#
#get_files() {
#  local path=$1
#  curl -s -H "Authorization: token $TOKEN" \
#       "https://api.github.com/repos/${var.template_repository}/contents/$path" | \
#  jq -r '.[] | select(.type=="file") | .path'
#}
#
#get_dirs() {
#  local path=$1
#  curl -s -H "Authorization: token $TOKEN" \
#       "https://api.github.com/repos/${var.template_repository}/contents/$path" | \
#  jq -r '.[] | select(.type=="dir") | .path'
#}
#
#list_files_recursive() {
#  local path=$1
#  local json_output=""
#  for file in $(get_files $path); do
#    json_output="$json_output\"$file\": \"\","
#  done
#  for dir in $(get_dirs $path); do
#    json_output="$json_output$(list_files_recursive $dir)"
#  done
#  echo "$json_output"
#}
#
#echo -n "{"
#json_output=$(list_files_recursive "")
#echo -n "$${json_output::-1}" # Remove trailing comma
#echo -n "}"
#
#EOT
#  ]
#}
#
#output "files_list" {
#  value = data.external.get_files_recursive.result
#}
