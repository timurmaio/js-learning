var images = ['1.jpg', '2.jpg', '3.jpg', '4.jpg', '5.jpg', '6.jpg', '7.jpg', '8.jpg', '9.jpg'],
    index = 0,
    maxImages = images.length - 1;

var ovals = ['#oval_1', '#oval_2', '#oval_3', '#oval_4', '#oval_5', '#oval_6', '#oval_7', '#oval_8', '#oval_9'],
    oval_index = 0,
    maxOvals = ovals.length - 1,
    prevOval = ovals[oval_index];

var changer = function() {
    $(prevOval).css("background-color", "transparent");
    prevOval = ovals[oval_index];
    curOval = ovals[oval_index];
    curImage = images[index];
    index = (index == maxImages) ? 0 : ++index;
    oval_index = (oval_index == maxOvals) ? 0 : ++oval_index;
    $('div.wrapper img').attr('src', 'images/' + curImage);
    $(curOval).css("background-color", "white");
};

var timer = setInterval(changer, 1000);
var clicked = false;

$('#button').click(function() {
    if (clicked === false) {
        clicked = true;
        clearInterval(timer);
        document.getElementById("button").innerHTML = 'START';
    } else {
        clicked = false;
        timer = setInterval(changer, 1000);
        document.getElementById("button").innerHTML = 'STOP';
    }
});

// Иногда нужно в зависимости от условия присвоить переменную.Например:
//     if (age > 14) {
//         access = true;
//     } else {
//         access = false;
//     }
//
// Оператор вопросительный знак '?' позволяет делать это короче и проще.
//
// Он состоит из трех частей:
//     условие ? значение1 : значение2
//
//     access = (age > 14) ? true : false;
