Ransack.configure do |config|
  # config.add_predicate 'i_start', # Name your predicate
  #   # What non-compound ARel predicate will it use? (eq, matches, etc)
  #   arel_predicate: 'start',
  #   # Format incoming values as you see fit. (Default: Don't do formatting)
  #   # formatter: proc { |v| "#{v}-diddly" },
  #   # Validate a value. An "invalid" value won't be used in a search.
  #   # Below is default.
  #   # validator: proc { |v| v.present? },
  #   # Should compounds be created? Will use the compound (any/all) version
  #   # of the arel_predicate to create a corresponding any/all version of
  #   # your predicate. (Default: true)
  #   compounds: true,
  #   # Force a specific column type for type-casting of supplied values.
  #   # (Default: use type from DB column)
  #   #type: :string,
  #   # Use LOWER(column on database).
  #   # (Default: false)
  #   case_insensitive: true
end
