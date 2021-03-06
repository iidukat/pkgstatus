module Packary
  class Metrics::RegistryPackage::ReleasesInMetric < Packary::Metric
    def self.group
      :registry
    end

    def self.title
      "Releases in #{DAYS} days"
    end

    DAYS = 180
    DURATION = DAYS.days

    def read(source)
      versions = source.gem_versions
      versions&.count {|x| Time.parse(x['built_at']) > (Time.current - DURATION) }
    end

    # Use ActiveModel::Attribute?
    def value
      original_value.to_i
    end

    def status
      return :warning unless value

      return :success if value > 0
      :warning
    end
  end
end
