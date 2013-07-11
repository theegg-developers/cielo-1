require 'yaml'
module Cielo
  class Bandeira 

    attr_accessor :name, :installments, :debit

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def self.all
      bandeiras =[]
      bandeiras_yaml = YAML.load_file(File.dirname(__FILE__) +'/bandeiras.yml')
      bandeiras_yaml.each do |b| 
        bandeiras << Bandeira.new(b)
      end
      bandeiras
    end
  end
end