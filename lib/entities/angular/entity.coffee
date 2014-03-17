_             = require 'underscore'

module.exports = class AngularEntity extends require('../../entity')

  @getName: (node) ->
    node.args?[0]?.base?.value?.replace(/'/g, '')

  @looksLike: (node, type) ->
    if node.constructor.name == 'Call' and value = node.variable?.properties?[0]?.name?.value
      (value is type or _.isArray(type) and value in type) and @getName(node)
    else false

  constructor: (@environment, @file, @node) ->
    @name = @constructor.getName(@node)
    
    @basename  = @name
    @namespace = @name
    # debugger
    # [@name, @selfish] = @fetchName()

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