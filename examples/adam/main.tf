locals {
  wp_nocache_behavior = {
    viewer_protocol_policy = "redirect-to-https"
    cached_methods         = ["GET", "HEAD"]
    allowed_methods        = ["HEAD", "DELETE", "POST", "GET", "OPTIONS", "PUT", "PATCH"]
    default_ttl            = 60
    min_ttl                = 0
    max_ttl                = 86400
    compress               = "true"
    target_origin_id       = "tg-shroom-test"

    forwarded_values = [{
      headers      = ["*"]
      query_string = "true"

      cookies = [{
        forward = "all"
      }]
    }]
  }
}

module "cdn" {
  source     = "../../"
  namespace  = "sh"
  stage      = "test"
  name       = "cf"
  attributes = ["shroomnet"]

  aliases                           = ["foo.shroom.net", "bar.shroom.net"]
  origin_domain_name                = "origin.shroom.net"
  origin_protocol_policy            = "match-viewer"
  viewer_protocol_policy            = "redirect-to-https"
  parent_zone_name                  = "shroom.net"
  default_root_object               = "index.html"
  acm_certificate_arn               = "arn:aws:acm:us-east-1:087738231127:certificate/f5c9d06a-ae9e-44ff-aa83-35d01c53f1b9"
  forward_cookies                   = "whitelist"
  forward_cookies_whitelisted_names = ["comment_author_*", "comment_author_email_*", "comment_author_url_*", "wordpress_logged_in_*", "wordpress_test_cookie", "wp-settings-*"]
  forward_headers                   = ["Host", "Origin", "Access-Control-Request-Headers", "Access-Control-Request-Method"]
  forward_query_string              = "true"
  default_ttl                       = 60
  min_ttl                           = 0
  max_ttl                           = 86400
  compress                          = "true"
  cached_methods                    = ["GET", "HEAD"]
  allowed_methods                   = ["GET", "HEAD", "OPTIONS"]
  price_class                       = "PriceClass_All"

  cache_behavior = [
    "${merge(local.wp_nocache_behavior, map("path_pattern", "wp-admin/*"))}",
    "${merge(local.wp_nocache_behavior, map("path_pattern", "wp-login.php"))}",
    "${merge(local.wp_nocache_behavior, map("path_pattern", "wp-signup.php"))}",
    "${merge(local.wp_nocache_behavior, map("path_pattern", "wp-trackback.php"))}",
    "${merge(local.wp_nocache_behavior, map("path_pattern", "wp-cron.php"))}",
    "${merge(local.wp_nocache_behavior, map("path_pattern", "xmlrpc.php"))}",
  ]
}
