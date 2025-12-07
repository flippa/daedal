module Daedal
  module Functions
    """Class for decay function"""
    class DecayFunction < Function

      # required attributes
      attribute :field,  Daedal::Attributes::Field
      attribute :origin, Daedal::Attributes::QueryValue
      attribute :scale,  Daedal::Attributes::QueryValue

      # non required attributes
      attribute :offset, Daedal::Attributes::QueryValue, required: false
      attribute :decay,  Daedal::Attributes::QueryValue, required: false

      def to_hash
        {
          field => {
            origin: origin,
            offset: offset,
            scale: scale,
            decay: decay,
          }.compact
        }
      end
    end
  end
end
