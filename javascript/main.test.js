const test = require('node:test');
const assert = require('node:assert');

const { sum } = require('./test');

test('sum 1 + 2 = 3', () => {
  assert.strictEqual(sum(1, 2), 3);
});

test('sum negative numbers', () => {
  assert.strictEqual(sum(-1, -1), -2);
});