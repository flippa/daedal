module Daedal
  module Queries
    """Class for the function score query"""
    class FunctionScoreQuery < Query

      # required attributes
      attribute :query,           Daedal::Attributes::Query
      attribute :score_functions, Daedal::Attributes::ScoreFunctionArray

      # non required attributes
      attribute :boost,           Daedal::Attributes::Boost,           required: false
      attribute :score_mode,      Daedal::Attributes::LowerCaseString, required: false
      attribute :boost_mode,      Daedal::Attributes::LowerCaseString, required: false
      attribute :filter,          Daedal::Attributes::Filter,          required: false

      def to_hash
        {
          function_score: {
            query: build_query,
            functions: score_functions.map { |f| { filter: f[:filter]&.to_hash, weight: f[:weight], script_score: f[:script_score]&.to_hash }.compact! },
            boost: boost || 1,
            score_mode: score_mode || "multiply",
            boost_mode: boost_mode || "multiply"
          }
        }
      end

      private

      def build_query
        if filter
          { filtered: { query: query.to_hash, filter: filter.to_hash } }
        else
          query.to_hash
        end
      end
    end
  end
end
