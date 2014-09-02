# vk

## Virtual DOM Template for CoffeeScript

Easy Virtual DOM Wrapper Inspired by [mauricemach/coffeekup](https://github.com/mauricemach/coffeekup "mauricemach/coffeekup")

```
bower install mizchi/vk
```

## Example

```coffee
React.createClass
  render: -> vk (d) ->
    d.h1 'Hello'
    d.ul className: 'foobar-container', ->
      d.li "foo"
      d.li "bar"
```

`vk` generate Virtual DOM

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
