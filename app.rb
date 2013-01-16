require 'sinatra'

Dir["#{File.dirname(__FILE__)}/lib/**/*.rb"].each { |library| load library }

# Load our .env file if we're developing locally
env_path = File.expand_path("../.env", __FILE__)
if File.exist?(env_path)
  File.read(env_path).gsub("\r\n","\n").split("\n").inject({}) do |ax, line|
    if line =~ /\A([A-Za-z_0-9]+)=(.*)\z/
      key = $1
      case val = $2
        # Remove single quotes
        when /\A'(.*)'\z/ then ax[key] = $1
        # Remove double quotes and unescape string preserving newline characters
        when /\A"(.*)"\z/ then ax[key] = $1.gsub('\n', "\n").gsub(/\\(.)/, '\1')
        else ax[key] = val
      end
      ENV[key] = ax[key]
    end
    ax
  end
end

post '/push' do
  Trellhub.new(params[:payload]).receive_push
end