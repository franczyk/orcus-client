require "uri"
require "net/http"

module Orcus

  def self.say_hello
    puts "Hello world"
  end


  def self.jobEnded(server, port, nodename, chainInstance, status, output)
    # Arguments: 
    #   server - address of machine that is running Orcus server
    #   port - port that server is running on
    #   nodename - machine that ran the job
    #   chainInstance - The job number that you are completing.
    #   status = 1 for successful, 0 for failed
    #   output - the text output from the job
    #

    url = URI.parse('http://' + server + ':' + port.to_s + '/commands/save/' + nodename)
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


  def self.getJob(server, port, nodename)
    # Arguments:
    #   server - address of machine running orcus server
    #   port - port that server is running on
    #   nodename - the name of the machine that is requesting the job
    #

    url = 'http://' + server + ':' + port.to_s + '/commands/' + nodename + ".xml"
    xml_data = Net::HTTP.get_response(URI.parse(url)).body
    puts xml_data
  end

end

