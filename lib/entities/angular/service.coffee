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

    # Assume this service belongs to the most recently defined module
    @module = _.chain(@environment.entities).reverse().find((entity) -> entity instanceof Module).value()
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

    expressions = _.last(@node.args[1].base.objects)?.body?.expressions or []

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