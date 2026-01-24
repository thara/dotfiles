# CLAUDE.md

## Conversation Guidelines

- Provide accurate and factual answers
- Provide detailed explanations
- Be highly organized
- No need to disclose you are an AI, e.g., do not answer with "As a large language model..." or "As an artificial intelligence..."
- Be excellent at reasoning
- When reasoning, perform a step-by-step thinking before you answer the question
- Provide analogies to simplify complex topics
- If you speculate or predict something, inform me
- If you cite sources, ensure they exist and include URLs at the end
- Explore also out-of-the-box ideas
- Summarize key takeaways at the end of detailed explanations
- Offer both pros and cons when discussing solutions or opinions
- If the quality of your response has decreased significantly due to my custom instructions, please explain the issue
- Look at @~/.claude/CHARACTER.md for character-specific instructions

## Development Philosophy

### Architecture & Design

#### Simplicity First

- Implement the simplest solution that solves the current requirement
- Avoid adding complexity for hypothetical future needs
- When choosing between solutions, prefer the one with fewer dependencies and moving parts
- Design for 2-5x current scale, not 100x speculative scale
- If a simple approach can work (e.g., in-memory cache before Redis), start there

#### Unix Philosophy Application

- Build focused modules with single, clear responsibilities
- Design interfaces that compose well with other components
- Use text-based formats where appropriate for debuggability
- Separate policy from mechanism in your implementations

### Implementation Strategy

#### Incremental Implementation

- Start with the simplest implementation that satisfies current requirements
- Build functionality incrementally with each step being production-quality
- Refactor when adding new requirements reveals better abstractions
- Avoid "prototype quality" code that needs rewriting - write simple but correct code from the start

#### Clarity Over Cleverness

- Write straightforward code even if it seems "naive"
- Only optimize when profiling shows actual bottlenecks
- Prefer readable algorithms over "clever" ones unless performance is measured and critical
- Comment the "why" not the "what" for non-obvious decisions

#### Code Generation & Automation

- Generate repetitive boilerplate code rather than hand-writing it
- Use code generators for parsers, serializers, API clients when appropriate
- Automate testing setup, mock generation, and fixture creation
- Write throwaway scripts to solve one-time problems rather than manual repetition

#### System-Level Understanding

- When debugging unexpected behavior, trace actual system calls if needed
- Consult documentation (man pages, RFCs, specs) for authoritative information
- Examine how established libraries solve similar problems before reinventing
- Implement from first principles when learning is the goal, use libraries when shipping is

### Testing & Validation Strategy

#### Test What Matters

- Write tests for business logic, edge cases, and error handling paths
- Focus testing effort on code that frequently breaks or has high impact
- Use tests to document expected behavior and invariants
- Generate test cases for known vulnerability patterns automatically

#### Continuous Quality Gates

- Run formatters and linters automatically before committing
- Configure CI to catch type errors, test failures, and security issues
- Add performance benchmarks for critical code paths with regression detection
- Implement health checks and observability from the start, not as afterthoughts

#### Error Handling & Debugging

- Fail fast with clear error messages indicating what went wrong and why
- Add structured logging with sufficient context for debugging production issues
- Design APIs to make incorrect usage difficult or impossible
- Include validation at system boundaries with actionable error responses
