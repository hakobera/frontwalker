# Frontwalker

Frontwalker is a tool to manage CloudFront distributions.

It defines the state of CloudFront using DSL, and updates CloudFront according to the DSL.

[![Build Status](https://travis-ci.org/hakobera/frontwalker.svg?branch=master)](https://travis-ci.org/hakobera/frontwalker)

### Notice

- Frontwalker is identify distributions by special comments. So do not edit comment manual on AWS Management Console or AWS API.
- Currently not supported `Restrictions` and `active_trusted_signers` feature.

## Installation

Add this line to your application's Gemfile:

```
gem "frontwalker"
```

Or install it yourself as:

```sh
$ gem install frontwalker
```

## Usage

```sh
# Set AWS credentials
export AWS_ACCESS_KEY_ID='...'
export AWS_SECRET_ACCESS_KEY='...'

# Export current distibutions to Frontfile
frontwork --export --out Frontfile

# Dry run
frontwork --apply --dry-run

# Apply
frontwork --apply
```

## Help

```
Usage: frontwork [options]
    -a, --apply
    -f, --file FILE
        --dry-run
        --force
    -e, --export
    -o, --output FILE
        --split
    -t, --test
        --nameservers SERVERS
        --no-color
        --debug
```

## Frontfile example

```rb
require 'other/frontfile'

distribution "www.example.com" do
  id "ABC123456789" # This ID is important to manage existing distibution. 
  price_class "PriceClass_All" # or PriceClass_200 or PriceClass_100
  enabled true

  aliases(
    "static-files-1.example.com",
    "static-files-2.example.com"    
  )

  origins do
    origin do
      id "Custom-Origin"
      domain_name "xyz.example.com"
      type :custom
      config({
        http_port: 80,
        https_port: 443,
        origin_protocol_policy: "match-viewer"
      })
    end

    origin do
      id "S3-Origin"
      domain_name "xyz.s3.amazonaws.com"
      type :s3
      config({
        origin_access_identity: "access-identity-xyz.s3.amazonaws.com"
      })
    end
  end

  cache_behaviors do
    cache_behavior "/test" do
      target_origin_id "Custom-Origin"
      forwarded_values do
        query_string false,
        cookies do
          forward "none"
        end
        headers do
          xxx
        end
      end
      trusted_signers do
        xxxx
      end
      viewer_protocol_policy "allow-all"
      min_ttl 0
      allowed_methods("GET", "HEAD")
      smooth_streaming false
    end

    # :default is special cache behavior. it is catch all.
    cache_behavior :default do
      target_origin_id "S3-Origin"
    end
  end

  error_responses do
    error "403" do
      error_caching_min_ttl 300
      response_page_path "/404.html"
      response_code "404"
    end
  end
end
```
