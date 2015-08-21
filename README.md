# Description

Creates, updates or deletes Amazon Web Serivice's Route 53 A records.

# Requirements

An Amazon Web Services account and a Route 53 zone.

# Usage

```ruby
include_recipe 'route53'

route53_record "create a record" do
  name  <your value>
  value <your value>
  ttl   <your value defaults to 3600>
  zone_id               <your value or stack settings like: node[:aws_zone_id]>
  aws_access_key_id     <your value or stack settings like: node[:aws_access_key]>
  aws_secret_access_key <your value or stack settings like: node[:aws_secret_key]>
  overwrite <true or false defaults to true>
  action :create
end
```

Replace `action :create` with `action :delete` to delete the A entry.
__BE AWARE__ that `name`, `value` __and__ `ttl` must be the same as the existing
record. Otherwise it will not be deleted.

## OpsWorks Example

To update ec2 instance IP use the following example recipe.

```ruby
include_recipe 'route53'

instance_name = node[:opsworks][:instance][:hostname]
stack_name    = node[:opsworks][:stack][:name]
instance_name = node[:opsworks][:instance][:hostname]
public_ip     = node[:opsworks][:instance][:ip]
domain        = node[:aws_domain]

route53_record "create a record" do
  name  [instance_name, stack_name, domain].join('.')
  value public_ip
  ttl   300
  zone_id               node[:dns_zone_id]
  aws_access_key_id     node[:custom_access_key]
  aws_secret_access_key node[:custom_secret_key]
  overwrite true
  action :create
end
```

The following json demonstrates the Stack settings used to
complete the recipe above.

```json
{
  "aws_zone_id"   : "Z7DWKL9EXAMPLE",
  "aws_access_key": "AKSOEJWJS6KYWEXAMPLE",
  "aws_secret_key": "AKRT3wgZz36EfZsaU1T7M3fsTT143nClvEXAMPLE",
  "aws_domain"    : "example.com"
}
```

# Areas to improve

* This LWRP is missing tests and therefore ist not ready
  for production yet.
* The management of aws credentials could be better. Maybe by the
  support of environment variables or a config file. The changes should
  probably be implemented by the `route53_a_record` gem.
* The LWRP supports only A records. It should be not so hard to
  implement the missing features in the `route53_a_record` gem and
  update this LWRP accordingly.

