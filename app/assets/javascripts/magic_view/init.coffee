pageLoad = ->
  actionClassName = $('body').data('action-view')
  window.currentView = try
    eval("new #{actionClassName}()")
  catch error
    controllerClassName = $('body').data('controller-view')
    window.currentView = try
      eval("new #{controllerClassName}()")
    catch error
      new MagicView()
  window.currentView.render()

$ ->
  pageLoad()

  $(document).on 'turbolinks:before-render', ->
    window.currentView.cleanup()
    true
  $(document).on 'turbolinks:render', ->
    pageLoad()
    true

