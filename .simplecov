SimpleCov.start do
  add_filter [ /channels/, /jobs/, /mailers/, /config/ ]
  add_filter %r{/types\/base.*/}

  add_group 'Models', 'app/models'
  add_group 'Controllers', 'app/controllers'
  add_group 'GraphQL', 'app/graphql'
  add_group 'Concerns', [ 'app/models/concerns', 'app/controller/concerns' ]
  add_group 'Helpers', 'app/helpers'
end