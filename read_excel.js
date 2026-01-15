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

    console.log("Headers:", data[0]);
    console.log("Row 1:", data[1]);
    console.log("Row 2:", data[2]);
    console.log("Row 3:", data[3]);
    console.log("Total Rows:", data.length);
} catch (e) {
    console.error("Error reading file:", e);
}
