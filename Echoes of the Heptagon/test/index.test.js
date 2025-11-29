const exec = require('@sliit-foss/actions-exec-wrapper').default;
const { shellFiles } = require('@sliit-foss/bashaway');
const path = require('path');
const fs = require('fs');

describe('Echoes of the Heptagon', () => {
  const root = path.join(__dirname, '..');
  const pattern = path.join(root, 'src', 'echoes', 'pattern.csv');

  const runScript = async () => (await exec('bash execute.sh', { cwd: root }))?.trim();

  test('should rely on a single bash control room', () => {
    expect(shellFiles(root).length).toBe(1);
  });

  test('should mirror the waveform and report the palindromic duration', async () => {
    await expect(runScript()).resolves.toBe('PALINDROME_DURATION:49.700');
  });

  test('should not mutate the base pattern file', async () => {
    const before = fs.readFileSync(pattern, 'utf8');
    await runScript();
    expect(fs.readFileSync(pattern, 'utf8')).toBe(before);
  });

  test('should format duration with exactly three decimals', async () => {
    const output = await runScript();
    expect(output).toMatch(/^PALINDROME_DURATION:\d+\.\d{3}$/);
  });
});
