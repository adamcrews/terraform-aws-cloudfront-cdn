variable "namespace" {
  type        = string
  description = "Namespace (e.g. `eg` or `cp`)"
  default     = ""
}

variable "stage" {
  type        = string
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
  default     = ""
}

variable "environment" {
  type        = string
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
  default     = ""
}

variable "name" {
  type        = string
  description = "Name of the application"
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter between `namespace`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = list(string)
  description = "Additional attributes (_e.g._ \"1\")"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Additional tags (_e.g._ { BusinessUnit : ABC })"
  default     = {}
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources"
}

variable "dns_aliases_enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent dns records for aliases from being created"
}

variable "acm_certificate_arn" {
  type        = string
  default     = ""
  description = "Existing ACM Certificate ARN"
}

variable "aliases" {
  type        = list
  default     = []
  description = "List of aliases. CAUTION! Names MUSTN'T contain trailing `.`"
}

variable "custom_error_response" {
  type    = list
  default = []
  # http://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/custom-error-pages.html#custom-error-pages-procedure
  # https://www.terraform.io/docs/providers/aws/r/cloudfront_distribution.html#custom-error-response-arguments
  description = "(Optional) - List of one or more custom error response element maps"
}

variable "web_acl_id" {
  type        = string
  default     = ""
  description = "(Optional) - Web ACL ID that can be attached to the Cloudfront distribution"
}

variable "origin_domain_name" {
  type        = string
  default     = ""
  description = "(Required) - The DNS domain name of your custom origin (e.g. website)"
}

variable "origin_path" {
  type        = string
  default     = ""
  description = "(Optional) - An optional element that causes CloudFront to request your content from a directory in your Amazon S3 bucket or your custom origin"
}

variable "origin_http_port" {
  type        = number
  default     = 80
  description = "(Required) - The HTTP port the custom origin listens on"
}

variable "origin_https_port" {
  type        = number
  default     = 443
  description = "(Required) - The HTTPS port the custom origin listens on"
}

variable "origin_protocol_policy" {
  type        = string
  default     = "match-viewer"
  description = "(Required) - The origin protocol policy to apply to your origin. One of http-only, https-only, or match-viewer"
}

variable "origin_ssl_protocols" {
  type        = list(string)
  default     = ["TLSv1", "TLSv1.1", "TLSv1.2"]
  description = "(Required) - The SSL/TLS protocols that you want CloudFront to use when communicating with your origin over HTTPS"
}

variable "origin_keepalive_timeout" {
  type        = number
  default     = 60
  description = "(Optional) The Custom KeepAlive timeout, in seconds. By default, AWS enforces a limit of 60. But you can request an increase."
}

variable "origin_read_timeout" {
  type        = number
  default     = 60
  description = "(Optional) The Custom Read timeout, in seconds. By default, AWS enforces a limit of 60. But you can request an increase."
}

variable "compress" {
  type        = bool
  default     = false
  description = "(Optional) Whether you want CloudFront to automatically compress content for web requests that include Accept-Encoding: gzip in the request header (default: false)"
}

variable "is_ipv6_enabled" {
  type        = bool
  default     = true
  description = "State of CloudFront IPv6"
}

variable "default_root_object" {
  type        = string
  default     = "index.html"
  description = "Object that CloudFront return when requests the root URL"
}

variable "comment" {
  type        = string
  default     = "Managed by Terraform"
  description = "Comment for the origin access identity"
}

variable "log_include_cookies" {
  type        = bool
  default     = false
  description = "Include cookies in access logs"
}

variable "log_standard_transition_days" {
  type        = number
  default     = 30
  description = "Number of days to persist in the standard storage tier before moving to the glacier tier"
}

variable "log_glacier_transition_days" {
  type        = number
  default     = 60
  description = "Number of days after which to move the data to the glacier storage tier"
}

variable "log_expiration_days" {
  type        = number
  default     = 90
  description = "Number of days after which to expunge the objects"
}

variable "forward_query_string" {
  type        = bool
  default     = false
  description = "Forward query strings to the origin that is associated with this cache behavior"
}

variable "forward_headers" {
  type        = list(string)
  default     = []
  description = "Specifies the Headers, if any, that you want CloudFront to vary upon for this cache behavior. Specify `*` to include all headers."
}

variable "forward_cookies" {
  type        = string
  default     = "none"
  description = "Specifies whether you want CloudFront to forward cookies to the origin. Valid options are all, none or whitelist"
}

variable "forward_cookies_whitelisted_names" {
  type        = list(string)
  default     = []
  description = "List of forwarded cookie names"
}

variable "price_class" {
  type        = string
  default     = "PriceClass_100"
  description = "Price class for this distribution: `PriceClass_All`, `PriceClass_200`, `PriceClass_100`"
}

variable "viewer_minimum_protocol_version" {
  type        = string
  default     = "TLSv1"
  description = "(Optional) The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections."
}

variable "viewer_protocol_policy" {
  type        = string
  default     = "redirect-to-https"
  description = "allow-all, redirect-to-https"
}

variable "allowed_methods" {
  type        = list(string)
  default     = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
  description = "List of allowed methods (e.g. ` GET, PUT, POST, DELETE, HEAD`) for AWS CloudFront"
}

variable "cached_methods" {
  type        = list(string)
  default     = ["GET", "HEAD"]
  description = "List of cached methods (e.g. ` GET, PUT, POST, DELETE, HEAD`)"
}

variable "default_ttl" {
  type        = number
  default     = 60
  description = "Default amount of time (in seconds) that an object is in a CloudFront cache"
}

variable "min_ttl" {
  type        = number
  default     = 0
  description = "Minimum amount of time that you want objects to stay in CloudFront caches"
}

variable "max_ttl" {
  type        = number
  default     = 31536000
  description = "Maximum amount of time (in seconds) that an object is in a CloudFront cache"
}

variable "geo_restriction_type" {
  type        = string
  default     = "none"
  description = "Method that use to restrict distribution of your content by country: `none`, `whitelist`, or `blacklist`"
}

variable "geo_restriction_locations" {
  type = list(string)

  # e.g. ["US", "CA", "GB", "DE"]
  default     = []
  description = "List of country codes for which  CloudFront either to distribute content (whitelist) or not distribute your content (blacklist)"
}

variable "parent_zone_id" {
  type        = string
  default     = ""
  description = " ID of the hosted zone to contain this record  (or specify `parent_zone_name`)"
}

variable "parent_zone_name" {
  type        = string
  default     = ""
  description = "Name of the hosted zone to contain this record (or specify `parent_zone_id`)"
}

variable "cache_behavior" {
  type        = list
  default     = []
  description = "An ordered list of cache behaviors resource for this distribution. List from top to bottom in order of precedence. The topmost cache behavior will have precedence 0."
}

variable "log_prefix" {
  type        = string
  default     = ""
  description = "Path of logs in S3 bucket"
}
