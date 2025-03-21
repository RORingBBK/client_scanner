# 1 Git Workflow

Date: 2025-03-21

## Author

Bibek Khadka

## Status

Accepted

## Context

To ensure a consistent and reliable build process for `client_scanner` CLI, we need a structured git workflow. This workflow will streamline feature development, testing, deployment while maintenaning stability.

## Decision

I have decided to follow git branching. A github workflow is setup which executes rspec and rubocop.

1. Main branch:

- `main`: Stable production ready code

2. Feature development:

- Create a branch with `enhancement/` prefix
- Submit a PR to `main` when ready for review

3. Bug fixes:

- Create a branch with `bug/` prefix
- Submit a PR to `main` when ready for review

4. Documentation:

- Create a branch with `docs/` prefix
- Submit a PR to `main` when ready for review

5. CI/CD

- Automated tests run on all PRs with github workflow
- Successful builds are required before merging into `main`

## Consequences

Pros

- Encourages clean separation of features/bugs/docs.
- Reduces risk of breaking main build.
- Facilitates code review and collaboration
