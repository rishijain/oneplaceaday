namespace 'db' do
  desc "assign role"
  task assign_role: :environment do
    general_role = Role.where(name: 'General').first
    admin_role = Role.where(name: 'Admin').first
    User.all.each do |user|
      if user.email == 'admin@athappyplace.com'
        user.update_column(:role_id, admin_role.id)
      else
        user.update_column(:role_id, general_role.id)
      end
    end
  end
end
