Class     = require '../class'
Method     = require '../method'
Variable   = require '../variable'
Property   = require '../property'
Mixin      = require '../mixin'
Entities = require '../../_entities'
Entities.Angular   = require '../_angular'
Module = require './module'
_ = require 'underscore'

module.exports = class Entities.Angular.Service extends require('./entity')

  @looksLike: (node) ->
    super(node, 'factory')

  constructor: (@environment, @file, @node) ->
    super

    # debugger if @name is 'Region'
    # Try to find the module definition on the same line or the last one in history
    @module = if @node.variable?.base?.variable?.base?.value is 'angular' and
      @node.variable.base.variable.properties?[0]?.name?.value is 'module'
        new Module(@environment, @file, @node.variable.base)
      else
        _.chain(@environment.entities).slice().reverse().find((entity) -> entity instanceof Module).value()

    @basename  = @name
    @namespace = if @module then @module.name else @name
    # debugger
    # [@name, @selfish] = @fetchName()

    @documentation = @node.documentation
    @dependencies = []
    @classes = []
    # @methods     = []
    # @variables   = []
    # @properties  = []
    # @includes    = []
    # @extends     = []
    # @concerns    = []
    # @descendants = []

  linkify: ->
    super
    @linkifyDependencies()

    expressions = _.last(@node.args?[1]?.base?.objects or [])?.body?.expressions or []

    for node in expressions when node.entities
      for entity in node.entities
        switch
          when entity instanceof Class
            @classes.push entity

  linkifyDependencies: ->
    for dependency in @dependencyNames
      dep = @environment.find(Entities.Angular.Service, dependency) || dependency
      @dependencies.push dep

  inspect: ->
    {
      file:            @file.path
      name:            @name
      documentation:   @documentation?.inspect()
      dependencies: @dependencies
    }