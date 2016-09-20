require 'redis'
require 'sinatra'
require 'yajl'
require 'digest/sha1'

set :url_set,    'urls'
set :all_hits, 'all_hits'

configure do
  REDIS = Redis.new
end

set :bind, '0.0.0.0'

get '/' do
  etag(Digest::SHA1.hexdigest(REDIS.get("#{settings.url_set}:#{settings.all_hits}").to_s))
  result  = REDIS.sort(settings.url_set, :by => 'nosort', :get => ['#', "#{settings.url_set}:*"])
  hash = Hash[result]
  Yajl::Encoder.encode(hash) + "\n"
  "You are talking to MACHINE: #{ENV["MACHINE_IP"]}".strip
end

post '/' do
  url = params['url']
  REDIS.incr("#{settings.url_set}:#{url}")
  REDIS.sadd(settings.url_set, url)
  REDIS.incr("#{settings.url_set}:#{settings.all_hits}")
  ""
end
