# vk - Virtual DOM Template for CoffeeScript

Easy Virtual DOM Wrapper Inspired by [mauricemach/coffeekup](https://github.com/mauricemach/coffeekup "mauricemach/coffeekup")

```
bower install mizchi/vk
```

## How to use

```coffee
React.createClass
	render: -> vk (d) ->
		d.h1 'hello'
		d.ul className: 'foobar-container', ->
			d.li "foo"
			d.li "bar"
```

`vk` generate Virtual DOM

## API

### vk

- `vk.render(block: Function)`
- `vk.render(opts: Object, block: Function)`

### DOM

- `d.<tagName>(opts: Object, block: Function)`
- `d.<tagName>(opts: Object, str: String)`
- `d.<tagName>(block: Function)`
- `d.<tagName>(string: String)`
- `d.<tagName>(opts: Object)`


### Modify first root options

```
React.createClass
	render: -> vk (tag: 'ul', className: 'foo') ->
		d.li "foo"
		d.li "bar"
```

## TODO

- tests

## Dependencies

- React

## LICENSE

MIT
