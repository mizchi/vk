React = (require 'react') ? React

class VKNode
  constructor: (@tag, @opts, @text) ->
    @children = []

  push: (item) ->
    @children.push item

vk = -> vk.compile arguments...
vk.dom = (component, opts, text) ->
  node = new VKNode component, opts, text
  console.log node
  vk.ctx.push node
vk.ctx = null

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
    n = new VKNode name, opts, text
    vk.ctx.push n

    vk.ctx = n
    block()

    vk.ctx = orig

  tags.forEach (tag) ->
    vk.dom[tag] = createTagFunc(tag)

buildTags()

# template to ast
vk.render = (block) ->
  if block instanceof Function
    root = vk.ctx = new VKNode 'div', {}
    block(vk.dom)
  else if (typeof block) is 'string'
    root = vk.ctx = new VKNode 'div', block
  root

vk.vdom = [{}]

# ast to react shadow dom
vk.convert = ({tag, opts, children, text}, map) ->
  component = if tag instanceof Function then tag else React.DOM[tag]

  if map
    vk.vdom.push component opts, children.map (child) -> React.DOM[child.tag] child.opts, child.text
  else if text
    vk.vdom.push React.DOM[tag] opts, text
  else
    children.forEach (child) ->
      map = child.children.length > 0
      vk.convert(child, map)

  component.apply @, vk.vdom

vk.compile = (opts, block) ->
  if arguments.length is 1
    block = opts
    opts = {}

  tag = opts.tag ? 'div'

  node = vk.render(block)
  node.opts = opts
  node.tag = tag
  vk.convert node

if module.exports?
  module.exports = vk
else
  window.vk = vk

# Use
# template = ($) ->
  # $.h1 'hello'
  # $.ul {className: 'foo'}, ->
    # $.li "hoge"
    # $.li "fuga"

# util = require 'util'
# console.log util.inspect (vk template), true, null
