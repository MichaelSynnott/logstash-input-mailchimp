# encoding: utf-8
require "logstash/inputs/base"
require "logstash/namespace"
require "stud/interval"
require "socket" # for Socket.gethostname
require "mailchimp"
require "mailchimp/api"

# Mailchimp integration

class LogStash::Inputs::MailChimp < LogStash::Inputs::Base
  config_name "mailchimp"

  default :codec, "json"

  config :interval, :validate => :number, :default => 3600, :required => true

  config :apikey, :validate => :string, :required => true

  config :listid, :validate => :string, :required => true

  public
  def register
    @host = Socket.gethostname
  end

  def run(queue)

    mailchimp = Mailchimp::API.new(@apikey)

    Stud.interval(@interval) do
      members = mailchimp.lists.members(@listid)['data']
      members.each do |member|
        event = LogStash::Event.new("message" => member, "host" => @host)
        decorate(event)
        queue << event
      end
    end
  end

end