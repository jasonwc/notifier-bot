require 'slack-ruby-client'
require 'dotenv'
Dotenv.load

Slack.configure do |config|
  config.token = ENV['TOKEN']
end

client = Slack::RealTime::Client.new
client.on :message do |data|
  puts data
  if data["channel"] == "G0R2UQF50" && data["text"] == "notify"
    group = client.web_client.groups_info(channel: data['channel'])
    members = group["group"]["members"]
    message = members.map {|member| "<@#{member}>"}.join(" ")
    client.web_client.chat_postMessage({channel: data['channel'], text: message})
  end
end
client.start!
