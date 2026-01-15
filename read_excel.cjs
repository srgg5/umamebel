const XLSX = require('xlsx');
const fs = require('fs');

const filename = "Дилерская цена 01.01.26.xlsx";

try {
    if (!fs.existsSync(filename)) {
        console.log("File not found!");
        process.exit(1);
    }
    const workbook = XLSX.readFile(filename);
    const sheetName = workbook.SheetNames[0];
    const worksheet = workbook.Sheets[sheetName];
    const data = XLSX.utils.sheet_to_json(worksheet, { header: 1 });

    // Print first 5 rows to be sure
    for (let i = 0; i < 5; i++) {
        console.log(`Row ${i}:`, JSON.stringify(data[i]));
    }
} catch (e) {
    console.error("Error reading file:", e);
}
