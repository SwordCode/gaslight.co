# http://emberjs.com/guides/models/using-the-store/

BlogAdmin.Store = DS.Store.extend
  # Override the default adapter with the `DS.ActiveModelAdapter` which
  # is built to work nicely with the ActiveModel::Serializers gem.
  adapter: '_ams'

BlogAdmin.ApplicationAdapter = DS.RESTAdapter.extend
  namespace: 'blog/api'

