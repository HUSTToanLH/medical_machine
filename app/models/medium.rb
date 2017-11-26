class Medium < ApplicationRecord
  MEDIA_ATTRIBUTE = [:title, :description, :field_id, :url, :media_type]

  belongs_to :field

  validates :title, presence: true
  validates :description, presence: true
  validates :url, presence: true
  validates :media_type, presence: true
  validates :field_id, presence: true

  searchkick mappings: {
    medium: {
      _all: {enabled: true},
      properties: {
        title: {type: "string", analyzer: "default", include_in_all: true, boost: 2},
        description: {type: "string", analyzer: "default", include_in_all: true},
        field: {type: "string", analyzer: "default", include_in_all: true},
        media_type: {type: "integer", index: "not_analyzed", include_in_all: false}
      }
    }
  }

  scope :search_import,->{includes([:field])}

  def search_data
    {
      title: title,
      description: description,
      field: field.name,
      media_type: media_type
    }
  end
end
