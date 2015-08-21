actions :create, :delete

default_action :create

attribute :name,                  :kind_of => String, :required => true, :name_attribute => true
attribute :value,                 :kind_of => String, :required => true
attribute :ttl,                   :kind_of => Integer, :default => 3600
attribute :zone_id,               :kind_of => String, :required => true
attribute :aws_access_key_id,     :kind_of => String, :required => true
attribute :aws_secret_access_key, :kind_of => String, :required => true
attribute :overwrite,             :kind_of => [ TrueClass, FalseClass ], :default => true
