require_relative 'block'

class DateBlock < Block
  attr_accessor :id, :title, :type, :ref, :description, :structure, :separator, :required, :attachment

  def initialize(id: nil, title:, type: :date, ref: nil, description: nil, structure: nil,
                 separator: nil, required: nil, attachment: nil)
    @id = id
    @title = title || Fake.title 
    @type = type
    @ref = ref
    @description = description
    @structure = structure
    @separator = separator
    @required = required
    @attachment = attachment
  end

  def payload
    payload = {}
    payload[:title] = title
    payload[:type] = type.to_s
    payload[:id] = id unless id.nil?
    payload[:ref] = ref unless ref.nil?
    unless description.nil? && structure.nil? && separator.nil?
      payload[:properties] = {}
      payload[:properties][:description] = description unless description.nil?
      payload[:properties][:structure] = structure unless structure.nil?
      payload[:properties][:separator] = separator unless separator.nil?
    end
    unless required.nil?
      payload[:validations] = {}
      payload[:validations][:required] = required
    end
    payload[:attachment] = attachment unless attachment.nil?
    payload
  end

  def same_extra_attributes?(actual)
    (structure.nil? ? DateBlock.default.structure : structure) == actual.structure &&
      (separator.nil? ? DateBlock.default.separator : separator) == actual.separator &&
      (required.nil? ? DateBlock.default.required : required) == actual.required &&
      (attachment.nil? || attachment == actual.attachment)
  end

  def self.default
    DateBlock.new(
        title: 'A date block',
        structure: 'MMDDYYYY',
        separator: '/',
        required: false
    )
  end

  def self.full_example(id: nil)
    DateBlock.new(
        title: 'A date block',
        ref: Block.ref,
        separator: '-',
        structure: 'DDMMYYYY',
        required: true,
        id: id,
        description: 'a description of the date block',
        attachment: Block.attachment
    )
  end
end
