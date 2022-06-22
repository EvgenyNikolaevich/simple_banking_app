class LoggerWrapper < Logger::Formatter
  def self.call(severity, message, from)
    "#{Time.now}, #{severity}: #{message}. FROM: #{from}."
  end
end
