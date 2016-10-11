class Serialize::Settings

  include Virtus.model

  attribute :drug_font_size, Integer, default: "12"
  attribute :drug_width, String, default: "80mm"
  attribute :drug_height, String, default: "46mm"


  class << self
    
    def dump(settings)
      settings.to_hash
    end

    def load(settings)
      new(settings)
    end

  end

end