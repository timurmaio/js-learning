var fs = require("fs");

fs.readFile("data", "utf8", function(err, contents) {
  var newStr = contents;
  newStr = newStr.replace(/[a-zA-Z0-9]+/g, "");
  newStr = newStr.replace(/[$-/:-?{-~!"^_`\\@#\[\]]/g, "");

  fs.writeFile("./data.txt", newStr, function(err) {
    if (err) {
      return console.log(err);
    }
    console.log("Русский текст извлечён! Проверьте файл \"data.txt\"");
  });
});
