Armstrong makes lexing with regex easy. 

There's no need to do repetitive things like checking for a match, returning a dictionary of the named capture groups
and then having to write a case to route the tokens to functions.

Armstrong handles everything in one Ruby function:

```ruby
Armstrong.given line, /if\s(?<value>.*?)\sisnt\s(?<condition>.*?), then: :generateIsntConditional
```

I know passing the line brings back the repetitive things from earlier, but it was the cleanest approach other than using a global flag or something of that sort.

The best part about Armstrong is the implicit argument passing: generateIsntConditional will receive match[:value] and match[:condition] without you having to write it out.
