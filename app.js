'use strict'

const fs = require('fs');
const path = require('path');
const child = require('child_process');

const ress_path = process.env.RESSPATH;
const testFolder = ress_path;
var folderArr = [];

if(ress_path == undefined && ress_path == null){
    console.log("Path to the yaml ressources not found. Exit");
    process.exit(2);
}

var files = fs.readdirSync(testFolder);
files.forEach(file => {
    var fPath = testFolder + '/' + file;
    var folStat = fs.lstatSync(fPath);
    if (folStat.isDirectory()) {
        folStat.path = fPath;
        folderArr.push(folStat);
    }
});

var outputArr = [];

folderArr.forEach((folder)=>{
    
    var runComm = 'kubectl apply -f ' + folder.path + ' --dry-run=true';
    var childStat = systemSync(runComm);
    if(childStat.Error){
        console.log(childStat.Error);
        process.exit(1);
    } else {
        outputArr.push(childStat);
    }
})

console.log("Files syntaxis is okay");

function systemSync(cmd) {
    try {
      return child.execSync(cmd).toString();
    } 
    catch (error) {
      
      return  error;
    }
  };
  