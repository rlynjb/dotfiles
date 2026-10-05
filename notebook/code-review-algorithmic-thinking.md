# Algorithmic Thinking Code-Review Prompt Library

Quick-reference for reviewing code with an AI coding agent using principles from
*Algorithmic Thinking* by Daniel Zingaro.

The goal is not just to ask whether the code works.

A normal review asks:

Does this code work?
Are there bugs?
Are there tests?

An Algorithmic Thinking review also asks:

What problem is this code actually solving?
What are the input constraints?
What information matters and what can be ignored?
Is the chosen algorithm appropriate?
Is there a simpler representation or data structure?
Why is the algorithm correct?
What happens at the boundaries?
How does runtime and memory grow with input size?

Use this review primarily for algorithms, functions, data-processing logic,
DSA-heavy code, transformations, search, traversal, optimization, and
performance-sensitive logic.

It complements architecture-level reviews such as DDIA and System Design.

---

## Index

| # | Prompt | Use it for |
|---|---|---|
| ★ | Compact daily | Normal algorithmic code review |
| 0 | Master review | Larger or higher-risk changes |
| 1 | Understand the problem | Before reviewing implementation |
| 2 | Correctness | Bugs and counterexamples |
| 3 | Algorithm choice | Is the approach appropriate? |
| 4 | Data structures | Representation and operations |
| 5 | Complexity | Time and space analysis |
| 6 | Invariants | Why does the algorithm work? |
| 7 | Edge cases | Boundaries and unusual input |
| 8 | Pattern recognition | Identify reusable problem patterns |
| 9 | Tests | Evidence that the algorithm is correct |
| A | AI-generated solution | Detect plausible-looking but wrong solutions |

---

## ★ Compact daily code-review prompt

Review this diff using principles from Algorithmic Thinking.

Focus on:

1. What problem the code is solving
2. Input, output, and constraints
3. Behavioral correctness
4. Algorithm choice
5. Data-structure choice
6. Important invariants
7. Boundary and edge cases
8. Time complexity
9. Space complexity
10. Test quality

For every finding provide:

- Evidence from the code
- Concrete consequence
- Severity
- A specific input or scenario demonstrating the problem
- Smallest reasonable improvement

Separate:

- Correctness issues
- Performance issues
- Maintainability issues
- Optional improvements

Do not recommend a more complicated algorithm unless the input constraints or
performance requirements justify it.

Do not claim an optimization is necessary without explaining the workload at
which the current approach becomes a problem.

---

## 0. Master Algorithmic Thinking code-review prompt

Review this change using principles from Algorithmic Thinking.

First understand the problem before criticizing the implementation.

Evaluate:

1. What problem is being solved?
2. What are the expected inputs and outputs?
3. What assumptions are made about the input?
4. What constraints affect the solution?
5. What is the simplest correct solution?
6. What algorithmic approach does the implementation use?
7. Why should that algorithm produce the correct result?
8. What data structures are used and why?
9. Are the data structures appropriate for the operations performed?
10. What invariants must remain true during execution?
11. What boundary cases or unusual inputs could break the implementation?
12. What is the time complexity?
13. What is the space complexity?
14. Where are repeated or unnecessary operations performed?
15. Do the tests prove correctness across important input classes?

For every finding:

- Cite the file and symbol
- Explain the algorithmic issue
- Give a concrete input that demonstrates it
- Explain the expected and actual behavior
- Suggest the smallest reasonable improvement
- Mark it blocking, important, or optional

Clearly separate:

- Proven behavior
- Assumptions
- Complexity analysis
- Potential optimization

Do not optimize code purely because a theoretically faster algorithm exists.

Prefer the simplest solution that satisfies the actual constraints.

---

## 1. Understand the problem first

Before reviewing the implementation, reconstruct the problem it is trying to
solve.

Identify:

- Inputs
- Outputs
- Input constraints
- Valid and invalid input
- Required behavior
- Important edge cases
- Performance requirements
- Ordering requirements
- Duplicate handling
- Empty-input behavior
- Expected data size
- Important invariants

Then summarize the problem in plain English.

Separate what is confirmed by the code or tests from what you inferred.

Do not review algorithm choice until the problem and constraints are clear.

---

## 2. Review algorithmic correctness

Review this implementation for algorithmic correctness.

Look for:

- Incorrect assumptions
- Missing cases
- Off-by-one errors
- Incorrect loop boundaries
- Incorrect termination conditions
- State that is not updated correctly
- Incorrect comparisons
- Duplicate handling
- Incorrect ordering assumptions
- Empty collections
- Single-element inputs
- Minimum and maximum values
- Cycles
- Repeated values
- Negative values where relevant
- Overflow or precision problems
- Mutation that affects later computation

