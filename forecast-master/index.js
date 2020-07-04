const readFilesFromDir = require('./helpers').readFilesFromDir
const buildCanals = require('./helpers').buildCanals
const makeForecast = require('./helpers').makeForecast

const dataDir = './data'

readFilesFromDir(dataDir)
  .then((stocks) => {
    // Количество акций
    let stockNum = stocks.length

    // Текущий день
    let curDay = 30

    // Сколько я заработаю используя свой метод?
    let totalProfit = 0

    // Цикл дней
    for (let i = 0; i < 30; i++) {
      console.log(`День №${i + 1}`)

      // Массив надёжных акций
      let buyArr = []

      // Цикл акций
      for (let j = 0; j < stockNum; j++) {
        // Количество котировок акции
        let l = stocks[j].values.length

        // Берём нужные котировки, моделируем события произошедние curDay дней назад :)
        let arr = stocks[j].values.slice(0, l - curDay + 1)

        // Строим каналы на основе нужных котировок
        let canals = buildCanals(arr)

        // Угол роста канала, нужен для последующей сортировки на строке 70
        let m = canals[canals.length - 1].params.m

        // Реальный доход
        let realProfit

        // Моделируемый доход
        let modelProfit

        // Последний канал
        let lastCanal = canals[canals.length - 1]

        // Считаем до предпоследнего дня, т.к после последнего нет значений
        if (i < 29) {
          // Размер последнего канала
          let lastCanalLength = lastCanal.allPoints.length

          // Считаем реальный доход: значение следующего дня делим на текущий -> получем процент роста
          realProfit = (stocks[j].values[l - curDay + 1][1]) / (stocks[j].values[l - curDay][1])

          // Считаем моделируемый доход: значение следующего моделируемого дня делим на текущий -> получем процент роста
          modelProfit = ((lastCanal.allPoints[lastCanalLength - 1][0] + 1) * lastCanal.params.m + lastCanal.params.b) / (stocks[j].values[l - curDay][1])
        }

        // Делаем предположение, стоит ли брать акцию
        if (makeForecast(canals)) {
          // Если да, то добавляем акцию в массив надёжных акций
          buyArr.push({ 'stock': stocks[j], 'm': m, 'real': realProfit, 'model': modelProfit })
        }

        // Если мы достигли последней акции
        if (j === stockNum - 1) {
          // Сортируем по углу роста, нам нужны только самые быстрорастущие
          buyArr.sort((obj, obj2) => {
            if (obj.m > obj2.m) return -1
            if (obj.m < obj2.m) return 1
          })

          // Удаляем из массива надёжных акций те, что дают убыток
          // Т.к изначально мы не учитываем 'b' в уравнении канала 'y = ax + b' и считаем только по 'a', то в массив попадают и убыточные акции
          buyArr.forEach((item) => {
            let index
            if (item.model < 1) {
              index = buyArr.indexOf(item)
              if (index > -1) {
                buyArr.splice(index, 1)
              }
            }
          })

          // Далее мы оставляем в массиве только 3 акции, точнее максимум 3, может быть от 0 до 3
          if (buyArr.length > 3) buyArr.splice(3, buyArr.length - 3)

          // Задаём бюджет
          let budget = 1000000

          // Задаём количество денег на каждую акции, зависит от их количества
          // Прим. Акций 3 шт -> инвестиции по 3330000, Акций 2 шт -> инвестиции по 500000
          let invest = (buyArr.length > 0) ? budget / buyArr.length : budget

          // Далее выводим наши данные
          buyArr.forEach((item) => {
            // Последний день не можем предсказать
            if (i < 29) {
              // Реальная прибыль
              let real = item.real * invest - invest

              // Моделируемая прибыль
              let model = item.model * invest - invest
              console.log(item.stock.name + ' Real: ' + real + ' Model: ' + model)

              // Суммируем реальную прибыль
              totalProfit += real
            } else (console.log('Нужно брать: ' + item.stock.name))
          })

          // Выводим итоговую реальную прибыль
          if (i === 29) console.log('Мой заработок: ' + totalProfit)
        }
      }
      curDay--
    }
  })
  .catch(err => console.log(err))
