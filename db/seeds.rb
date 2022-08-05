email = "admin@mark423.local"
u = User.find_by(email: email)
password = SecureRandom.alphanumeric(8)

if u.nil?
  u = User.create!([{email: email, full_name: "Admin", password: password, is_admin: true}])
  
else
  u.password = password
  u.save
end
p "Admin #{email} password set to #{password}"