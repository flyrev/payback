#!/usr/bin/env node

const fs = require("node:fs");
const os = require("node:os");
const path = require("node:path");
const https = require("node:https");

const VERSION = "0.4.0";
const BEGIN = "<!-- payback:begin -->";
const END = "<!-- payback:end -->";
const SOURCE =
  process.env.PAYBACK_SOURCE_URL ||
  "https://raw.githubusercontent.com/flyrev/payback/main/PAYBACK.md";

function help() {
  console.log(`Payback ${VERSION}

Install an always-on conversational vibe mirror for AI agents.

Usage:
  payback                  Install globally for supported agents
  payback --global         Same as above
  payback --project [dir]  Install into one project (default: current directory)
  payback --help
  payback --version

Global targets:
  Codex       ~/.codex/AGENTS.md
  OpenCode    ~/.config/opencode/AGENTS.md (or $XDG_CONFIG_HOME/opencode/AGENTS.md)
  Copilot CLI ~/.copilot/copilot-instructions.md
  Claude      ~/.claude/CLAUDE.md
  Gemini      ~/.gemini/GEMINI.md
`);
}

function fetchText(url) {
  return new Promise((resolve, reject) => {
    const get = (current, redirects = 0) => {
      https
        .get(current, { headers: { "user-agent": "payback-installer" } }, (res) => {
          if (
            res.statusCode >= 300 &&
            res.statusCode < 400 &&
            res.headers.location &&
            redirects < 5
          ) {
            res.resume();
            return get(new URL(res.headers.location, current).toString(), redirects + 1);
          }
          if (res.statusCode !== 200) {
            res.resume();
            return reject(new Error(`HTTP ${res.statusCode} while fetching Payback`));
          }
          let data = "";
          res.setEncoding("utf8");
          res.on("data", (chunk) => (data += chunk));
          res.on("end", () => resolve(data.trimEnd()));
        })
        .on("error", reject);
    };
    get(url);
  });
}

function withoutPayback(content) {
  if (!content) return "";
  const start = content.indexOf(BEGIN);
  if (start === -1) return content.trimEnd();

  const end = content.indexOf(END, start);
  if (end === -1) return content.trimEnd();

  return (content.slice(0, start) + content.slice(end + END.length)).trim();
}

function installBlock(file, contract) {
  fs.mkdirSync(path.dirname(file), { recursive: true });

  const existing = fs.existsSync(file) ? fs.readFileSync(file, "utf8") : "";
  const clean = withoutPayback(existing);
  const pieces = [];
  if (clean) pieces.push(clean);
  pieces.push(BEGIN, contract, END);

  fs.writeFileSync(file, pieces.join(os.EOL + os.EOL) + os.EOL, "utf8");
  console.log(`✓ ${file}`);
}

function globalTargets() {
  const home = os.homedir();
  const xdg = process.env.XDG_CONFIG_HOME || path.join(home, ".config");

  return [
    path.join(home, ".codex", "AGENTS.md"),
    path.join(xdg, "opencode", "AGENTS.md"),
    path.join(home, ".copilot", "copilot-instructions.md"),
    path.join(home, ".claude", "CLAUDE.md"),
    path.join(home, ".gemini", "GEMINI.md"),
  ];
}

function projectTargets(root) {
  return [
    path.join(root, "AGENTS.md"),
    path.join(root, "CLAUDE.md"),
    path.join(root, "GEMINI.md"),
    path.join(root, ".github", "copilot-instructions.md"),
  ];
}

async function main() {
  const args = process.argv.slice(2);

  if (args.includes("--help") || args.includes("-h")) {
    help();
    return;
  }
  if (args.includes("--version") || args.includes("-v")) {
    console.log(VERSION);
    return;
  }

  let targets;
  const projectIndex = args.indexOf("--project");
  if (projectIndex !== -1) {
    const candidate = args[projectIndex + 1];
    const root =
      candidate && !candidate.startsWith("-")
        ? path.resolve(candidate)
        : process.cwd();
    targets = projectTargets(root);
    console.log(`Payback → project ${root}`);
  } else {
    const unknown = args.filter((arg) => arg !== "--global");
    if (unknown.length) {
      throw new Error(`Unknown argument: ${unknown[0]} (try --help)`);
    }
    targets = globalTargets();
    console.log("Payback → always-on global install");
  }

  const contract = await fetchText(SOURCE);
  for (const target of targets) installBlock(target, contract);

  console.log("\n😈 Payback installed. Start a new agent session and change your tone whenever you feel like it.");
}

main().catch((error) => {
  console.error(`Payback failed: ${error.message}`);
  process.exitCode = 1;
});
