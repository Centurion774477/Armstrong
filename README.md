Armstrong makes lexing with regex easy. 

There's no need to do repetitive things like checking for a match, returning a dictionary of the named capture groups
and then having to write a case to route the tokens to functions.

Armstrong handles everything in a clean Ruby function:

```ruby
Armstrong.given line, /if\s(?<value>.*?)\sisnt\s(?<condition>.*?), call: :generateIsntConditional
```

I know passing the line brings back the repetitive things from earlier, but it was the cleanest approach other than using a global flag or something of that sort.

The best part about Armstrong is the implicit argument passing: generateIsntConditional will receive match[:value] and match[:condition] without you having to write it out.

However, there are two other functions to give you more choices on how you want arguments and capture groups handled.

The first of the two is `package`. Instead of passing each capture group as an argument, 
this wraps each capture group into a hash and passes that hash into your function.

The syntax looks like this:

```ruby
Armstrong.package line, /(?<title>.*)\s+regex/, for: :someFunction
```

The second of the two is `on`. This removes the capture group stuff entirely and just calls a function if a regex pattern matches a line.

The syntax looks like this:

```ruby
Armstrong.on line, matching: /(?<title>.*)\s+regex/, do: :someFunction
```

Or, you could write it like this:

```ruby

Armstrong.on line, /(?<title>.*)\s+regex/, do: :someFunction
```

If you have any questions or suggestions regarding Armstrong, email me at reeceturner1358@gmail.com. Cheers!
