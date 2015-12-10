module Ruboty
  module Actions
    class Todo < Base
      attr_reader :command, :arg, :brain

      def call
        (@command, @arg) = (message[:data] || '').split(/\s/, 2)
        @command ||= :list
        @brain = message.robot.brain

        message.reply "todo : [#{command}] #{arg} ( #{brain.inspect} )"
      end

    end
  end
end
