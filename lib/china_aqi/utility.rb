require 'httparty'
module ChinaAqi
  module Utility
    extend ActiveSupport::Concern

    included do |base|
      include HTTParty
      attr_accessor :parmas, :token
      class_attribute :base_uri, :method
      base.base_uri = URI::HTTP.build({host: 'www.pm25.in'})
    end

    def get
      ActiveSupport::JSON.decode(HTTParty.get(url).body)
    end

    def uri
      raise NotImplementedError, "Please set value for 'method' class attributes in '#{self.class.name}' class." if self.class.method.blank?
      self.class.base_uri.path = "/api/querys/#{self.class.method.to_s}.json"
      self.class.base_uri.query = @parmas.to_query
      self.class.base_uri
    end

    def url
      uri.to_s
    end
  end
end