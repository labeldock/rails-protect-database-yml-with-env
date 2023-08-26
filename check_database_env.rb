# https://github.com/labeldock/rails-simple-database-yml-with-env

DATABASE_YML_ENV_FILENAME = 'database.yml.env'
REQUIRED_ENV_VARIABLES = [
  'DATABASE_USERNAME',
  'DATABASE_PASSWORD',
  'DATABASE_HOST',
  'DATABASE_PORT'
]

env_file_path = Rails.root.join('config', DATABASE_YML_ENV_FILENAME)

# If the file does not exist, create it and print a warning message
unless File.exist?(env_file_path)
  File.write(env_file_path, REQUIRED_ENV_VARIABLES.map { |var| "#{var}=\n" }.join)
  puts "WARNING: The '#{DATABASE_YML_ENV_FILENAME}' file has been created."
end

# Load environment variables from the file
def load_env_vars_from_file(file_path)
  vars = {}
  File.readlines(file_path).each do |line|
    name, value = line.chomp.split('=').map(&:strip)
    vars[name] = value
  end
  vars
end

# Add missing environment variables to the file
def add_missing_vars_to_file(missing_vars, file_path)
  File.open(file_path, 'a') do |file|
    missing_vars.each { |var| file.puts("#{var}=") }
  end
end

file_env_vars = load_env_vars_from_file(env_file_path)

# Check and add any missing environment variables in the file
missing_vars_in_file = REQUIRED_ENV_VARIABLES - file_env_vars.keys
add_missing_vars_to_file(missing_vars_in_file, env_file_path) unless missing_vars_in_file.empty?

# Environment variable setting logic
REQUIRED_ENV_VARIABLES.each do |key|
  file_value = file_env_vars[key]
  system_env_value = ENV[key]

  if file_value && !file_value.empty?
    ENV[key] = file_value
  elsif system_env_value && !system_env_value.empty?
    ENV[key] = system_env_value
  else
    puts "ERROR: #{key} is not set in '#{DATABASE_YML_ENV_FILENAME}' or system environment variables. Please set its value."
    exit
  end
end
