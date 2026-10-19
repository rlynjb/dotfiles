# Feature Requirements Refinement & Superpowers Handoff

A **standalone, pre-design feature investigation and requirements-refinement prompt** for both **new features** and **changes to existing features**. Start with an assigned ticket, product request, or feature idea; inspect the relevant codebase and supporting evidence when available; check whether the requested behavior matches what already exists; then clarify functional requirements, non-functional requirements, and unanswered questions **before** Superpowers designs and plans the implementation.

You do **not** need to run a separate "investigate new feature" or "investigate existing feature" prompt first.

**Core questions:** What is the ticket really asking for? What already exists or is known? Where do the request and existing behavior agree, differ, or leave gaps? Which decisions or historical details must be clarified with stakeholders or developers before handing the requirements to Superpowers?

**Workflow:** Ticket / idea + relevant repo evidence → **investigate alignment and refine requirements (this prompt)** → ask stakeholders/developers the necessary questions → pass the agreed requirements to **Superpowers** for design, implementation planning, and execution → [Code Review](code-review.md).

**Boundary:** Investigate **just enough existing behavior and history to validate requirements**. This is not a deep technical walkthrough, code review, architecture design, technology selection, or implementation plan. Superpowers owns those later steps.

---

## Index

| Prompt | Use it when |
| --- | --- |
| [Master feature requirements investigation](#0-master-feature-requirements-investigation-prompt) | You have an assigned ticket or idea and want codebase alignment, refined requirements, and questions for stakeholders or developers |
| [Compact ticket readiness check](#compact-ticket-readiness-check) | You need a fast requirements check before invoking Superpowers |
| [Five-book lens guide](#five-book-lens-guide) | You want the books to reveal requirement gaps without turning this into technical design |

---

## Five-book lens guide

Use the lenses **lightly** to identify missing business rules, observable behavior, or quality expectations. They are question generators, not mandatory technical analyses.

| Lens | Requirements-focused question (not a design task) |
| --- | --- |
| **APOSD — A Philosophy of Software Design** | Are user-visible concepts, responsibilities, boundaries, and rules clear? Is an important variation or exception missing from the ticket? |
| **AT — Algorithmic Thinking** | If the feature involves searching, ranking, matching, sorting, calculating, or reconciling, what observable output is correct? What ties, input limits, edge cases, or business rules need clarification? |
| **DDIA — Designing Data-Intensive Applications, 2nd edition** | What must users expect when data changes, is duplicated, stale, unavailable, edited concurrently, or recovered? Which information is authoritative, and what cannot be lost? |
| **FODE — Fundamentals of Data Engineering** | Where does required business data or an asset originate? Who owns its meaning and quality? How fresh must it be, and who consumes it? |
| **SDI — System Design Interview** | Who uses this feature? What functional and non-functional expectations, dependencies, scale assumptions, and product-level trade-offs matter? |

Mark irrelevant lenses **not applicable**. Combine overlapping insights; do not generate five separate technical reports or imply a book mandates any particular technology or architecture.

---

## 0. Master feature requirements investigation prompt

**What it does:** Starts from a **ticket or feature idea** (with or without existing code), checks relevant implementation evidence where it exists, refines what is expected, separates stakeholder decisions from developer/history questions, and creates a requirements handoff for Superpowers.

~~~text
Act as a feature requirements investigator and refinement partner.
Prepare the assigned ticket or feature idea for the Superpowers
design and implementation-planning workflow.

This is a STANDALONE prompt. Do not require a prior new-feature
or existing-feature investigation report. Use one if I supply it,
but begin from the ticket and available evidence otherwise.

INPUTS (use what is available; missing inputs are not blockers by
themselves)
- Feature / assigned ticket / product idea: [PASTE TEXT OR LINK]
- Repository / codebase / branch: [IF AVAILABLE]
- Product specs, designs, related tickets, previous implementations:
  [IF AVAILABLE]
- Known stakeholder decisions, constraints, and answered questions:
  [IF AVAILABLE]
- Specific uncertainty or concern: [OPTIONAL]

FIRST: IDENTIFY THE FEATURE CONTEXT
- Classify the request as: new capability, enhancement/change to an
  existing feature, new instance of an existing pattern, mixed, or unclear.
- A new feature MAY still need to fit existing conventions and data
  contracts. An existing feature MAY contain requested behavior already.
- If there is no relevant codebase or accessible evidence, perform
  conceptual requirements refinement and mark code alignment
  NOT VERIFIED or NOT APPLICABLE. Do not invent implementation evidence.
- Do not force separate workflows: adapt the depth of investigation
  to the actual ticket.

WORKING RULES
- Prioritize WHAT users/business need and HOW WELL it must work.
  Superpowers will own technical design, architecture, technology
  selection, algorithms, detailed plans, and coding.
- Inspect only relevant documentation, entry points, neighboring
  features, business rules, tests, contracts, and available history
  necessary to check the ticket. Do not exhaustively map the system.
- Stay read-only. Do not edit code, generate an implementation plan,
  execute Superpowers, make commits, deploy, or call write APIs.
- Cite meaningful claims with ticket/spec references, paths and
  symbols, tests, PRs, or commits you actually inspected. If access
  is unavailable, say what remains unverified.
- SEPARATE:
    CONFIRMED REQUIREMENT — explicitly established by the ticket,
      approved spec, or stakeholder decision (cite its source).
    OBSERVED BEHAVIOR — verified in current code/tests; this is NOT
      automatically an approved product requirement.
    PROPOSED — candidate behavior or clarification to validate.
    ASSUMED — explicit temporary hypothesis, not a decision.
    UNKNOWN — not established by available evidence.
- Preserve the business terminology; flag conflicts rather than
  silently reconciling them. Never treat code or past implementation
  as proof of stakeholder intent or a historical design decision.
- Never fabricate historical reasons, stakeholder approvals, priorities,
  SLAs, numbers, integrations, or constraints. Do not present a
  suspected bottleneck or best practice as a requirement.
- Prefer concrete, high-impact unanswered questions over long lists.
  Keep technical findings brief and tied to requirement implications.

1. CLARIFY THE PRODUCT REQUEST AND SCOPE
- Who needs the feature, which task/problem does it address, and what
  outcome counts as success?
- What is intended to be added, changed, preserved, reused, or removed?
- What is explicitly in scope, out of scope, and still undecided?
- Identify the ticket's assumptions, contradictions, missing actors,
  dependencies, permissions, and vague terms.

2. CHECK TICKET-TO-CODEBASE ALIGNMENT (WHEN CODE EXISTS)
- Trace the smallest relevant user-facing path: entry or screen,
  observable behavior, key business rules, state/data inputs and
  outputs, relevant configuration, and tests/contracts.
- Look for related features, earlier instances, and established
  conventions that constrain or clarify the requirement. Inspect
  pertinent docs, tickets, PRs, or git history IF available and useful.
- Distinguish WHAT THE SYSTEM DOES NOW from WHAT THE TICKET ASKS FOR.
  Identify any implied change in behavior or compatibility.
- Produce an alignment table for significant requested behaviors:
    Ticket requirement / acceptance expectation
    Ticket or spec evidence
    Current implementation evidence (file/symbol/test) or not observed
    Status: ALREADY PRESENT / PARTIAL / MISSING / CONFLICT /
            NOT VERIFIED / NOT APPLICABLE
    Requirement implication, risk, or needed clarification
- Do not label a behavior MISSING merely because a search did not
  find it; if coverage is incomplete, use NOT VERIFIED.
- If the ticket references an older design or copied feature,
  distinguish reusable established behavior from instance-specific
  inputs, permissions, or business rules.
- When implementation history is unclear, list the exact factual
  question an involved developer could answer. Do NOT speculate
  about why previous developers made a decision.
- No deep call graphs, exhaustive architectural analysis, refactor
  recommendations, query tuning, or implementation strategy.

3. REFINE THE USER JOURNEYS
- State the normal user journey: actor -> trigger -> expected action ->
  observable outcome.
- Add only material alternative, permission, empty-data, invalid-input,
  repeated-action, failure, and recovery cases.
- Show where the ticket is ambiguous and different interpretations
  would change user behavior or acceptance.
- For existing features, explicitly distinguish current user behavior
  from requested user behavior.

4. REFINE FUNCTIONAL REQUIREMENTS (FR)
For each material requirement include:
- FR-ID, observable user/system behavior, actor/trigger, expected result.
- Must / Should / Could / Out of scope (mark proposed priorities).
- CONFIRMED REQUIREMENT / PROPOSED / ASSUMED / UNKNOWN.
- Source/ticket reference, relationship to existing behavior (if any),
  and linked open question.
- A short Given / When / Then acceptance example for the important
  happy path, business rules, and error cases.

Flag duplicate, conflicting, vague, missing, or untestable statements.
Do not promote what exists in code into a new requirement without
ticket or stakeholder support.

5. REFINE NON-FUNCTIONAL REQUIREMENTS (NFR)
For each relevant expectation include:
- NFR-ID, user/business impact, linked journey or FR, desired quality,
  proposed verification/acceptance method, priority and status.
- If no target is provided, write "target requires confirmation".
- Consider relevant latency/performance, reliability/availability,
  consistency/freshness, durability/recovery, security/privacy,
  accessibility, supported clients, scale, usability, operating
  constraints, and costs. Skip irrelevant categories.
- Compare an existing verified expectation or constraint with any
  new or conflicting expectation in the ticket.
- Identify product-level choices (e.g., can users tolerate stale
  information?) without designing the system to satisfy them.
- Never invent specific thresholds, compliance duties, or SLAs.

6. CHECK CONSTRAINTS, DEPENDENCIES, AND ACCEPTANCE
- Separate hard constraints, preferences, unverified assumptions,
  and freedom intentionally left to Superpowers.
- Identify any prerequisite business data, assets, team decisions,
  access/approval, external system, or previous behavior that must
  remain compatible, if evidence supports it.
- Confirm each Must requirement has an observable acceptance condition.
- Identify conflicts between FRs, NFRs, ticket wording, and current
  behavior without making a product decision on anyone's behalf.

7. FIVE-BOOK REQUIREMENTS CHECK (LIGHTWEIGHT)
Apply APOSD, AT, DDIA (2nd edition), FODE, and System Design
Interview (SDI) only when they expose a material missing business
rule, acceptance condition, constraint, or quality expectation.
For each applicable lens give at most 1-2 useful questions linked
to an FR, NFR, scenario, or scope decision. Mark irrelevant lenses
NOT APPLICABLE. Consolidate overlap.

Do not produce system diagrams, technical design alternatives,
schema proposals, algorithm analysis, or performance optimization.

8. ROUTE UNANSWERED QUESTIONS TO THE RIGHT PEOPLE
Prioritize unanswered questions in these groups:

A. STAKEHOLDERS / PRODUCT OWNER — business intent, scope,
   expected user behavior, acceptance criteria, priorities, quality
   targets, policy, or externally owned input. Blocking when the
   answer changes material requirements or design assumptions.

B. DEVELOPERS / FEATURE HISTORY — what the system already does,
   undocumented rules, previous tickets/PRs, legacy constraints,
   external setup, existing tests, or why an earlier behavior was
   introduced (ask; don't invent the historical answer). Only
   block handoff when that fact is necessary to define valid
   requirements or avoid a material compatibility error.

C. SUPERPOWERS DESIGN QUESTIONS — architecture, libraries,
   module organization, query/index design, implementation tasks,
   engineering trade-offs. Preserve these for Superpowers rather
   than presenting them as stakeholder blockers.

D. DEFER / NICE TO KNOW — questions unlikely to alter scope or
   meaningful acceptance behavior. Avoid distracting outreach.

For each outreach question (A or B), provide:
- ID (Q-01 ...), priority, owner/role (or owner to identify).
- Exact concise question ready to send.
- Why it matters; linked FR, NFR, journey, or code/ticket conflict.
- Answer options and consequences only when useful; do not imply
  an option has been approved.
- Evidence or source of uncertainty.
- BLOCKS HANDOFF? YES / NO, with a short reason.

Separate product decisions from factual questions about existing
behavior. Developers may explain history, but cannot approve
product scope just because they know the code.
Provide TWO short ready-to-send messages only when needed:
one for stakeholders, one for involved developers. Include the
highest-impact unanswered questions; omit resolved questions.

9. CREATE A SUPERPOWERS REQUIREMENTS HANDOFF
Produce a concise requirements brief containing:
- Feature context (new / change / reuse), product problem, user,
  expected outcome, and in-scope/out-of-scope boundaries.
- Confirmed FRs, relevant NFRs, and observable acceptance criteria.
- Required compatibility with existing behavior or contracts,
  supported by evidence; distinguish unknown compatibility risks.
- Hard constraints, prerequisites, dependencies, and verified targets.
- Approved decisions and named provisional assumptions, with sources.
- Remaining stakeholder/developer questions and their owners.
- Engineering topics deliberately handed to Superpowers, without
  attempting to solve them here.

Give one readiness verdict:
- READY — material requirements/acceptance are sufficiently clear;
  no blocking product or historical/compatibility decisions remain.
- CONDITIONAL — named non-blocking assumptions remain, with owners
  and explicit conditions that would require revisiting the brief.
- BLOCKED — a critical product decision or necessary existing-system
  fact remains unknown; identify the MINIMUM answers required.

If blocked, still produce a useful provisional handoff but do NOT
present it as agreed or implementation-ready. Do not let Superpowers
invent business answers. Mark open questions that require approval
before execution even if design exploration can start.

REQUIRED OUTPUT (keep concise; omit inapplicable detail)
1. Product/ticket summary and in/out-of-scope boundaries.
2. Ticket-to-codebase alignment table (or explain N/A/not verified).
3. User journeys and key acceptance scenarios.
4. Refined functional requirements (FR table).
5. Refined non-functional requirements (NFR table).
6. Constraints, dependencies, and compatibility concerns.
7. Material five-book requirement questions (if applicable).
8. Prioritized questions BY OWNER, plus stakeholder/developer
   ready-to-send messages where useful.
9. Superpowers handoff brief and READY / CONDITIONAL / BLOCKED verdict.

Do not repeat the full ticket, existing code, or history. Finish
with the most consequential unanswered question, if one exists.
~~~

---

## Compact ticket readiness check

**Use when:** An assigned ticket looks small or straightforward and you want to validate requirements and fit against the relevant existing code before Superpowers takes over.

~~~text
Review this ticket or feature idea and relevant codebase as a
STANDALONE requirements check before I use Superpowers for design
and implementation planning.

Input: [TICKET / FEATURE REQUEST, REPOSITORY IF AVAILABLE, KNOWN
DECISIONS, LINKS OR REFERENCE FILES]

This may be a NEW feature or a CHANGE to an existing one. Inspect
only enough related code/docs/tests/history to verify observable
current behavior and constraints; do not require an earlier
investigation or perform deep technical analysis.

Give me:
1. Product goal, users, what changes, and in/out of scope.
2. Ticket-to-existing-code alignment: already present, partial,
   missing, conflicting, or not verified, with concise evidence.
3. Functional requirements with key acceptance examples.
4. Relevant non-functional requirements and targets needing approval.
5. Material assumptions, dependencies, and compatibility risks.
6. Separate unanswered questions for (a) stakeholders/product
   decisions and (b) developers/existing-feature history; identify
   owners, blockers, and concise ready-to-send questions.
7. Brief APOSD, AT, DDIA (2nd edition), FODE, and SDI questions ONLY
   where these uncover a requirements gap.
8. A product-focused Superpowers handoff plus a verdict:
   READY / CONDITIONAL / BLOCKED, and what is needed next.

Distinguish CONFIRMED REQUIREMENTS from OBSERVED CODE BEHAVIOR,
proposals, assumptions, and unknowns. Cite what you inspect.
Leave technical architecture and implementation planning to
Superpowers. Work read-only.
~~~

---

## How this fits the engineering workflow

| Stage | Responsibility |
| --- | --- |
| Assigned ticket / new idea / change to existing feature | Input to this prompt, with whatever source material exists |
| **Requirements investigation and refinement (this file)** | Compare ticket with relevant code where possible; clarify behavior, FRs/NFRs, constraints, stakeholder/developer questions |
| Confirm unanswered product and history questions | Obtain decisions or factual context from the appropriate people; update the requirements brief |
| Design, implementation plan, execution | **Superpowers**, using confirmed requirements and explicitly noted assumptions |
| Review implemented changes | [Code Review](code-review.md) |

**Use this file directly for both new and existing features.** No separate investigation prompt is required. Use the compact check for small tickets, the master for ambiguous or consequential work. The goal is to establish *what to build and what to ask*, then hand off the technical choices to Superpowers.
