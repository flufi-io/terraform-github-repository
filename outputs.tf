output "repository_name" {
  description = "The name of the repository"
  value       = github_repository.this.name
}

output "repository_url" {
  value       = github_repository.this.html_url
  description = "The URL of the repository"
}
