# Ecommerce Order and Fulfillment Service

Built a Spring Boot application service for inventory reservations and fulfillment transitions. Added request-key deduplication, expected-version checks and retryable outbox fixtures. Tested concurrent stock requests, repeated cancellation and relay failures with JUnit using local synthetic state.

## Run locally

Start from the `java/` directory of this repository.

```sh
mvn spring-boot:run -Dspring-boot.run.arguments="--demo.config=ecommerce-order-and-fulfillment-service-java/project.json"
```

The browser console is available at `http://127.0.0.1:8000` for API applications. For frontend applications, use the frontend development server described in the setup below.

## Architecture

```mermaid
flowchart LR
    Client[Browser or API client] --> API[Validated API]
    API --> Rules[Business rules]
    Rules --> State[Application state]
    Rules --> Audit[Audit history]
```

## Workflow

Available actions: `reserve`, `cancel`, `ship`, `refund`, `relay`.

Open `project.json` for the available commands and example inputs when present. Use the operator role to inspect state and audit history. Retry an accepted command with the same identifier to observe replay behavior; change its payload or expected version to exercise conflict handling.

## Verification

Run the automated checks from the stack directory:

```sh
mvn test
```

The checks exercise business rules, permission boundaries and failure recovery. Sample records are synthetic. Development credentials are local examples; use managed identity, external secrets and your own deployment controls before exposing services publicly.

## Implementation notes

# Ecommerce Order and Fulfillment Service

Reserve against an expected stock version. Repeated keys return the same order; conflicting payloads are rejected. Operator actions ship, cancel or refund, with a retryable event outbox.

## Purpose

Reserve against an expected stock version. Repeated keys return the same order; conflicting payloads are rejected. Operator actions ship, cancel or refund, with a retryable event outbox.

## Run

See the family-level README one directory above for the installed runtime and command. Use this folder's `project.json` to select this application.

## Workflow

Domain: **commerce**. Available commands: reserve, cancel, ship, refund, relay.

The configuration includes request examples. Inspect state and the audit log after a successful command, then retry it or change its version to observe duplicate and concurrency behavior.

## Configuration

Core workflow demo only. Local fixture authentication and local development storage. External cloud services, live AI model calls and production database/broker integrations from the broader CV descriptions are not configured here. Read the family-level README for the actual implemented stack and tests.

## Architecture

[Architecture and failure boundaries](ARCHITECTURE.md). Shared workflow modules and tests are in the parent stack folder.

