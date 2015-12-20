require 'listen'
require 'net/http'

listen_path = ARGV[0] || "/Users/jeremy/Desktop/photobooth-app"
server_path = ARGV[1] || "http://0.0.0.0:3001/photos/import"

listen_path= File.expand_path(File.dirname(__FILE__)).split("/lib")[0] + "/public/events"


`open #{listen_path}`
p "Listener Begins..."
p "Listener Server: #{server_path}"
p "Listener Folder: #{listen_path}"
p File.dirname(__FILE__)
p File.expand_path(File.dirname(__FILE__))
p File.expand_path(File.dirname(__FILE__)) + "/../public/events"
def send_new path_array
  path_array.each do |path|
    uri = URI('http://localhost:3001/photos/import')
    res = Net::HTTP.post_form(uri, path:path)
    puts "--------------------------------------------sent"
    puts res
  end
end

  
listener = Listen.to(listen_path) do |modified, added, removed|
  puts "modified absolute path: #{modified}"
  puts "added absolute path: #{added}"
  puts "removed absolute path: #{removed}"
  send_new(added)
end
listener.start # not blocking
sleep