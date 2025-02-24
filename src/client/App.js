const { setRecord, getRecords } = require('../index');

async function main() {
    await setRecord('0x12345678');
    const records = await getRecords();
    console.log(records);
}

main();