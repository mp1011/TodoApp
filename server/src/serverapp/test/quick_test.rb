require_relative '../app/helpers/di_container'

puts 'start test'
class TestClass
    include $injector['data_context']

    def do_test
        query = data_context.todo_items
        puts query
    end
end

TestClass.new.do_test
puts 'done'
