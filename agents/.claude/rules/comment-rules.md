# Comment Permission Decision Flow

## Background

When AI edits code, it tends to make partial edits without a holistic view of the entire codebase, causing comments to fall out of sync with the code. Code errors can be detected by compiler errors or tests, but stale comments cannot be detected mechanically. Therefore, comments should be kept to an absolute minimum.

## Principles

1. **Express in code what can be expressed in code** - Use naming, types, and structure to convey intent
2. **Leave history to Git** - Track change history through commit logs and PRs
3. **Leave task information to task management tools** - Use Issues, PRs, and project management tools
4. **Write design decisions in design documents** - Use documents under `docs/`
5. **Comments are a last resort** - Only when absolutely necessary after considering all other means

---

## Decision Steps in Detail

### Step 1: Is it a doc comment immediately before a type/function?

Determine whether it is a documentation comment (JSDoc, TSDoc, etc.) placed immediately before a type or function definition.

- **If yes** → Go to Step 3 (API specification check)
- **If no** → Go to Step 2

---

### Step 2: Is it a file-top overview comment?

Determine whether it is a comment placed at the beginning of the file that describes the overall purpose of the file.

#### Allowed Content

- Overview of **what group of functionality** the file contains
- Overview of the module's responsibilities and role

```typescript
// Allowed: File overview
/**
 * Utility functions for drag & drop operations
 */

// Allowed: Module responsibilities
/**
 * Service responsible for tab persistence and restoration
 */
```

#### Prohibited Content

- **References to individual functions**: e.g., "Provides getXxx and setXxx functions"
- **Individual implementation details**: e.g., internal data structures used
- **Redundant duplication**: Repeating what is already expressed by function/class names

```typescript
// Prohibited: Referencing individual functions
/**
 * Tab management module
 * - createTab(): Creates a new tab
 * - closeTab(): Closes a tab
 * - getActiveTab(): Gets the active tab
 */

// Prohibited: Redundant description
/**
 * TabManager
 * A manager class for managing tabs  ← Obvious from the class name
 */
```

- **If appropriate as an overview** → [ALLOWED]
- **If references individual implementations/functions** → [PROHIBITED]
- **If not a file-top overview** → Go to Step 4

---

### Step 3: Is it an API specification description for external consumers?

Determine whether it contains only information needed when using the function or type from the outside.

#### Allowed Content

- Description of **what the function does** (overview of behavior)
- Description of **what to pass** as arguments
- Description of **what the return value represents**
- Description of possible exceptions or errors
- Usage notes (thread safety, idempotency, etc.)

```typescript
// Allowed
/**
 * Retrieves the list of tabs associated with the specified user ID.
 * @param userId - The target user's ID
 * @returns Array of tabs. Returns an empty array if the user does not exist
 */
function getTabsByUserId(userId: string): Tab[] { ... }
```

#### Prohibited Content

- **Change history**: Changes from previous implementations
- **Internal implementation details**: Information not needed for external usage

```typescript
// Prohibited: Change history
/**
 * Retrieves the tab list.
 * Added caching mechanism in v2.0.  ← Prohibited (change history)
 * Uses Map internally for performance. ← Prohibited (internal implementation detail)
 */
function getTabs(): Tab[] { ... }
```

- **If yes** → [ALLOWED]
- **If no** → [PROHIBITED]

---

### Step 4: Does it reference past implementations?

Determine whether the comment refers to past states, previous implementations, or change history.

#### Prohibited Patterns

| Pattern | Reason |
|---------|--------|
| "Changed to not do X" | Previous implementation can be found in Git history |
| "Added implementation of X" | What was added can be found in Git history |
| "Previously it was X, but..." | Past state can be found in Git history |
| "Did X to make tests pass" | Tests passing can be verified by CI/test execution |
| "Fixed bug in X" | Fix details can be found in Git history and Issues |

```typescript
// Prohibited
// Previously used filter but changed to for loop due to performance issues
for (const tab of tabs) { ... }

// Prohibited
// Added null check to fix bug reported in Issue #123
if (value !== null) { ... }
```

- **If references the past** → [PROHIBITED]
- **If no reference to the past** → Go to Step 5

---

### Step 5: Does it contain value judgments or design decisions?

Determine whether it contains reasoning for choosing among multiple options, trade-off explanations, or rationale for design decisions.

- **If contains value judgments** → Go to Step 6
- **If does not contain value judgments** → Go to Step 7

---

