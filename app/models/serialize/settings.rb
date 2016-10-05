class Serialize::Settings

  include Virtus.model

  attribute :drug_font_size, Integer, default: "12"
  attribute :drug_width, Integer, default: "80mm"
  attribute :drug_height, Integer, default: "46mm"


  class << self
    
    def dump(settings)
      settings.to_hash
    end

    def load(settings)
      new(settings)
    end

  end

end