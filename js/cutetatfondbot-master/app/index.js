import TelegramBot from 'node-telegram-bot-api';
import * as currency from './currency_rate';
import * as mainOffice from './main_office';
import convert from 'converter';
import readFile from 'fileReader';
import * as speech from 'speech_2_text';
import * as const_rx from 'rx';
import getNews from './news';
import * as deps from './deposit_info';
import * as car from './cards_info';
import * as cred from './credits_info';
import * as humanResponse from './human_response';
import * as pp from './payments';
import * as lcard from 'lock_card';

const cache = {};

const token = '291395126:AAGvVAaBDiBrPiXHOBS4rAuddWqewye-YXU';
createBot(token);

function createBot(token) {
  var bot = new TelegramBot(token, {polling: true});

  bot.on('message', function (msg) {
    var chatId = msg.chat.id;
    console.log(msg);

    if(/\/start/.test(msg.text)) {
      bot.sendMessage(chatId, 'Привет. Я - Телеграм Бот Татфондбанка. Я могу в любое время помочь тебе в работе с нашим банком! \n' + 
        'Выбери команду из предложенных или введи новую. Для того, чтобы больше узнать о моих возможностях, воспользуйся командой - Команды', {
        reply_markup: JSON.stringify({
          keyboard: [
            [{text: 'Курс валют  \uD83D\uDCB6'}, {text: 'Мои карты \uD83D\uDCB3'}], 
            [{text: 'Новости \uD83D\uDCF0 '}, {text: 'Оператор \uD83D\uDCDE'}]
          ], 'resize_keyboard': true
        })
      });
    }


    if(msg.voice) {
      bot
        .downloadFile(msg.voice.file_id, __dirname)
        .then((filePath) => convert(filePath))
        .then((outputFileName) => readFile(outputFileName))
        .then((data) => speech.audioToText(data, (cache[chatId] || {}).locale))
        .then((result) => {
          console.log(result);

          if((cache[chatId] || {}).locale === 'en') {
            
            if(const_rx.exch_rate_en.test(result)) {
              currency.showCurrencyRate(msg, bot);
            }
            else if(const_rx.news_en.test(result)) {
              getNews().then((newsTitles) => {
                bot.sendMessage(chatId, newsTitles.join("\n"), {
                  parse_mode: 'Markdown'
                });
              });
            }
            else if (const_rx.main_office_en.test(result)) {
              mainOffice.showMainOffice().then(function (result) {
                bot.sendMessage(chatId, result)
              })
            }
            else if (const_rx.deposit_en.test(result)) {
              deps.showDeposits(chatId, bot);
            }
            else if (const_rx.card_en.test(result)) {
              car.showCards(chatId, bot);
            }
            else if (const_rx.credit_en.test(result)) {
              cred.showCredits(chatId, bot);
            }
            else if(const_rx.chat_en.test(result)) {
              bot.sendMessage(chatId, "@tfbbot")
            }

          } else {
            if(const_rx.exch_rate.test(result)) {
              currency.showCurrencyRate(msg, bot);
            }
            else if(const_rx.news.test(result)) {
              getNews().then((newsTitles) => {
                bot.sendMessage(chatId, newsTitles.join("\n"), {
                  parse_mode: 'Markdown'
                });
              });
            }
            else if (const_rx.main_office.test(result)) {
              mainOffice.showMainOffice().then(function (result) {
                bot.sendMessage(chatId, result)
              })
            }
            else if (const_rx.deposit_rx.test(result)) {
              deps.showDeposits(chatId, bot);
            }
            else if (const_rx.card_rx.test(result)) {
              car.showCards(chatId, bot);
            }
            else if (const_rx.credit_rx.test(result)) {
              cred.showCredits(chatId, bot);
            } 
            else if (const_rx.greetings_rx.test(result)) {
            bot.sendMessage(chatId, humanResponse.humanResponse('greet'));}
            else if(const_rx.chat.test(result)) {
              bot.sendMessage(chatId, "@tfbbot")
            }
            else if (const_rx.credit_pay.test(result)) {
              cred.showMoreCredits(chatId, bot);
            }
          }
        })
        .catch((error) => console.log(error));
    }
    else if (msg.location) {
      bot.sendMessage(chatId, 'Ближайший банкомат находится по адресу Казань, ул. Приволжская, 161.');
      bot.sendLocation(chatId, 55.808, 48.9324)
    }
    else if (const_rx.exch_rate.test(msg.text)) {
      currency.showCurrencyRate(msg, bot);
    }
    else if (const_rx.news.test(msg.text)) {
      getNews().then((newsTitles) => {
        bot.sendMessage(chatId, newsTitles.join("\n"), {
          parse_mode: 'Markdown'
        });
      });
    }
    else if(const_rx.main_office.test(msg.text)) {
       mainOffice.showMainOffice().then(function (result) {
        bot.sendMessage(chatId, result)
      })
    }
    else if (const_rx.atm.test(msg.text)) {
      bot.sendMessage(chatId, 'Ближайший банкомат находится по адресу Казань, ул. Приволжская, 161.');
      bot.sendLocation(chatId, 55.808, 48.9324)
    }
    else if (const_rx.deposit_rx.test(msg.text)) {
      deps.showDeposits(chatId, bot);
    }
    else if (const_rx.card_rx.test(msg.text)) {
      car.showCards(chatId, bot);
    } 
    else if (const_rx.credit_rx.test(msg.text)) {
      cred.showCredits(chatId, bot);
    }
    else if(/\/en/.test(msg.text)) {

      if(!cache[chatId]) {
        cache[chatId] = {};
      }
      cache[chatId].locale = 'en';

      bot.sendMessage(chatId, 'locale changed to "en"');
    }
    else if(/\/ru/.test(msg.text)) {

      if(!cache[chatId]) {
        cache[chatId] = {};
      }
      cache[chatId].locale = 'ru';

      bot.sendMessage(chatId, 'Локаль изменена на "ru"');
    } else if (const_rx.greetings_rx.test(msg.text)) {
      bot.sendMessage(chatId, humanResponse.humanResponse('greet'));}
      else if (msg.text == 'Кто ты?'){
        bot.sendMessage(chatId, 'Я - Телеграм Бот Татфондтабнка. Я могу в любое время помочь тебе в работе с нашим банком!')
      } 
      else if (msg.text == 'Расскажи о себе' || msg.text == 'Зачем ты здесь?') {
        bot.sendMessage(chatId, 'Я был создан 18 сентября 2016 года, командой MetaTeam в рамках хакатона InspiRussia.'+
        ' У меня есть мечта: я очень хочу помочь ребятам выиграть хакатон, чтобы потом помогать клиентам банка и отвечать на все интересующие их вопросы. ')
      }
      else if (msg.text == 'Команды') {
        bot.sendMessage(chatId, ' На данный момент доступны такие команды, как: \n' + 
          '- Курс валют\n' + '- Мои карты\n' + '- Мои кредиты\n' + '- Оплата кредита\n' + '- Мои вклады\n' + 
          '- Новости банка\n' + '- Главный офис\n' + '- Ближайший банкомат\n' + '- Чат с оператором\n' + '- Оплата 79179125089 сумма\n' + '- Заблокировать номер карты причина\n' + '- /en - для распознования команд на английском языке\n' +
          '- /ru - для распознования команд на русском языке\n' + 
          'Также я умею распозновать голосовые команды. \n')
      }
    else if(const_rx.chat.test(msg.text)) {
      bot .sendMessage(chatId, "@tfbbot")
    }
      else if (const_rx.pay_phone_rx.test(msg.text)) {
        var res = String(msg.text.match(const_rx.pay_phone_rx)).split(" ");
        pp.payDoc(chatId, bot, res[1], res[2]);
      }
      else if (const_rx.credit_pay.test(msg.text)) {
        cred.showMoreCredits(chatId, bot);
      }
      else if (const_rx.block_card_rx.test(msg.text)) {
        var res = String(msg.text.match(const_rx.block_card_rx)).split(" ");
        lcard.LockCard(chatId, bot, res[1], res[2])
      }
  });
}
