Entities = require '../../_entities'
Entities.Angular   = require '../_angular'
_ = require 'underscore'

module.exports = class Entities.Angular.Service extends require('./provider')

  @looksLike: (node) ->
    super(node, ['factory', 'provider'])