directory '/tmp/messages' do
    action :create
end

file '/tmp/messages/motd' do
    content 'Hello Chef'
end
