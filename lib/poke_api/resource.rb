module PokeApi
  class Resource
    attr_reader :external_id
    attr_accessor :attributes

    def initialize(external_id = nil, url: nil)
      @external_id = external_id || self.class.get_external_id_from_url(url)
      @attributes = {}
    end

    def self.type
      raise NoMethodError
    end
    
    def self.fetch(external_id)
      new_resource = new(external_id)
      new_resource.attributes = request("#{type}/#{external_id}").slice(*expected_attributes)
      new_resource
    end

    def self.expected_attributes
      []
    end
    
    def self.all_external_ids
      request("#{type}?limit=#{count}")['results'].map do |object|
        get_external_id_from_url(object['url'])
      end
    end

    def self.get_external_id_from_url(url)
      url&.split('/')&.last&.to_i
    end
    
    def self.count
      request(type)['count']
    end

    def get_record_id
      self.class
          .active_record_model
          .where(external_id: external_id)
          .limit(1)
          .pluck(:id)
          .first
    end

    def self.active_record_model
      type.capitalize.constantize
    end
    
    def self.request(resource)
      url = URI.parse("#{base_url}/#{resource}")
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port, use_ssl: url.scheme == 'https') {|http|
        http.request(req)
      }
      JSON.parse(res.body)
    end

    def self.base_url
      "https://pokeapi.co/api/v2"
    end
  end
end
