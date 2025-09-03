# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Limpieza básica
AccountRole.destroy_all
Account.destroy_all
User.destroy_all
Role.destroy_all

# ---- Roles ----
roles = %w[admin subadmin visitor insider]
roles.each { |r| Role.create!(name: r) }

# ---- Usuario administrador inicial ----
admin_role = Role.find_by(name: "admin")

admin = User.create!(
  email: "admin@saas.com",
  password: "123456",
  password_confirmation: "123456",
  role: admin_role
)

puts "Usuario admin creado: #{admin.email} (role: #{admin.role.name})"

puts "Seed finalizado con éxito ✅"
