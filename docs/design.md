# Design Guide

*Quark*

The design of Quark consists of four layers:

- The domain level, which models the elements of CSS, such as properties and rules
- The tree level, which models a tree of CSS elements
- The combinator level, which supports the creation of CSS combinators
- The convenience level, which builds up combinators from the combinator level

Each level is relatively simple by itself and builds on the levels below. The result is a library that allows us to create new combinators from a base set. For example, this returns a combinator for styling all `div` elements as flex containers when flexbox support is available:

```coffeescript
flexdiv = Q.supports "(display: flex)", [
  Q.select "div", [
    Q.display "flex"
] ]
```

This does not generate any CSS, but rather returns a function that that can be used to generate CSS, in combination with other CSS combinators.

Here’s another example of a pulse animation:

```coffeescript
pulse = Q.keyframes "pulse", [
  Q.keyframe ( Units.pct 0 ), [ Q.transparent ]
  Q.keyframe ( Units.pct 20 ), [ Q.opacity 0.2 ]
  Q.keyframe ( Units.pct 40 ), [ Q.opacity 0.4 ]
  Q.keyframe ( Units.pct 60 ), [ Q.opacity 0.6 ]
  Q.keyframe ( Units.pct 80 ), [ Q.opacity 0.8 ]
  Q.keyframe ( Units.pct 100 ), [ Q.opaque ]
]
```

We use other combinators here, like `transparent` and `opaque` which are themselves built up from simpler combinators. Let’s consider how we can do this.

First, we can define an `opacity` combinator based on `set`:

```coffeescript
opacity = set "opacity"
```

The `set` combinator takes two arguments, but it’s a curried function, so we can provide just the first argument and get another combinator that will take the second. Next, we predefine specific levels of opacity:

```coffeescript
transparent = opacity 0
opaque = opacity 1
```

We can now use these functions as in the animation above. And we can now use pulse anyplace we might use CSS combinators. For example, to pulse the focused element:

```coffeescript
Q.select ":focus", [ pulse ]
```

In principle, this is relatively simple. We do something quite similar do generate HTML. However, there are a couple of differences:

- Quark is more functional in nature: we always return functions
- Quark infers the correct CSS to generate based on the tree

For example, nested style rules may use `&` to indicate how to generate a nested rule, similar to tools like Sass and Stylus. Eventually, these features may be unnecessary, as CSS adds them directly. Regardless, the semantics of CSS documents are more complex and nuanced than HTML documents. 

The three layer design is what makes it possible to support this complexity. The domain level is concerned simply with creating elements and stitching them together. For example, here is a property declaration:

```coffeescript
property = Property.make "color", "green"
assert.equal "color: green;", property.render()
```

Here is an empty Style Rule:

```coffeescript
rule = Style.Rule.make "article"
```

We can append properties to a rule using the `append` method:

```coffeescript
rule.append Properties.from
  padding: 
    top: Units.rem 2
    left: Units.rem 1
```

As you can see in this example, we can create multiple properties at once using a dictionary. Nested properties are assumed to represent hyphenated properties, like `padding-top`.

We can also `render` rules, just as we can properties:

```coffeescript
assert.equal "article { padding-top: 2rem; padding-left: 1rem; }", rule.render()
```

By itself, the domain level isn’t terribly useful since it would be extremely cumbersome to build up a CSS document this way. The tree layer encapsulates the logic for how elements are glued together.

Nodes wrap elements as a *( parent, value )* pair. In addition, Nodes provide an `attach` method that combines two elements in a tree. The `attach` method delegates to a generic function that knows how to combine parents and values. The default implementation simply calls the parent’s `append` method with the given value. However, there are more sophisticated cases. For example, nested style rules must compose the selectors, which is implemented like so:

```coffeescript
generic attach,
  ( Node.contains Style.Rule ),
  ( Type.isType Style.Rule ),
  ( node, style ) ->
    style.selector = Selector.compose node.value.selector, style.selector
    attach node.parent, style
```

We can thus transform an array of Nodes into a tree representing a CSS document.

The last layer, the combinator layer, wraps the logic for building elements and wrapping them as Nodes. For example, this is the combinator for `select`:

```coffeescript
select = Fn.curry ( selector, fx ) ->
  Fn.pipe [
    K.push Fn.wrap selector
    K.poke Style.Rule.make
    K.poke ( value, parent ) -> { value, parent }
    K.poke Node.make
    Fn.pipe fx
    K.pop Node.attach
  ]
```

A document (or fragment of CSS) is built up using Katana. Let’s walk through what we’re doing here:

1. We first wrap the selector so we can place it on the stack.
2. We construct a Style Rule using the selector and replace the selector with the Style Rule on the stack.
3. We construct an object literal that we’ll use to construct a Node. The value is the Style Rule we just constructed. The parent is presumed to already be on the stack when `select` is called.
4. We construct the Node and use it to replace the object literal on the stack.
5. We execute the CSS functions passed into the `select` functions, which will now have the Node we constructed in (4) as a parent.
6. We call `attach` on the Node, which effectively merges it with the parent, and remove it from the stack.

All the base combinators follow this pattern. From there, we build up new combinators in the convenience layer, such as `opaque` in the example above. Quark convenience combinators are expressly not prescriptive: they simply provide shorthand for common scenarios. Other modules may build further to provide prescriptive combinators, like our `flexdiv` combinator above. Quark’s job is simply provide the foundation for such modules.

