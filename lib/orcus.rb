require "uri"
require "net/http"

module Orcus

  def self.say_hello
    puts "Hello world"
  end

  def self.jobEnded(hostname, chainInstance, status, output)
    puts "Job ended."

    url = URI.parse('http://localhost:3002/commands/save/bountyhunter')
    request = Net::HTTP::Post.new(url.path)
    request.add_field("Content-Type", "application/xml")

    body = "<content>"
    body = body + "<status>" + status.to_s + "</status>"
    body = body + "<output>" + output + "</output>"
    body = body + "<chainInstance>" + chainInstance.to_s + "</chainInstance>"
    body = body + "</content>"
    request.body = body

    response = Net::HTTP.start(url.host, url.port) {|http| http.request(request)}
    puts response.to_s
  end

  def self.getJob(hostname)

end

