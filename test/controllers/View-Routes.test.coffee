View_Routes = require '../../src/controllers/View-Routes'
Server     = require '../../src/server/Server'

# to be removed since this code is moving to the Angular based UI
xdescribe 'controllers | View-Routes', ->
  app = null

  beforeEach ->
    app = new Server().setup_Server().app

  it 'constructor', ->
    using new View_Routes(null), ->
      @.options.assert_Is {}
    using new View_Routes(app: app), ->
      @           .constructor.name.assert_Is 'View_Routes'
      @.router    .constructor.name.assert_Is 'Function'
      @.app       .constructor.name.assert_Is 'EventEmitter'
      @.routes    .constructor.name.assert_Is 'Routes'
      @.data_Files.constructor.name.assert_Is 'Data_Files'

  it 'add_Routes', ->
    using new View_Routes(app:app), ->      
      @.add_Routes()
      @.router.stack.assert_Size_Is 2

  it 'list', ->
    res =
      render: (page, data)->
        page.assert_Is 'routes'
        data.routes.assert_Size_Is_Bigger_Than 21
                   .assert_Contains '/api/v1/file/get/team-random'
                   .assert_Contains '/view/team-random/table'

    using new View_Routes(app:app), ->
      @.app.get '/api/v1/file/get/:filename', ()->
      @.app.get '/view/:filename/table', ()->
      @.list(null, res)


  # todo: these two tests are not checking for the real difference between /list and /list-raw   
  it 'list', ->
    res =
      render: (page, data)->
        page.assert_Is 'routes'
        console.log data.routes.size()
        data.routes.assert_Contains '/ping'

    using new View_Routes(app:app), ->
      @.add_Routes()
      @.app.use('routes', @.router)
      @.list(null, res)

  it 'list-raw', ->
    res =
      render: (page, data)->
        page.assert_Is 'routes'
        data.routes.assert_Contains '/routes/list-raw'

    using new View_Routes(app:app), ->
      @.add_Routes()
      @.app.use('routes', @.router)
      @.list_Raw(null, res)
          