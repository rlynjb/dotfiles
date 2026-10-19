# Feature Requirements Refinement & Superpowers Handoff

A reusable **post-investigation, pre-design** prompt. Use it after [New Feature Discovery](investigate-new-feature.md), [Existing Feature Investigation](investigate-existing-feature.md), or reviewing a ticket/spec with an AI agent. Its job is to **clarify product requirements, identify stakeholder decisions, and decide whether requirements are ready for Superpowers** to design and plan implementation.

**Core question:** Do we agree on what the feature must do, how well it must work, what is in or out of scope, and which unanswered questions could change the solution?

**Workflow:** Investigate the feature → refine and validate requirements (this prompt) → obtain stakeholder answers if needed → give the agreed requirements to Superpowers for brainstorming/design, implementation planning, and execution → [Code Review](code-review.md).

**Boundary:** This is a requirements-quality gate, **not** another feature investigation, technical design, system architecture review, implementation plan, or code review. Reuse investigation findings instead of repeating the investigation.

---

## Index

| Prompt | Use it when |
| --- | --- |
| [Master requirements refinement](#0-master-requirements-refinement-prompt) | You need a full requirements review and stakeholder-question list before Superpowers |
| [Compact readiness check](#compact-requirements-readiness-check) | You need a quick pass after a small investigation |
| [Five-book lens guide](#five-book-lens-guide) | You want to understand what each book contributes without getting technical |

---

## Five-book lens guide

Apply the lenses **lightly**, only to reveal missing user/business requirements or important quality expectations. They are question generators, not mandatory architecture sections.

| Lens | Requirements-focused question (not a design task) |
| --- | --- |
| **APOSD — A Philosophy of Software Design** | Are the user-visible concepts, responsibilities, boundaries, and rules simple and unambiguous? Which variation must the product support without exposing unnecessary complexity to users? |
| **AT — Algorithmic Thinking** | If the feature must search, rank, match, sort, calculate, or reconcile, what observable result counts as correct? What input limits, ties, edge cases, or business rules need clarification? |
| **DDIA — Designing Data-Intensive Applications, 2nd edition** | What does the user expect when data changes, is duplicated, stale, unavailable, edited concurrently, or recovered? Which data is authoritative and what must not be lost? |
| **FODE — Fundamentals of Data Engineering** | Where must business data or assets come from, who owns their quality and meaning, how fresh must they be, and which downstream consumers rely on them? |
| **SDI — System Design Interview** | Who uses this feature, what are its functional and non-functional needs, expected scale, integration constraints, and acceptable product-level trade-offs? |

Mark irrelevant lenses **not applicable**. Combine overlapping questions; do not generate five separate technical reports. Never assert a book requires a specific design.

---

## 0. Master requirements refinement prompt

**What it does:** Converts an investigation or rough requirement set into a clear, evidence-labeled, stakeholder-ready requirements baseline and a handoff for Superpowers. The most important output is **what still requires a decision**, by whom, and whether it blocks design.

~~~text
Act as a requirements refinement partner preparing a feature for the
Superpowers design and implementation-planning workflow.

I have already investigated this feature, or I am providing the best
information currently available. Your job is NOT to investigate the
implementation all over again. Read the information I provide first.

INPUTS
- Feature or ticket: [PASTE REQUEST / LINK / DESCRIPTION]
- Investigation findings: [PASTE INVESTIGATION REPORT OR FILES]
- Existing behavior / examples: [IF RELEVANT]
- Stakeholder statements and agreed decisions: [IF AVAILABLE]
- Constraints, deadlines, policies, dependencies: [IF KNOWN]
- Questions already answered: [IF ANY]

If sources are accessible, cite relevant tickets, docs, files/symbols,
or direct stakeholder statements. Inspect only enough additional context
to resolve a material requirements ambiguity. If something is not
accessible, state the limitation. Do not pretend to have verified it.

WORKING RULES
- Prioritize WHAT users/business need and HOW WELL it must work, not HOW
  it will be engineered. Leave architecture, technology selection,
  algorithms, component design, task breakdown, and coding to Superpowers.
- Distinguish CURRENT IMPLEMENTATION from DESIRED BEHAVIOR: evidence of
  what code does today is not proof that stakeholders want it tomorrow.
- Preserve the stakeholder's terminology. Flag contradictory language
  or behavior rather than silently resolving it.
- Label material items:
    CONFIRMED — explicitly agreed or directly supported by a source;
                identify whether it is an approved requirement or only
                observed existing behavior.
    PROPOSED — a candidate requirement or recommended clarification.
    ASSUMED — a temporary assumption made visible for discussion.
    UNKNOWN — insufficient evidence to determine the answer.
- Do not invent stakeholder approvals, priorities, SLAs, targets,
  regulatory obligations, integrations, user volumes, or constraints.
- Keep this read-only. Do not edit application code, create an
  implementation plan, commit changes, deploy, or run Superpowers.
- Don't turn generic best practices into mandatory requirements.
  Include a concern only if it affects this feature.
- Write plainly and concisely. Prefer a few decisive questions over
  a long speculative checklist.

1. RESTATE THE PRODUCT OUTCOME AND SCOPE
- Who is the primary actor, what problem are they solving, and what
  observable outcome means the feature is useful?
- What behavior is being introduced, changed, kept, or removed?
- Separate confirmed in-scope work, proposed scope, explicit exclusions,
  and scope decisions still pending.
- State dependencies on other teams, business processes, permissions,
  external data/assets, or customer actions only when supported.

2. REFINE THE USER JOURNEYS
- Give the principal happy path in plain language: actor → trigger →
  expected behavior → observable outcome.
- Add only meaningful alternative, permission, empty-data, invalid-input,
  error, failure, recovery, or repeated-action scenarios.
- Point out places where two reasonable interpretations lead to
  different behavior. Turn these into questions, not silent choices.
- Avoid describing controllers, databases, services, or code flows.

3. REFINE FUNCTIONAL REQUIREMENTS (FR)
Produce concise, individually testable requirements. For each include:
- FR-ID; user/system behavior; actor or trigger; observable result;
  Must / Should / Could / Out of scope; CONFIRMED / PROPOSED /
  ASSUMED / UNKNOWN; source or rationale; linked open question.
- Give a short Given / When / Then acceptance example for important
  requirements, especially business rules and error scenarios.
- Clarify relevant permissions, state changes, boundaries, and exceptions.
- Identify overlapping, conflicting, vague, untestable, or missing
  requirements. Do not manufacture requirements to fill a template.

4. REFINE NON-FUNCTIONAL REQUIREMENTS (NFR)
For each relevant quality expectation, capture:
- NFR-ID; user/business consequence; associated feature or journey;
  expected quality/constraint; acceptance or measurement method;
  confirmed target OR "target requires stakeholder confirmation";
  priority, status, and possible decision owner.
- Consider only relevant performance, availability, reliability,
  consistency/freshness, durability, security/privacy, accessibility,
  supported platforms, usability, scale, operational needs, and cost.
- Translate vague words such as "fast", "real-time", "secure", or
  "reliable" into what a stakeholder must define. Do not invent numbers.
- Explain any product-level trade-off that stakeholders must choose
  (for example: more immediate updates vs accepting temporary staleness).
  Do not propose infrastructure to resolve the trade-off.

5. CHECK CONSTRAINTS, DEPENDENCIES, AND ACCEPTANCE
- Separate hard constraints, preferences, assumptions, and choices
  the design stage can make freely.
- Record scope exclusions and external approvals, data/assets, roles,
  or policies required before the feature can work as intended.
- Check that each Must requirement has an observable acceptance condition.
- Highlight conflicts between FRs and NFRs (such as offline behavior
  versus freshness) without making unapproved compromises.

6. USE THE FIVE BOOK LENSES AS A LIGHT REQUIREMENTS CHECK
Use APOSD, AT, DDIA (2nd edition), FODE, and System Design Interview
(SDI) only to expose material missing rules or quality expectations.
For each applicable lens, give at most 1–2 important QUESTIONS and
link each to an FR, NFR, user journey, or constraint. Mark irrelevant
lenses not applicable. Consolidate duplicates.

Do not produce architecture diagrams, schema proposals, algorithm
analysis, performance tuning, or a technical solution comparison.

7. PRIORITIZE OPEN QUESTIONS FOR STAKEHOLDERS
Separate:
A. BLOCKING PRODUCT DECISIONS — answers could change scope, expected
   behavior, acceptance, or a critical NFR; resolve before Superpowers.
B. NON-BLOCKING CLARIFICATIONS — can be made explicit assumptions,
   if the responsible person agrees, and revisited later.
C. ENGINEERING/DESIGN QUESTIONS — leave for Superpowers; do not send
   these to stakeholders unless they require a product decision.
D. NICE-TO-KNOW — optional; avoid cluttering outreach.

For each stakeholder-facing question, give:
- Priority and ID (Q-01, ...).
- The EXACT concise question I can send.
- Why it matters; which requirement or journey it affects.
- If useful, two plausible answer choices and how they change scope
  or expected behavior (do not assume either answer is approved).
- Who should decide, if known; otherwise "owner to identify".
- Whether it BLOCKS the Superpowers handoff.
- Source of uncertainty and any proposed temporary assumption.

Do not ask stakeholders to choose technical implementation details.
Group duplicate questions and put the highest-impact ones first.
Provide a short stakeholder-ready message containing only blocking
questions when there are any.

8. PREPARE THE SUPERPOWERS HANDOFF
Produce a clean, product-focused brief Superpowers can consume:
- Problem, users, desired outcomes, and success definition.
- In-scope / out-of-scope and priority boundaries.
- Confirmed FRs with observable acceptance conditions.
- Relevant NFRs and verified targets; clearly mark unknown targets.
- Hard constraints, dependencies, and required external inputs.
- Product decisions already made, with evidence.
- Explicit provisional assumptions and unresolved questions.

Give a readiness verdict:
- READY — no material product decisions remain unresolved.
- CONDITIONAL — only named, non-blocking assumptions remain; name
  their owners and what would invalidate the handoff.
- BLOCKED — material stakeholder decisions prevent a trustworthy
  design; identify the minimum answers required to unblock it.

If BLOCKED, still produce a useful provisional brief but do not
present it as approved or ready for implementation. Do not ask
Superpowers to invent answers to product questions.

REQUIRED OUTPUT (use these sections; be concise)
1. Product outcome and scope
2. Key user journeys and acceptance scenarios
3. Functional requirements (FR table)
4. Non-functional requirements (NFR table)
5. Constraints, dependencies, and exclusions
6. Five-book requirement blind spots (only where relevant)
7. Prioritized stakeholder questions and ready-to-send message
8. Superpowers handoff brief and READY / CONDITIONAL / BLOCKED verdict

Do not repeat the original investigation report or create an
implementation/design document. End by identifying the single
most consequential unanswered product question, if one exists.
~~~

---

## Compact requirements readiness check

**Use when:** You already have a small, reasonably clear investigation and just need to know what to confirm before invoking Superpowers.

~~~text
Review this feature investigation or ticket as a requirements-readiness
checkpoint before I use Superpowers for design and implementation planning.

Input: [PASTE FEATURE REQUEST + INVESTIGATION / EXISTING DECISIONS]

Do NOT perform technical design, choose libraries or architecture, create
implementation tasks, or repeat a deep code investigation.

Give me:
1. The product goal and what is in/out of scope.
2. A short list of observable functional requirements and key user
   journeys, with acceptance examples for critical behavior.
3. Relevant non-functional requirements; flag vague or unconfirmed
   targets instead of inventing them.
4. Conflicting or missing business rules, dependencies, and assumptions.
5. A prioritized list of stakeholder questions: what to ask, why,
   decision owner if known, and whether it blocks design.
6. One-line insights from relevant APOSD, AT, DDIA (2nd edition),
   FODE, and SDI lenses ONLY if they uncover a requirements gap.
7. A concise handoff brief for Superpowers and a verdict:
   READY / CONDITIONAL / BLOCKED, with reasons.

Distinguish confirmed requirements from proposed or assumed ones.
Cite supplied evidence. Leave technical design to Superpowers.
~~~

---

## Relationship to other prompts

| Stage | Use |
| --- | --- |
| New idea / unclear user needs | [Investigate New Feature](investigate-new-feature.md) — discover journeys, candidate requirements, possible approaches |
| Existing implementation / analogous feature | [Investigate Existing Feature](investigate-existing-feature.md) — verify behavior, dependencies, resource origins |
| **After investigation, before design** | **Requirements Refinement & Superpowers Handoff** (this file) — close gaps, prepare stakeholder questions, make readiness decision |
| Technical design, implementation plan, execution | **Superpowers** — use the confirmed requirements and explicitly noted assumptions |
| Post-implementation evaluation | [Code Review](code-review.md) — evaluate implemented behavior and engineering trade-offs |

**Do not run every master prompt automatically.** If an investigation already gives sufficient clarity, use the compact readiness check. The goal is a sound decision about *what to build*, not a second technical investigation.