For each issue, give the smallest concrete input that demonstrates the failure.

Show:

Input
Expected result
Actual or likely result
Reason the algorithm fails

---

## 3. Review the algorithm choice

Identify the algorithmic strategy used by this code.

Examples may include:

- Brute force
- Sorting
- Hashing
- Two pointers
- Sliding window
- Binary search
- Recursion
- Divide and conquer
- Greedy
- Dynamic programming
- BFS
- DFS
- Graph traversal
- Heap / priority queue
- Prefix sums
- Interval processing

Then evaluate:

- Why this approach fits the problem
- What assumptions make it valid
- Whether a simpler approach would work
- Whether performance requirements justify the complexity
- Whether another pattern would substantially improve clarity or performance

Compare alternatives only when meaningful.

For each alternative provide:

Current complexity
Alternative complexity
Trade-off
Input size where the difference starts to matter

Do not recommend cleverness for its own sake.

---

## 4. Review data-structure choice

Review the data structures used by this implementation.

For each important structure identify:

- What information it represents
- Operations performed on it
- Lookup frequency
- Insert frequency
- Delete frequency
- Ordering requirements
- Duplicate requirements
- Memory cost

Evaluate whether the structure matches those operations.

Consider:

- Array / list
- Set
- Hash map
- Stack
- Queue
- Deque
- Heap
- Tree
- Graph
- Linked structure

Look for cases where the code repeatedly performs an expensive operation that
a different representation could make cheap.

Do not suggest replacing a simple structure unless there is a meaningful
correctness, clarity, or performance benefit.

---

## 5. Review time and space complexity

Analyze the important execution paths.

For each one provide:

Time complexity
Space complexity
Dominant operation
Relevant input variable

Do not stop at Big-O notation.

Also identify:

- Nested loops
- Repeated scans
- Repeated sorting
- Repeated allocation
- Hidden library complexity
- Recursive depth
- Expensive work inside loops
- Repeated database or network operations if relevant

Then answer:

What happens at 10× input size?
What happens at 100× input size?

Distinguish theoretical complexity from a realistic performance concern.

---

## 6. Identify the algorithm's invariants

Determine what must remain true while this algorithm executes.

Examples:

- Everything before index i has already been processed
- The queue contains exactly the nodes discovered but not visited
- The current window satisfies a particular constraint
- The heap contains the best k candidates seen so far
- dp[i] represents the optimal answer for a defined subproblem

For every important invariant:

- State it clearly
- Show where it is established
- Show where it is preserved
- Show how it leads to the final result

Flag any code path that can violate the invariant.

Use this to explain why the algorithm is correct, not merely that the tests pass.

---

## 7. Review edge cases and boundaries

Generate adversarial inputs for this implementation.

Include relevant cases such as:

- Empty input
- One element
- Two elements
- All values equal
- Already sorted
- Reverse sorted
- Maximum size
- Minimum values
- Maximum values
- Duplicate values
- Missing values
- Negative values
- Cyclic input
- Disconnected structures
- Deep recursion
- Highly skewed input

For each meaningful case state whether the implementation handles it correctly.

Prioritize cases that exercise different branches or invalidate assumptions.

---

## 8. Identify the problem-solving pattern

Analyze this code as a learning exercise.

Identify:

Problem type
Important clues
Relevant constraints
Algorithmic pattern
Data structure
Invariant
Complexity

Then explain:

What clues should make an engineer recognize this pattern in a future problem?

What similar-looking problems would NOT use this pattern?

What question should I ask myself next time when I see this type of problem?

Keep the explanation practical rather than turning it into a list of algorithms
to memorize.

---

## 9. Review tests as algorithmic evidence

Review the tests for this implementation.

Determine whether they cover:

- Normal input
- Empty input
- Smallest valid input
- Boundary conditions
- Duplicates
- Ordering differences
- Maximum or large input
- Important algorithm branches
- Previously failing cases
- Invariants
- Performance-sensitive input

Identify cases where tests pass but the algorithm could still be incorrect.

Recommend the smallest set of additional tests that gives meaningful confidence.

---

## A. Review an AI-generated algorithmic solution

Review this AI-generated implementation skeptically.

Do not assume that because the code looks plausible it is correct.

Check specifically for:

- Pattern matching to the wrong algorithm
- Unstated assumptions
- Invented constraints
- Incorrect complexity claims
- Off-by-one errors
- Missing edge cases
- Incorrect mutation
- Incorrect recursion base cases
- Data structures chosen because they are common rather than necessary
- Optimization before correctness
- Tests that only cover examples from the prompt

Require a concrete correctness argument and counterexample search before
accepting the solution.

If the current simple solution is already sufficient, do not recommend a more
complex one.