### Step 6: Does this value judgment need to remain in the code?

Determine whether the comment should remain based on the importance and scope of the value judgment.

#### Prohibited Patterns

| Pattern | Reason |
|---------|--------|
| "Implement X" | The implementation is visible in the code |
| "Use Y instead of X" | What is being used is visible in the code |
| "Adopted X because it's better" (minor decision) | Minor design decisions are not worth preserving |
| Major decisions affecting overall design | Should be documented in design documents (`docs/`, etc.) |

```typescript
// Prohibited: Obvious from the code
// Use Map
const cache = new Map<string, Tab>();

// Prohibited: Minor decision
// Using for...of instead of forEach for readability
for (const item of items) { ... }

// Prohibited: Should be in design documents
// Chose Zustand over Redux for state management.
// Reason: Reduced bundle size and less boilerplate
```

#### Allowed Patterns

Allowed only when **all** of the following are met:

1. It is an important design decision
2. The scope is local to a class/function (too localized for external design documents)
3. Without this information, future developers are likely to make incorrect changes

```typescript
// Allowed: Local but important design decision
// Reason for using WeakMap:
// - Cache is automatically released when Tab objects are garbage collected
// - Using Map would cause memory leaks
// This behavior is depended upon, so changing to Map is prohibited
private tabCache = new WeakMap<Tab, CachedData>();
```

- **Needs to remain (meets all conditions above)** → [ALLOWED] (judge carefully)
- **Does not need to remain** → [PROHIBITED]

---

### Step 7: Is it a memo from task execution?

Determine whether it is information about the currently executing task or work process.

#### Prohibited Patterns

| Pattern | Reason |
|---------|--------|
| "Per user's instructions, did X" | How/why the task was given is unrelated to the code |
| "Did X to make tests pass" | What matters is that tests pass; the process is unnecessary |
| "Added for debugging" | Unnecessary information after debugging is complete |
| "Fixed per review feedback" | Review history can be found in PR/MR |
| "Temporary fix" | If it's temporary, it should be managed via Issues |

```typescript
// Prohibited
// Added this feature per user request
function exportToCsv() { ... }

// Prohibited
// Added null check because this test was failing
if (data !== null) { ... }

// Prohibited
// Fixed per review feedback in PR #456
const sanitized = sanitizeInput(input);
```

- **If it is a task execution memo** → [PROHIBITED]
- **If it is not a task execution memo** → Go to Step 8

---

### Step 8: Can it be expressed through naming?

Determine whether the comment's content can be replaced by appropriate naming.

#### Prohibited Patterns

```typescript
// Prohibited: Can be expressed through variable name
// Get user information
const data = fetchData();
// → Improvement: const userData = fetchUserData();

// Prohibited: Can be expressed through function name
// Close the tab
closeItem();
// → Improvement: closeTab();

// Prohibited: Can be expressed through variable name
// Active tabs only
const tabs = allTabs.filter(t => t.active);
// → Improvement: const activeTabs = allTabs.filter(t => t.active);

// Prohibited: Repeating what the variable name already expresses
// Create mock storage service
mockStorageService = { get: vi.fn(), set: vi.fn() };
// → The variable name mockStorageService already makes "mock storage service" self-evident

// Prohibited: Variable purpose is obvious from its name
// Timeout setting
const timeout = 5000;
// → Self-evident from the name "timeout"
```

Instead of writing a comment, consider improving the naming. **If the variable name already expresses the content of the comment, that comment is redundant.**

- **If expressible through naming** → [PROHIBITED] (improve the naming)
- **If not expressible through naming** → Go to Step 9

---

### Step 9: Can it be expressed through types?

Determine whether the comment's content can be expressed through the type system.

#### Prohibited Patterns

```typescript
// Prohibited: Can be expressed through types
// User ID is a string
const userId = "123";
// → Improvement: const userId: UserId = "123";

// Prohibited: Can be expressed through types
// Will never be null
const user = getUser()!;
// → Improvement: Fix the function's return type or use a type guard
```

- **If expressible through types** → [PROHIBITED] (improve the type definitions)
- **If not expressible through types** → Go to Step 10

---

### Step 10: Is it explaining a common library practice?

Determine whether the comment explains a common usage pattern of a library (React, Vue, Express, etc.).

#### Prohibited Patterns

Common patterns that any developer proficient in the library should know do not need to be explained with comments.

