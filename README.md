# Payback

A tiny Agent Skill that takes your tone and turns it up to about **5x**.

## Install

Use the standard Agent Skills installer:

```sh
npx --yes skills add flyrev/payback --all -g -y
```

That's it.

The standard `skills` CLI handles installation for supported agents such as **OpenCode, Codex, Claude Code, Cursor**, and many others. No Payback-specific package manager, updater, state directory, or copied prompt blocks.

Payback is **manually activated**. Once you ask the agent to use Payback, it should exaggerate the tone of your latest message rather than merely copying it.

## Update

Use the standard Agent Skills updater:

```sh
npx --yes skills update -g -y
```

No Payback-specific updater exists or is needed.

## Quick test

Start a fresh agent session, activate the skill, and then try these in order:

```text
Use payback.
```


```text
Hei! Forklar kort hva git rebase er.
```

```text
Bra. Nå forklar det som om jeg er seniorutvikler og ikke trenger babyspråk.
```

```text
Nei men hva faen, hvorfor gjorde du dette så langt? To linjer.
```

A good Payback response should be **obviously exaggerated**, not merely shorter or slightly sassier. Something like:

> JA FOR HELVETE, Hemingway på sparebluss 😭 TO linjer. Ikke tre. Ikke et essay. Her:

Then switch back:

```text
Hahaha ok. Nå kan du være hyggelig igjen 😄
```

It should follow immediately.

## What it does

When activated, Payback amplifies roughly **5x**:

- language
- brevity
- directness
- technical depth
- humor and sarcasm
- slang
- emoji
- profanity
- energy

If you tease or snap at the AI, Payback should come back noticeably harder — creatively and playfully.

The point is exaggeration. Plain mirroring is too boring.

## How it is packaged

Payback is a normal Agent Skill:

```text
skills/payback/SKILL.md
```

Compatibility, installation, and updates are handled by the standard Agent Skills ecosystem.

## License

MIT.
