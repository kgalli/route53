# to shorten things a little bit
def r
  new_resource
end

def record
  Route53ARecord::Record.new(r.zone_id, r.name, r.value, r.ttl)
end

def handler
  Route53ARecord::Handler.new(r.aws_access_key_id, r.aws_secret_access_key, r.overwrite)
end

action :create do
  require 'route53_a_record'

  begin
    handler.create(record)
    Chef::Log.debug("Created record: #{record.inspect}")
  rescue AWS::Route53::Errors::InvalidChangeBatch => e
    Chef::Log.error e.to_s
  end
end

action :delete do
  require 'route53_a_record'

  begin
    handler.delete(record)
    Chef::Log.debug("Destroyed record: #{r.name}")
  rescue AWS::Route53::Errors::InvalidChangeBatch => e
    Chef::Log.error e.to_s
  end
end
