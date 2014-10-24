((root, factory) ->
  if typeof define is "function" and define.amd
    
    # AMD. Register as an anonymous module.
    define "simple-module", ["jquery"], ($) ->
      root.returnExportsGlobal = factory($)

  else if typeof exports is "object"
    
    # Node. Does not work with strict CommonJS, but
    # only CommonJS-like enviroments that support module.exports,
    # like Node.
    module.exports = factory(require("jquery"))
  else
    root["SimpleModule"] = factory(jQuery)
  return
) this, ($) ->
  Module = undefined
  __slice_ = [].slice
  Module = (->
    Module = (opts) ->
      cls = undefined
      instance = undefined
      instances = undefined
      name = undefined
      _base = undefined
      _i = undefined
      _len = undefined
      @opts = $.extend({}, @opts, opts)
      (_base = @constructor)._connectedClasses or (_base._connectedClasses = [])
      instances = (->
        _i = undefined
        _len = undefined
        _ref = undefined
        _results = undefined
        _ref = @constructor._connectedClasses
        _results = []
        _i = 0
        _len = _ref.length

        while _i < _len
          cls = _ref[_i]
          name = cls.name.charAt(0).toLowerCase() + cls.name.slice(1)
          cls::_module = this  if cls::_connected
          _results.push this[name] = new cls()
          _i++
        _results
      ).call(this)
      if @_connected
        @opts = $.extend({}, @opts, @_module.opts)
      else
        @_init()
        _i = 0
        _len = instances.length

        while _i < _len
          instance = instances[_i]
          instance._init()  if typeof instance._init is "function"
          _i++
      @trigger "initialized"
      return
    Module.extend = (obj) ->
      key = undefined
      val = undefined
      _ref = undefined
      return  unless (obj?) and typeof obj is "object"
      for key of obj
        val = obj[key]
        this[key] = val  if key isnt "included" and key isnt "extended"
      (if (_ref = obj.extended)? then _ref.call(this) else undefined)

    Module.include = (obj) ->
      key = undefined
      val = undefined
      _ref = undefined
      return  unless (obj?) and typeof obj is "object"
      for key of obj
        val = obj[key]
        @::[key] = val  if key isnt "included" and key isnt "extended"
      (if (_ref = obj.included)? then _ref.call(this) else undefined)

    Module.connect = (cls) ->
      return  if typeof cls isnt "function"
      throw new Error("Widget.connect: cannot connect anonymous class")return  unless cls.name
      cls::_connected = true
      @_connectedClasses = []  unless @_connectedClasses
      @_connectedClasses.push cls
      this[cls.name] = cls  if cls.name

    Module::opts = {}
    Module::_init = ->

    Module::on = ->
      args = undefined
      _ref = undefined
      args = (if 1 <= arguments.length then __slice_.call(arguments, 0) else [])
      (_ref = $(this)).on.apply _ref, args
      this

    Module::one = ->
      args = undefined
      _ref = undefined
      args = (if 1 <= arguments.length then __slice_.call(arguments, 0) else [])
      (_ref = $(this)).one.apply _ref, args
      this

    Module::off = ->
      args = undefined
      _ref = undefined
      args = (if 1 <= arguments.length then __slice_.call(arguments, 0) else [])
      (_ref = $(this)).off.apply _ref, args
      this

    Module::trigger = ->
      args = undefined
      _ref = undefined
      args = (if 1 <= arguments.length then __slice_.call(arguments, 0) else [])
      (_ref = $(this)).trigger.apply _ref, args
      this

    Module::triggerHandler = ->
      args = undefined
      _ref = undefined
      args = (if 1 <= arguments.length then __slice_.call(arguments, 0) else [])
      (_ref = $(this)).triggerHandler.apply _ref, args

    Module::_t = ->
      args = undefined
      _ref = undefined
      args = (if 1 <= arguments.length then __slice_.call(arguments, 0) else [])
      (_ref = @constructor)._t.apply _ref, args

    Module._t = ->
      args = undefined
      key = undefined
      result = undefined
      _ref = undefined
      key = arguments[0]
      args = (if 2 <= arguments.length then __slice_.call(arguments, 1) else [])

      result = ((if (_ref = @i18n[@locale])? then _ref[key] else undefined)) or ""
      return result  unless args.length > 0
      result = result.replace(/([^%]|^)%(?:(\d+)\$)?s/g, (p0, p, position) ->
        if position
          p + args[parseInt(position) - 1]
        else
          p + args.shift()
      )
      result.replace /%%s/g, "%s"

    Module.i18n = "zh-CN": {}
    Module.locale = "zh-CN"
    Module
  )()
  if Function::name is undefined and Object.defineProperty
    Object.defineProperty Function::, "name",
      get: ->
        re = undefined
        results = undefined
        re = /function\s+([^\s(]+)\s*\(/
        results = re.exec(@toString())
        if results and results.length > 1
          results[1]
        else
          ""

      set: (val) ->

  Module
