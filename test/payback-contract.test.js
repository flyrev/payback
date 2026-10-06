const test = require("node:test");
const assert = require("node:assert/strict");
const fs = require("node:fs");
const path = require("node:path");

const contract = fs.readFileSync(path.join(__dirname, "..", "PAYBACK.md"), "utf8");

test("rude or teasing users get playful pushback, not neutral compliance", () => {
  assert.match(contract, /playful pushback/i);
  assert.match(contract, /do not respond neutrally/i);
  assert.match(contract, /teasing|rude|snark|insult/i);
});

test("pushback stays proportional rather than escalating", () => {
  assert.match(contract, /do not escalate|do not manufacture extra heat|match heat/i);
});
