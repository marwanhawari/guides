# CSS guide

## General
* `margin` between elements is _not_ additive. The `margin` between elements will just be the greater margin between the two elements.

`display` property:
* `block`: Element takes the whole line. Default for `div`
* `inline`: Element takes the minimum amount of space for its box. Content can't be resized. Default for `span`
* `inline-block`: Like inline but the `width` and `height` of the content _can_ be resized.
* `flex`: Make the element a flexbox container
* `grid`: Make the element a grid container

`position` property:
* `static`: Element placed in normal document flow. Can't reposition using `top`, `left`, `right`, `bottom`.
* `relative`: Element placed in normal document flow, but can reposition it relative to where it would normally be. The space it would normally occupy still remains "occupied" despite moving the element.
* `absolute`: Element removed from normal document flow and you can reposition it relative to its closest parent that has `position: relative`. If no parent has `postion: relative` than it can be repositioned relative to the entire document. Creates a new z-index. Margins do _not_ collapse with other margins. No space is "occupied" where it originally would have been.
* `fixed`: Element removed from normal document flow and you can reposition it relative to the entire document. The element will stay in the same window position even when scrolling. Creates new z-index.
* `sticky`: Element initially placed in normal document flow. You can position it so that once you scroll past it, it will "stick" to that position. The other elements are not affected.

`box-sizing` property:
* `content-box`: An element's `height` and `width` property only account for the size of the content.
* `border-box`: An element's `height` and `width` property accounts for the entire box (content + padding + border)

## Flex
Properties on flex containers:
* `justify-content`: align items along the "main" axis
* `align-items`: align items along the "cross" axis
* `align-content`: 
* `gap`: specify a gap size between flex items

Properties on flex items:
* `flex-grow`:
* `flex-shrink`:
* `align-self`:

## Grid
Properties on grid containers:
* `justify-content`:
* `justify-items`:
* `align-content`:
* `align-items`:
* `grid-template-columns`/`grid-template-rows`:
* `gap`/`column-gap`/`row-gap`:

Properties on grid items:
* `align-self`:
* `justify-self`:
