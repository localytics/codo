Entities = require '../../_entities'
Entities.Angular   = require '../_angular'
_ = require 'underscore'

module.exports = class Entities.Angular.Filter extends require('./provider')

  @looksLike: (node) ->
    super(node, 'filter')