class Users::OverviewBlueprint < BaseBlueprint
  view :normal do
    fields :name, :email_address
  end
  
  view :extended do
    fields :first_name, :last_name, :email
  end
end