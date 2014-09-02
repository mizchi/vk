# unless window?
  # React = (require 'react') ? React

vk = ->
  vk.compile arguments...

vk.ctx = null
vk.dom = {}

buildTags = ->
  tags = Object.keys(React.DOM)
  isObject = (obj) ->
    (obj instanceof Object) and (Object.getPrototypeOf(obj) is Object.prototype)

  parseOption = (a1, a2) ->
    opts = {}
    block = ->
    text = null

    switch arguments.length
      when 0
        'pass'
      when 1
        if a1 instanceof Function
          block = a1
        else if (typeof a1) is 'string'
          text = a1
        else if isObject a1
          opts = a1
      when 2
        opts = a1

        if a2 instanceof Function
          block = a2
        else
          text = a2

    {text, block, opts}

  createTagFunc = (name) -> ->
    {text, block, opts} = parseOption arguments...

    orig = vk.ctx
    n = new Node name, opts, text
    vk.ctx.push n

    vk.ctx = n
    block()

    vk.ctx = orig

  tags.forEach (tag) ->
    vk.dom[tag] = createTagFunc(tag)

buildTags()

class Node
  constructor: (@tag, @opts, @text) ->
    @children = []

  push: (item) ->
    @children.push item

vk.render = (block) ->
  if block instanceof Function
    root = vk.ctx = new Node 'div', {}
    block(vk.dom)
  else if (typeof block) is 'string'
    root = vk.ctx = new Node 'div', block
  root

# React converter
vk.convert = ({tag, opts, children, text}) ->
  if text
    React.DOM[tag] opts, text
  else
    React.DOM[tag] opts, children.map (child) -> vk.convert(child)

vk.compile = (opts, block) ->
  if arguments.length is 1
    block = opts
    opts = {}

  tag = opts.tag ? 'div'

  node = vk.render(block)
  node.opts = opts
  node.tag = tag
  vk.convert node

# if module.exports?
  # module.exports = vk
# else
  # window.vk = vk
window.vk = vk

# Use
# template = (d) ->
  # d.h1 'hello'
  # d.ul {className: 'foo'}, ->
    # d.li "hoge"
    # d.li "fuga"

# util = require 'util'
# console.log util.inspect (vk template), true, null

