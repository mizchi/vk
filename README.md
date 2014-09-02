# vk - Virtual DOM Template for CoffeeScript

CAUTION: NOT READY TO USE

Virtual DOM Wrapper Inspired by coffeekup

```
bower install mizchi/vk
```

## How to use

```
React.createClass
	render: -> vk {}, (d) ->
		d.h1 'hello'
		d.ul className: 'foobar-container', ->
			d.li "foo"
			d.li "bar"
```

## dependencies

- React

## LICENSE

MIT
