require_relative '../app/helpers/di_container'
register_container_mockauth

class TestClass
    include $injector['data_context']

    def do_test
    end
end
