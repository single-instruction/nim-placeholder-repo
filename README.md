# Nim Opt Type Clash Reproduction

This standalone repository demonstrates the Nim compiler confusion between a
type named `Foo` and a `Bar.Foo` enum member when both are in scope.

## Layout
- `foo.nim`: exports a distinct `Foo` type.
- `bar.nim`: exports a `Bar` enum that also has a value named `Foo`.
- `test.nim`: declares a variable of type `Opt[Foo]` and assigns `Opt.some(Foo)` to it.

## Triggering the Error

From this directory run:

```sh
nim c -r test.nim
```

With Nim 2.2.4 this emits:

```
test.nim(7, 25) Error: type mismatch: got 'Opt[foo.Foo]' for 'Opt[T](oResultPrivate: true, vResultPrivate: tmp)' but expected 'Opt[bar.Bar]'
```

The compiler resolves `Opt[Foo]` to `Opt[bar.Bar]` because it chooses the `Foo`
enum member over the imported type. Qualifying the type as `foo.Foo` avoids the
error, suggesting an identifier resolution bug.
