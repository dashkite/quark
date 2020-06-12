# Quark

_Combinators for generating CSS_

Preprocessors, scoped CSS, atomic CSS, and CSS in JS are among the many ways developers and designers have tried to encapsulate, reuse, and manage CSS. Quark represents a new approach: encapsulating CSS in functions, which may then be composed into stylesheets.

```coffeescript
css = render styles [
  select "main > article", [
    reset "block"
    margin "bottom left"
    article [ "h1", "p", "lists", "blockquote", "figure" ] ] ]
```

This will produce CSS that looks like the following:

```css
main > article {
  margin: 0;
  padding: 0;
  border: 0;
  font-size: 100%;
  font: inherit;
  vertical-align: baseline;
}
main > article > h1 {
  font-family: 'sans-serif';
  font-weight: 'bold';
  font-size: '6.4rem';
  line-height: '8rem';
  color: '#111';
}
main > article > p {
  /* ... and so on  */
```

Obviously, the Quark code doesn’t look much like CSS, but that’s the point: we encapsulate resuable CSS as functions. In turn, those functions are composed to build up more sophisticated functions. As with Atomic CSS, we start out with simple building blocks. But unlike Atomic CSS, our building blocks are composable functions.

Let’s start with the building blocks. We have three:

- `styles` creates a new stylesheet.
- `select` places a new selector on the stack.
- `set` sets a property.

We also rely on Garden’s `pipe` and `pipeWith` functions for composition and Katana to manage our context stack. However, most of the time, you won’t need to worry about them.

With these simple functions, we can already build up arbitrarily complex stylesheets. But it’s a bit tedious, so we define simple combinators that are the Quark equivalent of atomic CSS. For example, this is `bold`:

```coffeescript
bold = set "font-weight", "bold"
```

This is `plain`, which provides a simple illustration of composition :

```coffeescript
plain = pipe [
  set "font-style", "normal"
  set "font-weight", "normal"
  set "text-decoration", "none"
  set "text-transform", "none"
]
```

The `set` function is curried, so we can also just provide shortcut functions for setting a property:

```coffeescript
mt = set "margin-top"
```

which we can later use in our stylesheet definitions like this:

```coffeescript
mt "4rem"
```

or to build up new combinators, like this:

```coffeescript
# margin-bottom large
mtl = mt "4rem"
```

If we want to be less cryptic, we can introduce lookup tables. The `lookup` helper makes this easy:

```coffeescript
margin = lookup
  "top large": set "margin-top", "4rem"
  "top medium": set "margin-top", "2rem"
  "top small": set "margin-top", "1rem"
  # ... and so on
```

We can now use `margin` like this:

```coffeescript
margin "top large"
```

Sometimes you simply want to lookup a _value_, like a color, and set a property using that value. We can do this using `pipe`, `lookup`, and `any`, which tries functions until one returns a defined value. This example tries a lookup for predefined color values, falling back to the value passed into it:

```coffeescript
# colors is a lookup table for color values
color = pipe [
  any [
    lookup colors
    identity
  ]
  set "color"
]
```

Sometimes you want to do a bunch of lookups and compose them together. We can do this with Garden's `pipeWith`:

```coffeescript
article = pipeWith lookup {h1, h2, p, ul, ol, li, blockquote}
```

which allows us to write:

```coffeescript
aritcle [ "h1", "p" ]
```

Of course, since these are still just functions, we can simply write them out when we need something funky. Here’s a combinator that allows us to express the font size relative to the line-height:

```coffeescript
text = curry (lh, r) ->
  pipe [
    set "line-height", lh
    set "font-size", "calc(#{lh} * #{r})"
  ]
```

Similarly, themes are just a set of combinators. Since it’s tedious to pass theme functions to every combinator that might need it, we can bind an entire set at once. Given a collection of related combinators, we can provide a `bind` function:

```coffeescript
{article} = Article.bind {color, type}
```

The combinators returned from the bind function will now use our theme functions.

Combinators may introduce nested selectors, which allows us to go beyond collections of properties. For example, the Article H1 combinator we referenced in our example introduces a nested selector:

```coffeescript
h1 = tee pipe [
  select "> h1", [
    type "heading"
    color "near-black"  
  ]
]
```

We use `tee` here so that subsequent combinators won’t end up being applied to our H1 selector.

## API

### Core

#### `styles`

Create a new stylesheet.

#### `select`

Push a selector onto the stack.

#### `set`

Set a property for a given rule.

#### `lookup`

Takes a dictionary and returns a function that will return the result of dereferencing its argument using the dictionary.

```coffeescript
margins = lookup "none": "none", "small": "1rem", "medium": "2rem", "large": "3rem"
assert.equal "2rem", margins "medium"
```

