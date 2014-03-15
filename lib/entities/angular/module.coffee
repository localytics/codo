Entities = require '../../_entities'
Entities.Angular   = require '../_angular'
_             = require 'underscore'

module.exports = class Entities.Angular.Module extends require('./entity')

  @looksLike: (node) ->
    super(node, 'module')


  constructor: (@environment, @file, @node) ->
    super
    debugger

    @basename  = @name
    @namespace = @name
    # debugger
    # [@name, @selfish] = @fetchName()

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