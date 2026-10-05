# System Design Code-Review Prompt Library

Quick-reference for reviewing code and architectural changes with an AI coding
agent using system-design principles from Alex Xu's System Design material.

The goal is to review not only whether a component works, but how it fits into
the larger system.

A normal review asks:

Does this code work?
Are there bugs?
Are there tests?

A system-design review also asks:

What requirement does this component serve?
What happens when traffic grows?
Where is state stored?
What is the read/write path?
What happens when a dependency fails?
Where are the bottlenecks?
What is cached?
What is asynchronous?
What consistency does the user actually need?
How would this system evolve without a rewrite?

System Design should complement, not replace, reviews for code correctness,
security, APOSD, DDIA, and data engineering.

---

## Index

| # | Prompt | Use it for |
|---|---|---|
| ★ | Compact daily | Default architectural review |
| 0 | Master review | Larger features or services |
| 1 | Understand the system | Reconstruct architecture first |
| 2 | Requirements | Functional + non-functional requirements |
| 3 | Data flow | Trace requests and state |
| 4 | API boundaries | Service contracts |
| 5 | Storage | Database and access-pattern fit |
| 6 | Scale | Bottlenecks and capacity |
| 7 | Cache | Cache usefulness and correctness |
| 8 | Async processing | Queues and background work |
| 9 | Reliability | Failure and recovery |
| 10 | Observability | Production operation |
| 11 | Evolution | Future changes and migration |
| A | AI-generated architecture | Detect unnecessary distributed complexity |

---

## ★ Compact daily system-design review prompt

Review this diff from a system-design perspective.

Focus on:

1. Functional behavior
2. Non-functional requirements
3. System boundaries
4. Request and data flow
5. API contracts
6. Storage and access patterns
7. Scaling and bottlenecks
8. Caching
9. Synchronous versus asynchronous work
10. Failure handling and recovery
11. Observability
12. Tests and operational readiness

For every finding provide:

- Evidence
- Concrete consequence
- Severity
- A realistic traffic, failure, or growth scenario
- Smallest reasonable improvement

Separate:

- Correctness issues
- Scalability risks
- Reliability risks
- Operational risks
- Optional improvements

Do not introduce distributed infrastructure unless the workload or reliability
requirements justify the added complexity.

---

## 0. Master System Design code-review prompt

Review this change using system-design principles.

Start with requirements and architecture before suggesting technologies.

Evaluate:

1. What user or system requirement the change serves.
2. Functional requirements.
3. Non-functional requirements such as latency, availability, throughput,
   durability, and consistency.
4. Major system components and their responsibilities.
5. Request flow through the system.
6. Data flow and state ownership.
7. API and service boundaries.
8. Database and storage choices.
9. Read and write access patterns.
10. Caching strategy.
11. Synchronous versus asynchronous processing.
12. Expected bottlenecks and scaling behavior.
13. Failure modes and recovery behavior.
14. Monitoring, metrics, logging, and operational readiness.
15. Whether the design can evolve without unnecessary rewrites.

For every finding:

- Cite the relevant file, service, API, schema, configuration, or component
- Explain the consequence
- Give a realistic workload or failure scenario
- Suggest the smallest reasonable improvement
- Mark it blocking, important, or optional

Clearly separate:

- Requirements
- Confirmed implementation behavior
- Assumptions
- Future scalability concerns

Do not design for hypothetical billions of users unless the requirements justify
it.

Prefer the simplest architecture that satisfies the current requirements while
leaving reasonable room for growth.

---

## 1. Understand the system first

Before reviewing this change, reconstruct the system around it.

Identify:

- User or client
- Entry point
- Services involved
- APIs involved
- Databases
- Caches
- Queues
- External dependencies
- Background workers
- Read path
- Write path
- State ownership
- Deployment boundaries

Then trace one representative request end to end.

Show:

Client
→ entry point
→ service
→ storage / dependency
→ response

For writes, also show any asynchronous or downstream processing.

Separate confirmed architecture from inference.

---

## 2. Review requirements

Identify the requirements implied by this change.

Functional requirements:

What must the system do?

Non-functional requirements:

- Expected traffic
- Read/write ratio
- Latency target
- Availability requirement
- Durability requirement
- Consistency requirement
- Data volume
- Growth rate
- Geographic distribution
- Security requirements

Flag architecture decisions that depend on requirements that are not actually
known.

Do not invent scale numbers.

When a requirement is missing, state which architectural decision depends on it.

---

## 3. Review the request and data flow

Trace the important flows introduced or modified by this change.

For each flow identify:

- Entry point
- Services called
- Network boundaries crossed
- Databases accessed
- Cache accesses
- External APIs
- Queue publication
- Background processing
- Response path

Look for:

- Excessive sequential network calls
- Fan-out
- Duplicate data fetching
- N+1 service calls
- Hidden synchronous dependencies
- Circular dependencies
- Multiple sources of truth
- Long request chains
- Unnecessary data movement

Explain the latency and failure impact of the full path rather than reviewing
each component in isolation.