```typescript
// Prohibited: Common React pattern
// Track drag state with ref (to reference the latest value in event handlers)
const dragStateRef = useRef<DragState>(initialDragState);

// Prohibited: Addressing React's closure issue
// Hold callback in ref (to reference the latest value in event handlers)
const callbacksRef = useRef({ onDragStart, onDragMove });

// Prohibited: Stabilizing useCallback dependency array
// Hold getSubtreeNodeIds in ref (to stabilize useCallback dependency array)
const getSubtreeNodeIdsRef = useRef(getSubtreeNodeIds);

// Prohibited: React rendering phase
// Hold as state to avoid referencing ref during rendering
const [rect, setRect] = useState<DOMRect | null>(null);
```

These are common knowledge for React developers, and the code is understandable without comments.

#### Allowed Patterns

Allowed when there are project-specific usages or unusual reasons.

```typescript
// Allowed: Project-specific reason
// Reason for using ref: This project tracks all state updates
// for performance measurement, and useState would introduce noise
const valueRef = useRef(initialValue);
```

- **If explaining a common library practice** → [PROHIBITED]
- **If not a common practice** → Go to Step 11

---

### Step 11: Is it a comment explaining units, magic numbers, or hard-to-read values for numeric types?

Determine whether the comment explains units (milliseconds, seconds, minutes, pixels, etc.), magic numbers, or hard-to-read values (color codes, etc.) for numeric literals or numeric type fields.

#### Allowed Patterns

When creating a type for the unit is unnecessary overhead, clarifying units via comments is allowed.

```typescript
// Allowed: Time units
private readonly DEBOUNCE_MS = 300; // milliseconds
const timeout = 5000; // ms
const interval = 60; // seconds

// Allowed: Size units
const margin = 8; // px
const threshold = 0.5; // ratio (0-1)
```

Comments for magic numbers or hard-to-read values whose meaning is unclear from the code alone are allowed.

```typescript
// Allowed: Color names for color codes
const PRESET_COLORS = [
  '#ef4444', // Red
  '#f97316', // Orange
  '#3b82f6', // Blue
];

// Allowed: HTTP status codes
if (response.status === 429) { // Too Many Requests
  await delay(retryAfter);
}

// Allowed: Bit flags
const flags = 0x04; // READ_ONLY
```

#### Prohibited Patterns

When the unit can be included in the variable name, prefer naming over comments.

```typescript
// Prohibited: Can be expressed through variable name
const timeout = 5000; // milliseconds
// → Improvement: const timeoutMs = 5000;

// However, if the constant or field name already includes the unit,
// no additional comment is needed
private readonly DEBOUNCE_MS = 300; // ← No comment needed, obvious from name
```

- **If explaining units/magic numbers/hard-to-read values and difficult to express through naming** → [ALLOWED]
- **If expressible through naming** → [PROHIBITED]
- **If not applicable** → Go to Step 12

---

### Step 12: Is it a type information supplementary comment for interface fields?

Determine whether the comment supplements an interface or type definition field to indicate that a `string` type actually represents a specific format (JSON, URL, date string, etc.).

#### Allowed Patterns

Comments explaining the actual data format of a field that cannot be fully expressed by the type system are allowed.

```typescript
// Allowed: JSON serialized data
interface SnapshotRecord {
  id: string;
  data: string; // JSON stringified SnapshotData
}

// Allowed: Specific string format
interface Config {
  dateStr: string; // ISO 8601 format
  apiEndpoint: string; // Must end with /api/v1
}

// Allowed: Chrome API terminology supplement
interface ExtendedTabInfo {
  discarded: boolean; // Hibernated tab (not yet loaded)
}
```

#### Prohibited Patterns

```typescript
// Prohibited: Self-evident from type name
interface User {
  name: string; // Username ← Self-evident that it's a string
}
```

- **If explaining a data format difficult to express through types** → [ALLOWED]
- **If self-evident from the type name** → [PROHIBITED]
- **If not applicable** → Go to Step 13

---

### Step 13: Is it a test code-specific comment?

Determine whether it is a comment within a test file (`*.test.ts`, `*.test.tsx`, `*.spec.ts`).

#### Allowed Patterns

##### Arrange/Act/Assert Pattern

AAA (Arrange/Act/Assert) comments that clarify test phases are allowed.

```typescript
// Allowed: AAA pattern
test('should update user profile', async () => {
  // Arrange
  const user = createTestUser();
  const newData = { name: 'New Name' };

  // Act
  await updateProfile(user.id, newData);

  // Assert
  expect(await getUser(user.id)).toMatchObject(newData);
});
```

