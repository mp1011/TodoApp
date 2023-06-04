User.create([{ name: "System", email: "System"}])

if Rails.env.test?
    User.create([{ name: "Dummy", email: "Dummy"}])

    for i in 1..20
        TodoItem.create([{ text: "Sample #{i}", created_by:1, sort_order:i}])
    end 

    TodoItem.create([{ text: "Someone Else's", created_by:2, sort_order:1}])

    parent = TodoItem.create([{ text: "Parent", created_by:1, sort_order:22}]).first
    TodoItem.create([{ text: "Child", created_by:1, parent_id: parent.id, sort_order:1}])
    TodoItem.create([{ text: "Child2", created_by:1, parent_id: parent.id, sort_order:2}])
    TodoItem.create([{ text: "Child3", created_by:1, parent_id: parent.id, sort_order:3}])
    TodoItem.create([{ text: "Child4", created_by:1, parent_id: parent.id, sort_order:4}])
end if

if Rails.env.development?
    for i in 1..20
        TodoItem.create([{ text: "TEST #{i}", created_by:1, sort_order:i}])
    end 
    TodoItem.create([{ text: "TEST ABC 1", created_by:1, sort_order:21}])
    TodoItem.create([{ text: "TEST ABC 2", created_by:1, sort_order:22}])    
end