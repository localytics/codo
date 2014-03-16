_             = require 'underscore'

module.exports = class AngularEntity extends require('../../entity')

  @looksLike: (node, type) ->
    if node.constructor.name == 'Call' and value = node.variable?.properties?[0]?.name?.value
      value is type or _.isArray(type) and value in type
    else false
    
  constructor: (@environment, @file, @node) ->
    @name = node.args[0].base.value.replace(/'/g, '')

    @basename  = @name
    @namespace = @name
    # debugger
    # [@name, @selfish] = @fetchName()

    # Grab dependency names from the function signature
    @dependencyNames = []
    if objects = node.args?[1]?.base?.objects
      for param in (_.last(objects)?.params or [])
        @dependencyNames.push param.name.value

    @documentation = @node.documentation
    # @methods     = []
    # @variables   = []
    # @properties  = []
    # @includes    = []
    # @extends     = []
    # @concerns    = []
    # @descendants = []

  inspect: ->
    {
      file:            @file.path
      name:            @name
      documentation:   @documentation?.inspect()
      dependencies: @dependencies
    }