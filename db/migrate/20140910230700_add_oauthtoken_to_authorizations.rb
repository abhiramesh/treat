class AddOauthtokenToAuthorizations < ActiveRecord::Migration
  def change
    add_column :authorizations, :oauth_token, :text
  end
end
