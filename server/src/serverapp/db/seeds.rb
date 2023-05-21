User.create([{ name: "System", email: "System"}])
User.create([{ name: "Dummy", email: "Dummy"}])

for i in 1..20
    TodoItem.create([{ text: "Sample #{i}", created_by:1, sort_order:i}])
end 

TodoItem.create([{ text: "Someone Else's", created_by:2, sort_order:21}])