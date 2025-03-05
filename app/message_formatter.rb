# frozen_string_literal: true

require 'logger'

# Custom log formatter that returns the message only. This ensures that the log entries are pure JSON.
class MessageFormatter < Logger::Formatter
  def call(_severity, _timestamp, _progname, msg)
    "#{msg}\n"
  end
end
