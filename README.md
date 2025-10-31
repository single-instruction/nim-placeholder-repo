# Nim Opt Type Clash Reproduction

This standalone repository demonstrates the Nim compiler confusion between a
type named `Address` and an `Op.Address` enum member when both are in scope.

## Layout
- `addresses.nim`: exports a distinct `Address` type.
- `op_codes.nim`: exports an `Op` enum that also has a value named `Address`.
- `types.nim`: defines `TxContext.contractAddress` as `Opt[Address]`.
- `test.nim`: assigns `Opt.some(Address)` to that field.

## Triggering the Error

From this directory run:

```sh
nim c -r test.nim
```

With Nim 2.2.4 this emits:

```
test.nim(7, 43) Error: type mismatch: got 'Opt[addresses.Address]' for 'Opt[T](oResultPrivate: true, vResultPrivate: contractAddr)' but expected 'Opt[op_codes.Op]'
```

The compiler resolves `Opt[Address]` to `Opt[op_codes.Op]` because it chooses
the `Address` enum member over the imported type. Qualifying the type as
`addresses.Address` avoids the error, suggesting an identifier resolution bug.
