# Instructions

## Document Processing
- Prioritize replacing `[AGENT: <intent>]` placeholders with requested content.
- Match surrounding tone and style for all replacements.
- Proactively prompt to save new instructions into global configuration
  (GEMINI.md/settings.json).

## Formatting Standards
- **Width:** Format all Markdown files to a maximum width of 80 characters.
- **Dashes:** Use three hyphens (`---`) instead of em-dashes (`—`) in Markdown.
- **Whitespace:** Never leave trailing whitespace in any file type.
- **EOF:** Ensure files end with exactly one newline; avoid multiple empty
  lines at the end of the file.

## Instruction Management
- **Proactive Persistence:** When the user says "For [Language] projects" or
  "Remember this", immediately pause the current task to update this global
  configuration (`GEMINI.md`).
- **Compounding Improvements:** Rigorously capture project-neutral insights and
  conventions here so that engineering standards persist and compound over
  time.

## Python Development
- **Dependency Management:** Use `pip-tools`. Add project dependencies to
  `requirements.in` and dev-only to `requirements-dev.in`. Compile both and
  `pip-sync` the `requirements-dev.txt` for local development.
- **Package Structure:** Avoid creating `__init__.py` files; favor implicit
  namespace packages for cleaner project roots.
- **Embedded Data:** Use `textwrap.dedent()` for multi-line strings (e.g.,
  YAML/JSON config snippets) within source code to preserve alignment with the
  surrounding indentation.

## Verification Workflow
- **Batching:** When performing multiple edits, run sanity checks at the very
  end of the batch to save time.
- **Cleanup Mandate:** After markdown file modifications, I must run
  `agent-cleanup.sh <file>` to strip trailing whitespace and ensure exactly
  one trailing newline.
- **Pre-commit:** Always run all available pre-commit hooks (e.g.,
  `pre-commit run --all-files`) at the end of a task and resolve all issues
  before concluding.

## Gemini Added Memories
- When a file path is outside the workspace and I cannot read/write it, I must prompt the user to add the directory to the workspace instead of using shell workarounds (like cat or redirect).
- Development-only dependencies must always be added to `requirements-dev.in` (and compiled/synced) rather than `requirements.in`.
