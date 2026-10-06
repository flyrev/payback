# Agent instructions

This repository defines **Payback**, a portable instruction contract for AI agents.

When modifying Payback:

- Preserve the core behavior in `PAYBACK.md`.
- Keep installers idempotent: rerunning them must replace the existing Payback block rather than duplicate it.
- Preserve pre-existing user instructions outside the marked Payback block.
- Keep the canonical instruction short enough to be useful as always-on context.
- If adding support for another agent, prefer its documented user-level/global instruction mechanism.
- Do not turn Payback into a persona. It is a reciprocity rule: respond *med samme mynt*.
