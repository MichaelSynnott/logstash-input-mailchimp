# encoding: utf-8
require "logstash/inputs/base"
require "logstash/namespace"
require "stud/interval"
require "socket" # for Socket.gethostname

# Mailchimp integration

class LogStash::Inputs::MailChimp < LogStash::Inputs::Base
  config_name "mailchimp"

  # If undefined, Logstash will complain, even if codec is unused.
  default :codec, "json"

  config :interval, :validate => :number, :default => 1, :required => true

  config :apikey, :validate => :string, :required => true

  config :mailchimplistid, :validate => :string, :required => true

  public
  def register
    @host = Socket.gethostname
  end # def register

  def run(queue)

    mailchimp = Mailchimp::API.new(@apikey)

    Stud.interval(@interval) do
      members = mailchimp.lists.members(@mailchimplistid)['data']
      event = LogStash::Event.new("message" => members, "host" => @host)
      decorate(event)
      queue << event
    end # loop
  end # def run

end # class LogStash::Inputs::MailChimp