const { setRecord, getRecords } = require('../index');

async function adminMain() {
    await setRecord('0x12345678');
    const records = await getRecords();
    console.log(records);
}

adminMain();