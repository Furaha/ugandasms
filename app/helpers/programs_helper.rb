module ProgramsHelper

  def messages_text(messages)
    message_text = ""
    messages.each do |message|
      message_text << "\n"
      message_text << message
    end
    return message_text
  end
end
