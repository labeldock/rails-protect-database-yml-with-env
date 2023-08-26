# Rails protect database.yml with ENV file

## Introduction
- This code was created to manage and securely hide database configuration details for Rails applications.
- By utilizing the `.env` file, you can prevent sensitive database credentials from being carelessly uploaded to remote Git repositories.

## How It Works
1. In Rails' `database.yml`, you can use template codes like `<%= ENV['NAME'] %>`.
2. An additional `database.yml.env` file is provided to assist in utilizing the ENV.
3. A quick look at the `example_rails_root` directory will provide a clearer understanding.

## Installation

1. Copy the `check_database_env.rb` file and paste it into the `config/initializers` directory of your project.
2. Refer to the `database.yml` format in this repository's `example_rails_root`. The file you import should contain the following code:
   ```yml
   default: &default
     adapter: postgresql
     encoding: unicode
     username: <%= ENV['DATABASE_USERNAME'] %>
     password: <%= ENV['DATABASE_PASSWORD'] %>
     host: <%= ENV['DATABASE_HOST'] %>
     port: <%= ENV['DATABASE_PORT'] %>
   ```
3. Launch your Rails application. If the `database.yml.env` file does not exist, it will be automatically created.
4. Open the `database.yml.env` file located in the `config` directory and enter the necessary database configuration values.
5. Restart your Rails application.

## Important Notes!
1. Add `config/database.yml.env` to your `.gitignore` file to prevent sensitive data from being uploaded to the remote repository.
2. Even if the `database.yml.env` is empty, if the corresponding environment variable exists, the Rails application will use that value.
