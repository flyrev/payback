# Agent instructions

This repository defines **Payback**, a portable conversational mirroring layer for AI agents.

When modifying Payback:

- Preserve the core behavior in `PAYBACK.md`.
- Payback is always-on: the current user message must be reconsidered before every user-facing response.
- Keep installers idempotent: rerunning them must replace the existing Payback block rather than duplicate it.
- Preserve pre-existing user instructions outside the marked Payback block.
- Keep the canonical instruction short enough to be useful as always-on context.
- If adding support for another agent, prefer its documented user-level/global instruction mechanism.
- Keep it fun. Do not turn Payback into a heavy persona or policy framework; it is a live conversational mirror.
