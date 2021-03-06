View_File = require '../../src/controllers/View-File'
Server     = require '../../src/server/Server'


describe 'controllers | View-File', ->
  app = null

  beforeEach ->
    app = new Server().setup_Server().app

  it 'constructor', ->    
    using new View_File(app: app), ->
      @           .constructor.name.assert_Is 'View_File'
      @.data_Files.constructor.name.assert_Is 'Data_Files'

  it 'add_Routes', ->
    using new View_File(app:app), ->
      @.add_Routes()
      @.router.stack.assert_Size_Is 1

  it 'list', ->
    res =
      render: (page, data)->
        page.assert_Is 'file-list'
        data.files.assert_Size_Is_Bigger_Than 3

    using new View_File(app:app), ->
      @.add_Routes()
      @.app.use('routes', @.router)
      @.list(null, res)
          