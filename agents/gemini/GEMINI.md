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
- **Hooks & Testing:** Examine `.pre-commit-config.yaml` (if present) to
  identify established testing and linting commands. Always run these hooks
  after modifying files that match their patterns to ensure compliance with
  project standards.

## Technical Integrity
- **Command Structure:** Prioritize running simple, atomic shell commands instead
  of compound commands (e.g., using `&&`, `||`, or `;`). Atomic commands are
  more likely to match global `settings.json` allowlists, reducing the need for
  manual user approval and improving autonomy.
- **Verification Workflow:** Always run all available pre-commit hooks (e.g.,
  `pre-commit run --all-files`) at the end of a task and resolve all issues
  before concluding.

## Gemini Added Memories
- When a file path is outside the workspace and I cannot read/write it, I must prompt the user to add the directory to the workspace instead of using shell workarounds (like cat or redirect).
- Development-only dependencies must always be added to `requirements-dev.in` (and compiled/synced) rather than `requirements.in`.
- When compiling Python dependencies, always compile both `requirements.in` and `requirements-dev.in`, but only `pip-sync` the resulting `requirements-dev.txt` for local development.
