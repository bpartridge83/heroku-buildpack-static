# ghetto require, since mruby doesn't have require
eval(File.read('/app/bin/config/lib/nginx_config_util.rb'))

USER_CONFIG = "/app/static.json"

config = {}
config = JSON.parse(File.read(USER_CONFIG)) if File.exist?(USER_CONFIG)
req    = Nginx::Request.new
uri    = req.var.uri

r = Nginx::Request.new
nonce = r.var.nonce
nonceKey = r.var.nonceKey

if config["headers"]
  config["headers"].to_a.reverse.each do |route, header_hash|
    if Regexp.compile("^#{NginxConfigUtil.to_regex(route)}$") =~ uri
      header_hash.each do |key, value|
        # value must be a string
        req.headers_out[key] = value.to_s.gsub(nonceKey, nonce)
      end
      break
    end
  end
end

req.headers_out[nonceKey] = nonce
