# vk

## Virtual DOM Template for CoffeeScript

Easy Virtual DOM Wrapper Inspired by [mauricemach/coffeekup](https://github.com/mauricemach/coffeekup "mauricemach/coffeekup")

```
bower install mizchi/vk
```

## Examples

### Basic usage

```coffee
React.createClass
  render: -> vk ($) ->
    $.h1 'Hello'
    $.ul className: 'foobar-container', ->
      $.li "foo"
      $.li "bar"
```

`vk` generate Virtual DOM

### Child component

```coffee
Greeting = React.createClass
  render: -> vk ($) ->
    	$.h1 "Hello"

Item = React.createClass
  render: ->
    {title} = @props
    vk {tag: 'li'}, ($) -> span title

React.createClass
  render: -> vk ($) ->
    $(Greeting)
    $.ul ->
      for i in [1..4]
        $(Item, title: "item:"+i)
```


## API

### vk

- `vk.render(block: Function)`
- `vk.render(opts: Object, block: Function)`

vk.render `opts` argument is for first element.

```
React.createClass
	render: -> vk (tag: 'ul', className: 'foo') ->
		d.li "foo"
		d.li "bar"
```

### DOM

- `d.<tagName>(opts: Object, block: Function)`
- `d.<tagName>(opts: Object, str: String)`
- `d.<tagName>(block: Function)`
- `d.<tagName>(string: String)`
- `d.<tagName>(opts: Object)`



## TODO

- tests

## Dependencies

- React

## LICENSE

MIT
