const fs = require('fs');
const file = './index.js';

fs.readFile(file, 'UTF-8', (err, data) => {
	console.log(data);
});