const fs = require('fs');
const { faker } = require('@faker-js/faker');
const exec = require('@sliit-foss/actions-exec-wrapper').default;
const { scan, shellFiles, dependencyCount, restrictJavascript, restrictPython } = require('@sliit-foss/bashaway');

test('should validate if only bash files are present', () => {
    const shellFileCount = shellFiles().length;
    expect(shellFileCount).toBe(1);
    expect(shellFileCount).toBe(scan('**', ['src/**']).length);
});

describe('should check installed dependencies', () => {
    let script
    beforeAll(() => {
        script = fs.readFileSync('./execute.sh', 'utf-8')
    });
    test("javacript should not be used", () => {
        restrictJavascript(script)
    });
    test("python should not be used", () => {
        restrictPython(script)
    });
    test("no additional npm dependencies should be installed", async () => {
        await expect(dependencyCount()).resolves.toStrictEqual(4)
    });
});

test('should calculate days between dates correctly', async () => {
    const calculateDays = (date1, date2) => {
        const d1 = new Date(date1);
        const d2 = new Date(date2);
        const diffTime = Math.abs(d2 - d1);
        const diffDays = Math.floor(diffTime / (1000 * 60 * 60 * 24));
        return diffDays;
    };

    const testCases = [
        ['2024-01-01', '2024-12-31'],
        ['2020-01-01', '2020-12-31'], // leap year
        ['2023-03-15', '2023-09-22'],
        ['2024-02-28', '2024-03-01'], // leap year boundary
        ['2023-02-28', '2023-03-01'], // non-leap year boundary
        ['2020-12-31', '2021-01-01'],
        ['2024-06-15', '2024-06-15'], // same date
    ];

    for (const [date1, date2] of testCases) {
        const output = await exec(`bash execute.sh ${date1} ${date2}`);
        const expected = calculateDays(date1, date2);
        expect(Number(output?.trim())).toBe(expected);
    }
});

test('should handle random date pairs', async () => {
    const calculateDays = (date1, date2) => {
        const d1 = new Date(date1);
        const d2 = new Date(date2);
        const diffTime = Math.abs(d2 - d1);
        const diffDays = Math.floor(diffTime / (1000 * 60 * 60 * 24));
        return diffDays;
    };

    for (let i = 0; i < 20; i++) {
        const date1 = faker.date.between({ from: '2020-01-01', to: '2024-12-31' });
        const date2 = faker.date.between({ from: '2020-01-01', to: '2024-12-31' });
        
        const date1Str = date1.toISOString().split('T')[0];
        const date2Str = date2.toISOString().split('T')[0];
        
        const output = await exec(`bash execute.sh ${date1Str} ${date2Str}`);
        const expected = calculateDays(date1Str, date2Str);
        expect(Number(output?.trim())).toBe(expected);
    }
});

test('should handle dates in reverse order', async () => {
    const calculateDays = (date1, date2) => {
        const d1 = new Date(date1);
        const d2 = new Date(date2);
        const diffTime = Math.abs(d2 - d1);
        const diffDays = Math.floor(diffTime / (1000 * 60 * 60 * 24));
        return diffDays;
    };

    // Later date first
    const output = await exec('bash execute.sh 2024-12-31 2024-01-01');
    const expected = calculateDays('2024-01-01', '2024-12-31');
    expect(Number(output?.trim())).toBe(expected);
});