Since this is a curried function, you can use it define simple presets:

```coffeescript
type = lookup
  heading: pipe [ sans, bold, text (rem 8), 4/5 ]"
```

#### `any`

Returns a function that, given a value, will apply each given function with that value until one returns a value that isn’t undefined. In combination with lookup, this allows you to implement common patterns like prefixed properties:

```coffeescript
width = any [
  lookup
    stretch: pipe [
      set "width", "-webkit-fill-available"
      set "width", "stretch"
  ]
  # fallback...
  set "width"
]
```

#### `toString`

Given a stylesheet object, returns CSS.

#### `render`

Given a stylesheet function, executes it and calls `toString`.

```coffeescript
assert.equal render styles [ select "main", [ width "90%" ] ],
	"main { width: 90%; }"
```

### Units

#### `px`, `pct`, `em`, `rem`, `vh`, `vw`

Converts a number into CSS units.

```coffeescript
# set width to 20rem
width rem 20
```

### Height and Width

#### `width`, `height`

Set with units, or other CSS value, ex: `min-content`. Prefixes [`stretch`](https://developer.mozilla.org/en-US/docs/Web/CSS/height#Browser_compatibility).

```coffeescript
width pct 1/3
width "fit-content(20rem)"
```

#### `min`, `max`

Modifies `width` or `height`.

```coffeescript
# set the max width
max width "34em"
```

#### `readable`

Sets the `width`, `min-width`, and `max-width` to ensure the readability of the text. Equivalent to:

```coffeescript
width "stretch"
min width "20em"
max width "34em"
```

Based on Tachyon’s [`measure` classes](http://tachyons.io/docs/typography/measure/).

### Color

#### `color`

Sets the `color` property with color name based on the HTML or [Tachyon color](http://tachyons.io/docs/themes/skins/).

```coffeescript
color "white-20"
```

#### `background`

Sets the `background` property with a color name based on the HTML or Tachyon color or any valid [background](https://developer.mozilla.org/en-US/docs/Web/CSS/background) shorthand.

### Typography

#### `italic`, `bold`, `underline`, `strikeout`, `capitalize`, `uppercase`, `plain`

Sets the corresponding text property.

#### `sans`, `serif`, `monospace`

Sets the font family.

#### `text`

Sets the line-height and relative font-size.

```coffeescript
# set the line-height to 8rem and the font-size to 5.33rem
text (rem 8), 2/3
```

#### `type`

Sets font/text properties based on standard presets.

```coffeescript
type "extra large heading"
```

Presets:

| Preset              | Line Height (rem) | Font Size (rem) | Font Size (px) |
| ------------------- | ----------------- | --------------- | -------------- |
| banner              | 18                | 14.4            | 96             |
| extra large heading | 14                | 11.2            | 74 2&frasl;3   |
| large heading       | 10                | 8               | 53 1&frasl;3   |
| heading             | 8                 | 6.4             | 42 2&frasl;3   |
| small heading       | 7                 | 5.6             | 37 1&frasl;3   |
| extra small heading | 6                 | 4.8             | 32             |
| extra large copy    | 8                 | 5⅓              | 35 5&frasl;9   |
| large copy          | 7                 | 4⅔              | 31 1&frasl;9   |
| copy                | 6                 | 4               | 26 2&frasl;3   |
| small copy          | 5                 | 3⅓              | 22 2&frasl;9   |
| extra small copy    | 4                 | 2⅔              | 17 8&frasl;9   |

Pixel values are based on a rem size of 6 2&frasl;3 pixels.

### Borders

#### `border`

Sets the border using an array of presets. Color will be inherited unless set with `borderColor`.

```coffeescript
border [ "round" ]
border [ "top", "bottom" ]
border [ "pill" ]
```

##### Presets

- top, bottom, left, right
- dotted, dashed, thin, thick, thicker, thickest
- box, round, rounder, pill
- any value accepted by `color`

### Background Size

#### `cover`, `contain`

Sets the [`background-size`](https://developer.mozilla.org/en-US/docs/Web/CSS/background-size) property.

### Opacity

#### `opacity`

Set the opacity using a percentage.

#### `visible`

Set the opacity to 100%.

#### `invisible`

Set the opacity to 0%.

### Flexbox

#### `rows`, `columns`

Set up a row or column-based container.

#### `wrap`

Sets a flex container to wrap content. (Not wrapping is the default.)

### Forms

Presets for a variety of form elements:

- h1
- section
- input

### Tables

…

### Code

…

### Resets

Presets for a variety of resets:

- body, block, list, blockquote, table

### Normalize

#### `normalize`

…

### Article

#### `Article.bind`

…

#### `article`

…

- [ ]
  - [ ]
