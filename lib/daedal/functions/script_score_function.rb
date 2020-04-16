module Daedal
  module Functions
    """Class for script score function"""
    class ScriptScoreFunction < Function

      # required attributes
      attribute :script,    Daedal::Attributes::LowerCaseString

      def to_hash
        { script: script }
      end
    end
  end
end