raw_config = File.read(RAILS_ROOT + "/config/<%= file_name %>_config.yml")
<%= constant_name %>_CONFIG = YAML.load(raw_config).symbolize_keys
