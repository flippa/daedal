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
            functions: score_functions.map { |score_function| build_score_function(score_function) },
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

      def build_score_function(score_function)
        {
          filter: score_function[:filter]&.to_hash,
          weight: score_function[:weight],
          script_score: score_function[:script_score]&.to_hash,
          gauss: score_function[:gauss]&.to_hash,
          exp: score_function[:exp]&.to_hash,
          linear: score_function[:linear]&.to_hash,
        }.compact
      end
    end
  end
end
