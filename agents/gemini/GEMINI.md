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

## Verification Workflow
- **Batching:** When performing multiple edits, run sanity checks at the very
  end of the batch to save time.
- **Cleanup Mandate:** After file modifications, I must run
  `agent-cleanup.sh <file>` to strip trailing whitespace and ensure exactly
  one trailing newline.
