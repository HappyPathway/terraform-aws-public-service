variable "service_name" {
  description = "Name of Service"
  type        = "string"
}

variable "service_version" {
  description = "Version of deployed service"
  type        = "string"
}

variable "env" {
  type        = "string"
  description = "Generally a team will have multiple environments for developing their service, appropriate names could be dev, staging, or production"
}

variable "service_ports" {
  type        = "list"
  description = "Which port does this service run on?"
  default     = 80
}

variable "service_healthcheck" {
  type        = "string"
  description = "What is the Healthcheck URL?"
}

variable "service_access" {
  type        = "string"
  default     = "0.0.0.0/0"
  description = "CIDR mask of whitelisted hosts for service access"
}

variable "instance_type" {
  type        = "string"
  description = "Instance Type for Service Nodes"
}

variable "key_name" {
  type        = "string"
  description = "KeyPair name"
}

variable "min_size" {
  type        = "string"
  description = "Minimum size of cluster"
  default     = 1
}

variable "max_size" {
  type        = "string"
  description = "Maximum size of cluster"
  default     = 3
}

variable "high_cpu" {
  type        = "string"
  description = "Threshold for CPU to trigger Scale up"
  default     = 85
}

variable "low_cpu" {
  type        = "string"
  description = "Threshold for CPU to trigger Scale down"
  default     = 35
}

variable "cloudwatch_metric_interval" {
  type        = "string"
  description = "How often should CloudWatch collect Metrics?"
  default     = 120
}

variable "cloudwatch_evaluation_periods" {
  default     = 2
  description = "How many evaluation periods should fail before an alarm is triggered?"
  type        = "string"
}

variable "default_cooldown" {
  description = "How much time should we allow after scale up activity for CPU to return to normal load"
  default     = 600
  type        = "string"
}

variable "private_subnet_id" {
  type        = "string"
  description = "Private Subnet ID of Target Network as assigned by AWS"
}

variable "public_subnet_id" {
  type        = "string"
  description = "Public Subnet ID of Target Network as assigned by AWS"
}

variable "vpc_id" {
  type        = "string"
  description = "VPC IR of Target Network as assigned by AWS"
}

variable "service_healthcheck_healthy_threshold" {
  default     = 2
  description = "How many successful healthcheck attempts must be made before being considered healthy"
  type        = "string"
}

variable "service_healthcheck_unhealthy_threshold" {
  default     = 3
  description = "How many successful healthcheck attempts must be made before being considered unhealthy"
  type        = "string"
}

variable "service_healthcheck_timeout" {
  default     = 3
  description = "how long should a normal healcheck probe take"
  type        = "string"
}

variable "service_healthcheck_interval" {
  default     = 30
  description = "How often should a healthcheck probe be made."
  type        = "string"
}

variable "instance_protocol" {
  default     = "http"
  description = "Instance Protocol. Either http or https"
  type        = "string"
}

variable "cross_zone_load_balancing" {
  default     = true
  description = "Should we enable cross zone load balancing on this elb?"
}

variable "connection_draining_timeout" {
  default     = 400
  description = "how long should we give the elb to drain connections?"
}

variable "connection_draining" {
  default     = true
  description = "show we enable connection draining?"
}

variable "idle_timeout" {
  default = 400
}
