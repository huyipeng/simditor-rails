class SimditorAutosave extends SimpleModule
  opts:
    autosave: false

  _init: ->
    @editor = @_module
    @opts.autosave = @opts.autosave || @editor.textarea.data('autosave')
    return unless @opts.autosave
    key = 'simditor-autosave-' + (@opts.autosave || @editor.id)

    @editor.on "valuechanged", =>
      localStorage[key] = @editor.getValue()

    @editor.el.closest('form').on 'submit', (e) ->
      localStorage.removeItem key

    @editor.setValue(localStorage[key]) if localStorage[key]

Simditor.connect SimditorAutosave