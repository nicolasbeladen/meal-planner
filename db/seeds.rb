# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Lancement du seed"

puts "Vide la table user"
User.destroy_all
puts "Table User vidée"

test_user = User.find_or_create_by!(email: "hqueue2242@gmail.com") do |user|
  user.password = "password123"
  user.name = "Test User"
end

if test_user.previously_new_record?
  puts "✅ Utilisateur de test créé : #{test_user.email} / password123"
else
  puts "ℹ️  Utilisateur de test déjà présent : #{test_user.email}"
end