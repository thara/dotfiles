---
paths:
  - "**/*.go"
  - "**/go.mod"
  - "**/go.sum"
---
# Go Coding Rules

## Function Wrapping

- Do not wrap simple function calls in a dedicated function. Inline them at the call site.
  - Bad: `newDockerClient()` that only calls `client.New(client.FromEnv)`
  - Good: Call `client.New(client.FromEnv)` directly

## Error Handling

- Use `fmt.Errorf` with `%w` to wrap errors with context when propagating them up.
- Reserve `fmt.Fprintf(os.Stderr, ...)` for top-level error output in `main`.

## Single Level of Abstraction Principle (SLAP)

- Each function should operate at a single level of abstraction.
- `main` handles program lifecycle (setup, teardown, error output, exit code).
- A `run` function orchestrates high-level steps, wrapping each call's error with `fmt.Errorf`.
- Individual step functions contain the actual logic.