##### ASCII Art Illustrating Preconditions/Expected State in Tests

ASCII art that visually represents data structures (trees, graphs, etc.) built in tests is allowed when it significantly aids understanding of the test scenario.

```typescript
// Allowed: Tree structure built in test
test('should move tab with subtree', async () => {
  // Initial state:
  // parent
  //   ├── child1
  //   │   └── grandchild
  //   └── child2
  const parent = await createTab();
  const child1 = await createTab({ parentId: parent.id });
  // ...
});
```

However, **do not blindly add to every test** — only use when illustration significantly reduces cognitive load when reading the code.

##### Natural Language Description of Test Scenarios

Natural language descriptions that clarify the purpose, preconditions, and expected results of a test beyond what the test name alone can express are allowed.

```typescript
// Allowed: Complex scenario description
test('handles race condition in concurrent updates', () => {
  // This test verifies that when multiple updates occur simultaneously
  // on the same resource, only the last update is reflected and
  // intermediate states are not persisted.
  // While rare in production, this is necessary to guarantee data integrity.
});
```

#### Prohibited Patterns

```typescript
// Prohibited: Duplicates test name
describe('UserService', () => {
  // Tests for UserService ← Duplicates the describe name
});

// Prohibited: Obvious from the code
// Create mock storage service
mockStorageService = { get: vi.fn(), set: vi.fn() };
// → Self-evident from variable name mockStorageService

// Prohibited: Unclear intent for waiting (allowed if intent is explained)
// Wait for async processing to complete
await new Promise(resolve => setTimeout(resolve, 10));
// → The intent of what is being waited for is unclear
```

- **If appropriate as AAA, ASCII art, or scenario description** → [ALLOWED]
- **If duplicates test name or self-evident from code** → [PROHIBITED]
- **If not test code or not applicable** → Go to Step 14

---

### Step 14: Is it explaining preconditions/postconditions of complex processing?

Determine whether the comment explains conditions that hold as a result of complex processing.

#### Considerations

Before writing the comment, consider the following:

1. Can the processing be extracted into a named function?
2. Can the processing order be rearranged for better clarity?
3. Can intermediate variables be introduced to clarify intent?
4. Can the condition be expressed through assertions?

```typescript
// Before improvement (relying on comments)
// Complex calculation...
let x = /* complex processing */;
// At this point, x is guaranteed to be positive
processPositiveNumber(x);

// After improvement (expressed in code)
const x = calculatePositiveValue(/* input */);
console.assert(x > 0, 'x must be positive');
processPositiveNumber(x);
```

#### Allowed Patterns

Allowed only when complexity is unavoidable despite all improvement attempts and the condition is not self-evident.

```typescript
// Allowed: Algorithm invariant
// Loop invariant: At this point, left <= pivot < right holds
// If this condition is violated, the partition will not work correctly
while (left < right) {
  // Quicksort partition processing
  ...
}
```

- **If expressible in code** → [PROHIBITED] (improve the code)
- **If truly inexpressible** → [ALLOWED]
- **If not about preconditions** → Go to Step 15

---

### Step 15: Is it a comment explaining ordering constraints?

Determine whether the comment explains that the execution order of operations is important and that reordering would cause bugs.

#### Allowed Patterns

Allowed only when **all** of the following are met:

1. Reordering the operations appears to work at first glance
2. However, the order is actually important and reordering causes bugs
3. This constraint is not obvious from the code structure

```typescript
// Allowed: Order is important but appears swappable
// Register duplicate source with Service Worker before duplication
// (must execute before onCreated fires)
await chrome.runtime.sendMessage({
  type: 'REGISTER_DUPLICATE_SOURCE',
  payload: { sourceTabId: tabId },
});
await chrome.tabs.duplicate(tabId);

// Allowed: Initialization order constraint
// loadState() must execute before syncWithChromeTabs()
// (saved parent-child relationships must be restored first or they'll be lost during sync)
await manager.loadState();
await manager.syncWithChromeTabs();
```

#### Prohibited Patterns

Comments are unnecessary when there is no risk of reordering.

```typescript
// Prohibited: Order is obvious from return value dependencies
const user = await fetchUser(id);
const profile = await fetchProfile(user.profileId); // Won't work without user

// Prohibited: Order is obvious from variable scope
const result = calculate(input);
console.log(result); // Would error without result
```

