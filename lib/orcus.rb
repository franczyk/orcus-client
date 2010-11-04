require "uri"
require "net/http"
require "rexml/document"
require "./timing"

module Orcus
  include Timing

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

    url = URI.parse('http://' + server + ':' + port.to_s + '/commands/save/' + nodename + ".xml")
    request = Net::HTTP::Post.new(url.path)
    request.add_field("Content-Type", "application/xml")

    body = "<content>"
    body = body + "<status>" + status.to_s + "</status>"
    body = body + "<output>" + output + "</output>"
    body = body + "<chainInstance>" + chainInstance.to_s + "</chainInstance>"
    body = body + "</content>"
    request.body = body

    response = Net::HTTP.start(url.host, url.port) {|http| http.request(request)}
  end


  def self.runJob(server, port, nodename)
    # Arguments:
    #   server - address of machine running orcus server
    #   port - port that server is running on
    #   nodename - the name of the machine that is requesting the job
    #
    url = 'http://' + server + ':' + port.to_s + '/commands/' + nodename + ".xml"
    xml_data = Net::HTTP.get_response(URI.parse(url)).body
    doc = REXML::Document.new(xml_data)

    if xml_data.length <= 1
      return
    end


    begin
      chain_id = doc.elements["/chain-instance/chain-id"].text
      id = doc.elements["/chain-instance/id"].text
    rescue
      puts "failed to get chain info"
    end

    begin
      command = getAction(server, port, nodename, chain_id)
      puts "Command: " + command
    rescue
      puts "Could not get command"
    end

    begin
      output, returncode = runCommand(command)
    rescue
      puts "Error running command."
    end

    if returncode.to_i == 0
      rc=1
    else
      rc=0
    end

    output2 = output.gsub( /[\r\n]/, "")
    output = output2

    jobEnded(server, port, nodename, id, rc, output)

    return output
  end

  def self.runCommand(command)
    # This is where the beef is
    #Timing.out(60) do
      begin
        bb = IO.popen(command)
        b = bb.readlines
        output = b.join
        bb.close
        exitcode = $?
      rescue
        puts "TIMED OUT"
      end
    #end

    return output, exitcode.to_i
  end

  def self.getAction(server, port, nodename, chainid)
    url = 'http://' + server + ':' + port.to_s + '/commands/getAction/' + chainid.to_s + ".xml"
    xml_data = Net::HTTP.get_response(URI.parse(url)).body
    doc = REXML::Document.new(xml_data)
    begin
      command = doc.elements["/act/command"].text
    rescue
    end

    return command
  end

end

