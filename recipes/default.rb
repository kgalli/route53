chef_gem "route53_a_record" do
    action :install
    version node['route53']['route53_a_record_version']
end

require 'rubygems'
Gem.clear_paths