---

## 4. Review API and service boundaries

Review the APIs or service boundaries affected by this change.

Check:

- Responsibility of each service
- Request and response contract
- Versioning
- Idempotency
- Pagination
- Error behavior
- Timeouts
- Retries
- Authentication
- Authorization
- Rate limiting
- Backward compatibility

Look for boundaries that expose internal implementation details or require
callers to understand too much about the service.

Identify places where two services appear to own the same responsibility.

Prefer clear ownership over unnecessary service fragmentation.

---

## 5. Review storage and access patterns

Review the storage design based on actual read and write patterns.

Identify:

- Data being stored
- System of record
- Read patterns
- Write patterns
- Query patterns
- Expected volume
- Growth pattern
- Required indexes
- Relationships
- Retention requirements

Then evaluate whether the storage model fits those requirements.

Look for:

- Full scans
- Hot records
- Unbounded rows or documents
- Expensive joins
- N+1 queries
- Poor partition keys
- Excessive write amplification
- Duplicate authoritative data
- Storage decisions based only on technology preference

Do not recommend SQL, NoSQL, sharding, or another datastore merely because it is
common in system-design interviews.

Tie the choice to the workload.

---

## 6. Review scale and bottlenecks

Analyze how the system behaves as workload grows.

Consider:

- Request rate
- Concurrent users
- Read/write ratio
- Data size
- Payload size
- Network traffic
- CPU
- Memory
- Database connections
- External API quotas
- Queue depth

Identify the first likely bottleneck.

Then evaluate behavior at:

Current scale
10× scale
100× scale

For every scaling concern explain:

What resource becomes constrained?
What symptom would appear?
How would we detect it?
What is the simplest mitigation?

Do not jump immediately to sharding, microservices, or distributed queues.

---

## 7. Review caching

Review any existing or proposed caching strategy.

Identify:

- What is cached
- Why it is cached
- Cache key
- TTL
- Invalidation strategy
- Source of truth
- Expected hit rate
- Stale-data tolerance
- Failure behavior

Look for:

- Cache-as-source-of-truth mistakes
- Missing invalidation
- Cache stampedes
- Hot keys
- Unbounded cache growth
- Incorrect tenant scoping
- Caching highly volatile data
- Added caching without evidence of a performance problem

Explain what user behavior occurs when cached data is stale.

Do not recommend caching merely because reads are frequent.

---

## 8. Review asynchronous processing

Identify work performed asynchronously or work that could reasonably move out
of the synchronous request path.

For each asynchronous flow identify:

- Producer
- Queue or broker
- Consumer
- Message contract
- Retry policy
- Failure behavior
- Ordering requirements
- Duplicate handling
- Dead-letter behavior

Evaluate whether asynchronous processing improves:

- User latency
- Resilience
- Throughput
- Decoupling

Also evaluate what complexity it adds.

Do not introduce a queue unless asynchronous behavior solves a concrete problem.

---

## 9. Review reliability and failure handling

Assume each dependency can fail independently.

For every important dependency ask:

What happens if it is slow?
What happens if it times out?
What happens if it returns an error?
What happens if it succeeds but the caller does not receive the response?
What happens if it becomes unavailable?

Review:

- Timeouts
- Retries
- Backoff
- Idempotency
- Circuit breaking where justified
- Fallbacks
- Partial failure
- Recovery
- Data reconciliation

Give concrete failure sequences.

Do not claim high availability merely because multiple services or replicas
exist.

---

## 10. Review observability and operation

Review whether this change can be understood in production.

Check for:

- Structured logs
- Metrics
- Error rates
- Latency metrics
- Throughput
- Queue depth
- Cache hit rate
- Database health
- Dependency failures
- Tracing
- Dashboards
- Alerts

For every important failure mode ask:

How would an engineer know this is happening?

Avoid adding observability that produces noise without an actionable signal.

---

## 11. Review evolution and future changes

Use likely future requirements to test the architecture.

Consider changes such as:

- 10× traffic
- New client
- New data field
- New query pattern
- Additional region
- New downstream consumer
- New authentication requirement
- New event consumer
- Storage migration

For each scenario identify which components would need to change.

Look for unnecessary change amplification or boundaries that make normal
evolution difficult.

Do not redesign the entire system for speculative future requirements.

Use future scenarios only to expose today's structural weaknesses.

---

## A. Review an AI-generated system design

Review this AI-generated architecture skeptically.

Look specifically for:

- Microservices with no clear boundary
- Queues with no asynchronous requirement
- Caches with no demonstrated bottleneck
- Multiple databases without a workload reason
- Premature sharding
- Event-driven architecture added only for sophistication
- Kubernetes or orchestration added without operational need
- Invented traffic numbers
- Claims of high availability without failure analysis
- Claims of exactly-once processing without proof
- Replication without a clear consistency model
- Technology choices made before requirements were defined

Start with:

Requirements
→ workload
→ constraints
→ simple architecture
→ bottleneck
→ justified improvement

Prefer the least complex architecture that satisfies the actual requirements.
