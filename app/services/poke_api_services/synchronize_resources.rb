class PokeApiServices::SynchronizeResources
  attr_reader :creation_errors

  def initialize
    @creation_errors = {}
  end

  def call
    create_missing_entries
  end

  private

  def active_record_model
    raise NoMethodError
  end

  def poke_api_class
    @poke_api_class ||= "PokeApi::#{active_record_model.to_s}".constantize
  end

  def create_missing_entries
    missing_entries_external_ids.each do |external_id|
      create_record(external_id)
    end
  end

  def missing_entries_external_ids
    poke_api_external_ids = poke_api_class.all_external_ids
    existing_entries_external_ids = active_record_model.where(external_id: poke_api_external_ids)
                                                       .pluck(:external_id)
    poke_api_external_ids - existing_entries_external_ids
  end

  def create_record(external_id)
    poke_api_object = poke_api_class.fetch(external_id)
    new_record = active_record_model.create(
      **params_for_create(poke_api_object),
      external_id: external_id
    )
    @creation_errors[external_id] = new_record.errors.messages unless new_record.persisted?
    [new_record, poke_api_object]
  end

  def params_for_create(poke_api_object)
    raise NoMethodError
  end
end
