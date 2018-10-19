var greetResponse, byeResponce, rndSelect;
greetResponse = ['Привет!', 'Алоха!', 'Хай!', 'Ты че, ты че?', 'За жизнь брат!', 'Здравствуй!', 'Прива!', 'Шалом!', 'Гутн так!', 'Салам!'];

function humanResponse(type) {
    rndSelect = +(Math.random() * 10).toFixed() - 1;
    while (!((rndSelect >= 0) && (rndSelect <= 9))) {
        rndSelect = +(Math.random() * 10).toFixed() - 1;
    }
    if (type == 'greet') {
        return greetResponse[rndSelect];
    }
}
// while (humanResponse('greet') != 'undefined') {
// console.log(humanResponse('greet'));
// }
export {
    humanResponse
};