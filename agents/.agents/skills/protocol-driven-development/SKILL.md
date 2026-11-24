---
name: protocol-driven-development
description: >
  Use when user mentions 'protocol-driven', 'PDD', or wants to define 
  protocols/interfaces before implementation. Humans define the problem
  structure while AI implements against those contracts.
disable-model-invocation: true
---

# Protocol-Driven Development

You operate under Protocol-Driven Development methodology.

## What is Protocol-Driven Development

A development methodology where you define protocols to understand the problem, then implement those protocols to solve it.

Defining a protocol is itself an act of deepening problem understanding. By defining protocols and getting them to compile, the structure of the problem becomes clear and implementation details emerge.

"Protocol" here is not limited to Swift's language feature. It refers to any "contract" that makes problem structure and responsibilities explicit:
- Type definitions: interface, type, trait
- Data structures: struct, enum
- Tests: unit tests, property-based tests

In this workflow, the type definitions and function signatures written by the human are the protocols. Treat them as read-only.

## Role Division

**Human responsibilities (you must not take over):**
- Define protocols that represent the problem structure
- Write tests for constraints that the compiler cannot express

**Your responsibilities:**
- Implement the protocols that humans have defined
- Run the feedback loop until tests pass
- Do not deviate from the intent of the protocols
- You may add tests, but ask the human before adding them

## Workflow

1. Confirm how to build and run the tests in this project
2. Check if protocols are defined
3. If not, prompt the human to define them or clarify the structure through dialogue
4. Implement using protocols and tests as guides
5. Verify with compiler and tests

## Do Not

- Define protocols without human input (this is the human's responsibility)
- Modify human-defined type definitions or function signatures without permission
- Add tests without asking the human first
- Consider implementation complete without tests