- **If appears swappable but order is important** → [ALLOWED]
- **If order is self-evident** → [PROHIBITED]
- **If not about ordering constraints** → Go to Step 16

---

### Step 16: Is it a comment explaining stages of a multi-step process?

Determine whether the comment explains individual stages in a multi-step process that is difficult to grasp from the code alone.

#### Allowed Patterns

Allowed only when **all** of the following are met:

1. The process is divided into multiple stages
2. Extracting into functions would be overkill (would actually reduce readability)
3. Comments are placed **immediately before each step**

```typescript
// Allowed: Explaining a 2-stage process (placed immediately before each step)
// Rebuild while maintaining the order of the children array stored in storage
// Processed in 2 stages: 1. Add in saved order, 2. Add children linked by parentId but not yet added
const addedChildIds = new Set<string>();

// Stage 1: Add children in saved order
for (const childId of savedChildren) {
  ...
}

// Stage 2: Add children linked by parentId but not yet added (fallback)
Object.entries(reconstructedNodes).forEach(([id, node]) => {
  ...
});
```

#### Prohibited Patterns

```typescript
// Prohibited: Comment far from the processing
/**
 * This function processes in 3 stages:
 * 1. Fetch data
 * 2. Transform data
 * 3. Save data
 */
function processData() {
  // No comments here
  const data = fetch();
  // None here either
  const transformed = transform(data);
  // Nor here...
  save(transformed);
}
// → Improvement: Place comments immediately before each step, or extract into functions

// Prohibited: Complexity warrants function extraction
// Stage 1: User authentication
// ... 50 lines of auth processing ...
// Stage 2: Data fetching
// ... 50 lines of data fetching ...
// → Improvement: Extract into authenticateUser(), fetchData()
```

- **If multi-step process with comments immediately before each step** → [ALLOWED]
- **If comments are far from the processing** → [PROHIBITED]
- **If complexity warrants function extraction** → [PROHIBITED] (extract into functions)
- **If not about multi-step process explanation** → Go to Step 17

---

### Step 17: Is it a hack, workaround, or intentional error suppression?

Determine whether it is an unconventional usage, library bug workaround, intentional rule violation, or intentional error suppression.

#### Allowed Patterns

Comments explaining the reason for hack-like code are allowed:

```typescript
// Allowed: Intentional use of side effects
// Call getComputedStyle to force style recalculation
// (to immediately reflect DOM changes)
void getComputedStyle(element).opacity;

// Allowed: Library bug workaround
// Workaround for React 18.2 bug where ref becomes null in useEffect cleanup
// https://github.com/facebook/react/issues/xxxxx
const ref = useRef<HTMLElement | null>(null);
const stableRef = useRef(ref.current);

// Allowed: Browser compatibility hack
// Safari's scrollIntoView with behavior: 'smooth' does not work
// under certain conditions, so using polyfill
import smoothscroll from 'smoothscroll-polyfill';

// Allowed: Intentional error suppression
} catch (_error) {
  // Error when tab doesn't exist is ignored (normal behavior)
}

// Allowed: Silent failure
} catch (_error) {
  // Storage save failure is ignored (will be retried next time)
}

// Allowed: Explaining why error is ignored
} catch (_error) {
  // Cleanup failure is not critical, so ignored
}
```

**In catch blocks that suppress errors**, comments explaining why it is safe to ignore the error are allowed. This prevents future developers from mistakenly thinking error handling is insufficient.

#### Considerations

Before writing a hack, consider the following:

1. Can the goal be achieved without a hack?
2. Would a library update resolve the issue?
3. Could an alternative library be used?

- **If it is an unavoidable hack or intentional error suppression** → [ALLOWED]
- **If not a hack or error suppression** → Go to Step 18

---

### Step 18: Is it behavior with high "surprise factor" that differs from normal expectations?

Determine whether the comment explains an implementation whose behavior differs from what would normally be expected from the function or variable name.

#### Allowed Patterns

Allowed when the actual behavior differs from what the name suggests and the difference is important.

```typescript
// Allowed: Surprising behavior of ignoring some updates
// Only update when title, favicon, URL, pin state, or discarded state changes
// Note: Changes to status alone do not create new entries (prevents extra Loading tabs)
function handleTabUpdated(tabId: number, changeInfo: TabChangeInfo) {
  if (!changeInfo.title && !changeInfo.favIconUrl && ...) {
    return; // Ignore status-only changes
  }
  ...
}

// Allowed: Surprising behavior of not deselecting
// Note: Do not clear selection state on active tab change
// Tab clicks within the tree also fire onActivated,
// which would conflict with click-based selection operations
function handleTabActivated(tabId: number) {
  // Do not deselect
  ...
}
```

