output "efs_file_system_id" {
  description = "The ID of the EFS file system."
  value       = aws_efs_file_system.app_efs.id
}
