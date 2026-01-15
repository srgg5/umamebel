import * as XLSX from 'xlsx';
import * as fs from 'fs';

const filename = "Дилерская цена 01.01.26.xlsx";
const workbook = XLSX.readFile(filename);
const sheetName = workbook.SheetNames[0];
const worksheet = workbook.Sheets[sheetName];
const data = XLSX.utils.sheet_to_json(worksheet, { header: 1 });

console.log("Headers:", data[0]);
console.log("First Row:", data[1]);
console.log("Second Row:", data[2]);
