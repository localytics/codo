_             = require 'underscore'

module.exports = class AngularEntity extends require('../../entity')

  @looksLike: (node, type) ->
    node.constructor.name == 'Call' && node.variable?.properties?[0]?.name?.value == type

  constructor: (@environment, @file, @node) ->
    @name = node.args[0].base.value.replace(/'/g, '')

    @basename  = @name
    @namespace = @name
    # debugger
    # [@name, @selfish] = @fetchName()

    @dependencies = _.map node.args?[1]?.base?.objects?[2]?.params or [], (param) -> param.name.value
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