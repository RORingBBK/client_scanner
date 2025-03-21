# 1 System Architecture

Date: 2025-03-21

## Author

Bibek Khadka

## Status

Accepted: This architecture is currently in use and will be iterated upon as necessary.

## Context

The `client_scanner` is a CLI application designed to search for clients by name and duplicate email address from JSON dataset. The application follows a structured design incorporating SOLID principles, dependency injection, and various design patterns such as the presenter, stores.

## Decision

I have decided to structure `client_scanner` as a Ruby gem using `bundler`, following best practices for CLI applications. Key decisions include:

1. Project Structure:

- The application follows a modular architecture with separate folders for stores, presenters, models, commands.
- Models are represented as Plain Old Ruby Object (PORO) for simplicity and flexibility.

2. Dependency Injection:

- External dependencies such as the data store, search command and presenters are injected to facilitate testing and decoupling.
- The `ClientScanner::CLI` class accepts configurable dependencies, making it easier to extend functionality.

3. Storate and data loading:

- The `ClientStore` class is responsible for loading JSON data.
- The system does not rely on databasse to maintain simplicity.

4. Commands:

- Commands are designed using the command patterns (`SearchCommand` and `DetectDuplicateEmailPresenter`).
- Each command operates on a `ClientStore` instance and returns structured results.

5. Presentation layer:

- Results are formatted using dedicated presenter classes (`SearchPresenter` and `DetectDuplicateEmailPresenter`)

## Consequences

Pros

- Improved maintenability due to modular structure
- Easier testing via dependency injection
- Scalability by addming more commands without modifying core logic

Cons

- Slightly more complex setup compated to a single monolithic script