#### Prohibited Patterns

Prohibited when surprise factor is low or when naming/function extraction can address it.

```typescript
// Prohibited: Can be addressed through naming
// New tabs are added to the end
tabs.push(newTab);
// → Improvement: appendTabToEnd(newTab);

// Prohibited: Low surprise factor
// Use default value if null
const value = input ?? defaultValue;
// → Self-evident, not needed
```

- **If behavior differs from name expectations and is important** → [ALLOWED]
- **If low surprise factor or addressable through naming** → [PROHIBITED]
- **If not applicable** → Go to Step 19

---

### Step 19: Is the intent unclear from the code alone?

Determine whether the comment explains the intent of code where "what it does" is clear from reading the code, but "why it does it" is unclear.

#### Allowed Patterns

When the code's behavior is clear but its purpose/reason is not, intent-explaining comments are allowed.

```typescript
// Allowed: Reason for waiting is unclear
// Wait for React's state updates to be reflected in the DOM
await new Promise(resolve => setTimeout(resolve, 10));

// Allowed: Why this specific value is unclear
// To avoid Chrome extension API rate limits
const BATCH_SIZE = 50;

// Allowed: Why this order is unclear
// Closing the connection before the IndexedDB transaction completes causes an error
await transaction.done;
db.close();
```

#### Prohibited Patterns

Comments are unnecessary when intent is clearly understandable from reading the code.

```typescript
// Prohibited: Intent is self-evident
// Return null if user does not exist
if (!user) return null;
// → Null guard is a common pattern with self-evident intent

// Prohibited: Intent can be expressed through naming
// Clear the cache
data = null;
// → Improvement: Extract into a function like clearCache()

// Prohibited: Describes behavior, not intent
// Wait 10 milliseconds
await new Promise(resolve => setTimeout(resolve, 10));
// → "Wait" is obvious from code. "Why wait" is the intent
```

- **If intent is unclear from code alone and the comment explains intent** → [ALLOWED]
- **If intent is self-evident or merely describes behavior** → [PROHIBITED]
- **If not applicable** → Go to Step 20

---

### Step 20: Uncategorized (Requires Reporting)

Comments that cannot be classified by the steps above indicate that this flow needs improvement.

Leave the comment and complete the task, then report the following information to the user after task completion to help improve the flow:

- Full text of the comment
- File and line number where the comment is written
- Inferred intent of the comment
- Why it could not be classified by existing steps

---

## Decision Result Summary

| Step | Condition | Result |
|------|-----------|--------|
| 2 | File-top overview (not redundant) | Allowed |
| 2 | References to individual functions / redundant description | Prohibited |
| 3 | API specification description for external consumers | Allowed |
| 3 | Change history / internal implementation details | Prohibited |
| 4 | Reference to past implementations | Prohibited |
| 6 | Local and important design decision | Allowed (carefully) |
| 6 | Minor decision / overall design | Prohibited |
| 7 | Task execution memo | Prohibited |
| 8 | Expressible through naming | Prohibited |
| 9 | Expressible through types | Prohibited |
| 10 | Common library practice | Prohibited |
| 11 | Units / magic numbers / hard-to-read values (difficult to name) | Allowed |
| 11 | Expressible through naming | Prohibited |
| 12 | Data format description difficult to express through types | Allowed |
| 12 | Self-evident from type name | Prohibited |
| 13 | Test: AAA / ASCII art / scenario description | Allowed |
| 13 | Test: Duplicates test name / self-evident from code | Prohibited |
| 14 | Unavoidable precondition explanation | Allowed |
| 14 | Expressible in code | Prohibited |
| 15 | Ordering constraint that appears swappable | Allowed |
| 15 | Order is self-evident | Prohibited |
| 16 | Multi-step process (immediately before each step) | Allowed |
| 16 | Far from processing / should extract into functions | Prohibited |
| 17 | Unavoidable hack / bug workaround | Allowed |
| 17 | Intentional error suppression | Allowed |
| 18 | Surprising behavior with high surprise factor | Allowed |
| 18 | Low surprise factor / addressable through naming | Prohibited |
| 19 | Intent explanation for unclear code | Allowed |
| 19 | Intent is self-evident / merely describes behavior | Prohibited |
| 20 | Uncategorized | Requires reporting |
