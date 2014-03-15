Entities = require '../../_entities'
Entities.Angular   = require '../_angular'
Module = require './module'
_             = require 'underscore'

module.exports = class Entities.Angular.Service extends require('./entity')

  @looksLike: (node) ->
    super(node, 'factory')

  constructor: (@environment, @file, @node) ->
    super

    @module = _.chain(@environment.entities).reverse().find((entity) -> entity instanceof Module).value()
    @basename  = @name
    @namespace = if @module then @module.name else @name
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