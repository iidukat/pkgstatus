module Repocheck
  class Repository
    # FIXME: Detect repository service from uri
    def self.from_package(registry, name)
      uri = Resolver.new(registry, name).resolve
      Repositories::GithubRepository.new(uri)
    end

    def initialize(uri)
      @url = uri
    end

    attr_reader :uri

    def self.metric_classes
      []
    end

    def metrics
      self.class.metric_classes.map { |klass| klass.new(self) }
    end
  end
end
