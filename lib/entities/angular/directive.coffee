Entities = require '../../_entities'
Entities.Angular   = require '../_angular'
_ = require 'underscore'

module.exports = class Entities.Angular.Directive extends require('./provider')

  @looksLike: (node) ->
    super(node, 'directive')