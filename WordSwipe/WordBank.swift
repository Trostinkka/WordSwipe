import Foundation

enum WordBank {
    static let allWords: [WordItem] = buildWords()

    static func words(for topic: WordTopic?) -> [WordItem] {
        guard let topic else { return allWords }
        return allWords.filter { $0.topic == topic }
    }

    private static func buildWords() -> [WordItem] {
        var result: [WordItem] = []

        func add(_ topic: WordTopic, _ entries: [(String, String, String, String)]) {
            for entry in entries {
                result.append(
                    WordItem(
                        id: "\(topic.rawValue)-\(entry.0.lowercased().replacingOccurrences(of: " ", with: "-"))",
                        english: entry.0,
                        translation: entry.1,
                        pronunciation: entry.2,
                        example: entry.3,
                        topic: topic
                    )
                )
            }
        }

        add(.basics, [
            ("hello", "привет", "heh-LOH", "Hello, nice to meet you."),
            ("goodbye", "до свидания", "good-BY", "She waved goodbye."),
            ("please", "пожалуйста", "pleez", "Please open the window."),
            ("thanks", "спасибо", "thanks", "Thanks for your help."),
            ("morning", "утро", "MOR-ning", "I run every morning."),
            ("evening", "вечер", "EEV-ning", "We met in the evening."),
            ("today", "сегодня", "tuh-DAY", "Today is busy."),
            ("tomorrow", "завтра", "tuh-MOR-oh", "Call me tomorrow."),
            ("friend", "друг", "frend", "My friend lives nearby."),
            ("family", "семья", "FAM-uh-lee", "Family matters to me."),
            ("question", "вопрос", "KWES-chun", "I have one question."),
            ("answer", "ответ", "AN-ser", "The answer is simple."),
            ("again", "снова", "uh-GEN", "Try again."),
            ("always", "всегда", "AWL-wayz", "She always smiles."),
            ("never", "никогда", "NEV-er", "Never give up."),
            ("often", "часто", "AW-fun", "We often cook together.")
        ])

        add(.travel, [
            ("airport", "аэропорт", "AIR-port", "The airport is crowded."),
            ("ticket", "билет", "TIK-it", "I bought a ticket."),
            ("passport", "паспорт", "PAS-port", "Show your passport."),
            ("luggage", "багаж", "LUG-ij", "My luggage is heavy."),
            ("flight", "рейс", "flyt", "The flight leaves at six."),
            ("arrival", "прибытие", "uh-RY-vul", "Arrival is on time."),
            ("departure", "отправление", "dee-PAR-cher", "Check the departure board."),
            ("hotel", "отель", "hoh-TEL", "The hotel is near the beach."),
            ("reservation", "бронь", "rez-er-VAY-shun", "I have a reservation."),
            ("map", "карта", "map", "Open the map."),
            ("station", "станция", "STAY-shun", "Meet me at the station."),
            ("platform", "платформа", "PLAT-form", "The train leaves from platform two."),
            ("journey", "путешествие", "JER-nee", "The journey was long."),
            ("abroad", "за границей", "uh-BRAWD", "She studies abroad."),
            ("currency", "валюта", "KUR-en-see", "Exchange some currency."),
            ("guide", "гид", "gyd", "The guide knows the city.")
        ])

        add(.food, [
            ("breakfast", "завтрак", "BREK-fust", "Breakfast is ready."),
            ("lunch", "обед", "lunch", "Lunch starts at noon."),
            ("dinner", "ужин", "DIN-er", "We cooked dinner."),
            ("bread", "хлеб", "bred", "Buy fresh bread."),
            ("cheese", "сыр", "cheez", "This cheese is soft."),
            ("chicken", "курица", "CHIK-in", "Chicken is in the oven."),
            ("vegetable", "овощ", "VEJ-tuh-bul", "Eat one more vegetable."),
            ("fruit", "фрукт", "froot", "Fruit is healthy."),
            ("water", "вода", "WAW-ter", "Drink more water."),
            ("coffee", "кофе", "KAW-fee", "Coffee smells great."),
            ("menu", "меню", "MEN-yoo", "Can I see the menu?"),
            ("bill", "счет", "bil", "Ask for the bill."),
            ("recipe", "рецепт", "RES-uh-pee", "This recipe is easy."),
            ("delicious", "вкусный", "dee-LISH-us", "The soup is delicious."),
            ("spicy", "острый", "SPY-see", "This sauce is spicy."),
            ("hungry", "голодный", "HUN-gree", "I am hungry.")
        ])

        add(.work, [
            ("meeting", "встреча", "MEE-ting", "The meeting starts soon."),
            ("deadline", "срок", "DED-lyn", "The deadline is Friday."),
            ("project", "проект", "PROJ-ekt", "The project is complex."),
            ("task", "задача", "task", "Finish this task."),
            ("salary", "зарплата", "SAL-uh-ree", "Salary arrives monthly."),
            ("office", "офис", "AW-fis", "The office is quiet."),
            ("colleague", "коллега", "KOL-eeg", "My colleague helped me."),
            ("manager", "менеджер", "MAN-uh-jer", "Ask your manager."),
            ("schedule", "расписание", "SKEJ-ool", "Check the schedule."),
            ("report", "отчет", "ri-PORT", "Send the report."),
            ("interview", "собеседование", "IN-ter-vyoo", "The interview went well."),
            ("hire", "нанимать", "hyr", "They want to hire a designer."),
            ("team", "команда", "teem", "Our team is small."),
            ("goal", "цель", "gohl", "Set a clear goal."),
            ("skill", "навык", "skil", "Listening is a skill."),
            ("career", "карьера", "kuh-REER", "Her career is growing.")
        ])

        add(.home, [
            ("kitchen", "кухня", "KICH-in", "The kitchen is bright."),
            ("bedroom", "спальня", "BED-room", "The bedroom is upstairs."),
            ("bathroom", "ванная", "BATH-room", "The bathroom is clean."),
            ("window", "окно", "WIN-doh", "Open the window."),
            ("door", "дверь", "dor", "Close the door."),
            ("floor", "пол", "flor", "The floor is wooden."),
            ("ceiling", "потолок", "SEE-ling", "The ceiling is high."),
            ("chair", "стул", "chair", "Sit on the chair."),
            ("table", "стол", "TAY-bul", "The table is round."),
            ("mirror", "зеркало", "MIR-er", "Look in the mirror."),
            ("blanket", "одеяло", "BLAN-kit", "This blanket is warm."),
            ("pillow", "подушка", "PIL-oh", "My pillow is soft."),
            ("neighbor", "сосед", "NAY-ber", "Our neighbor is kind."),
            ("garden", "сад", "GAR-den", "The garden needs water."),
            ("rent", "аренда", "rent", "Rent is expensive."),
            ("repair", "ремонтировать", "ri-PAIR", "We need to repair the sink.")
        ])

        add(.city, [
            ("street", "улица", "street", "This street is busy."),
            ("square", "площадь", "skwair", "The square is old."),
            ("bridge", "мост", "brij", "Cross the bridge."),
            ("traffic", "движение", "TRAF-ik", "Traffic is slow."),
            ("subway", "метро", "SUB-way", "Take the subway."),
            ("museum", "музей", "myoo-ZEE-um", "The museum opens at ten."),
            ("library", "библиотека", "LY-brer-ee", "Study at the library."),
            ("market", "рынок", "MAR-kit", "The market is lively."),
            ("park", "парк", "park", "Walk in the park."),
            ("corner", "угол", "KOR-ner", "Turn at the corner."),
            ("district", "район", "DIS-trikt", "This district is new."),
            ("address", "адрес", "AD-res", "Write the address."),
            ("crosswalk", "пешеходный переход", "KRAWS-wawk", "Use the crosswalk."),
            ("downtown", "центр города", "DOWN-town", "I work downtown."),
            ("building", "здание", "BIL-ding", "That building is tall."),
            ("fountain", "фонтан", "FOWN-tin", "Meet near the fountain.")
        ])

        add(.health, [
            ("doctor", "врач", "DOK-ter", "Call a doctor."),
            ("nurse", "медсестра", "ners", "The nurse was patient."),
            ("medicine", "лекарство", "MED-i-sin", "Take this medicine."),
            ("pain", "боль", "payn", "I feel pain."),
            ("fever", "температура", "FEE-ver", "He has a fever."),
            ("cough", "кашель", "kawf", "The cough is gone."),
            ("healthy", "здоровый", "HEL-thee", "A healthy habit helps."),
            ("tired", "уставший", "TY-erd", "I feel tired."),
            ("sleep", "сон", "sleep", "Sleep is important."),
            ("exercise", "упражнение", "EK-ser-syz", "Exercise every day."),
            ("breath", "дыхание", "breth", "Take a deep breath."),
            ("heart", "сердце", "hart", "My heart beats fast."),
            ("stomach", "желудок", "STUM-uk", "My stomach hurts."),
            ("appointment", "запись", "uh-POINT-ment", "Book an appointment."),
            ("recover", "выздоравливать", "ri-KUV-er", "She will recover soon."),
            ("clinic", "клиника", "KLIN-ik", "The clinic is nearby.")
        ])

        add(.emotions, [
            ("happy", "счастливый", "HAP-ee", "I feel happy today."),
            ("sad", "грустный", "sad", "He looks sad."),
            ("angry", "злой", "ANG-gree", "She sounded angry."),
            ("calm", "спокойный", "kahm", "Stay calm."),
            ("afraid", "испуганный", "uh-FRAYD", "Do not be afraid."),
            ("proud", "гордый", "prowd", "I am proud of you."),
            ("lonely", "одинокий", "LOHN-lee", "He felt lonely."),
            ("excited", "взволнованный", "ik-SY-tid", "We are excited."),
            ("worried", "обеспокоенный", "WER-eed", "She is worried."),
            ("bored", "скучающий", "bord", "I am bored."),
            ("curious", "любопытный", "KYOOR-ee-us", "Children are curious."),
            ("confident", "уверенный", "KON-fi-dent", "Speak with a confident voice."),
            ("relieved", "облегченный", "ri-LEEVd", "He felt relieved."),
            ("jealous", "ревнивый", "JEL-us", "She felt jealous."),
            ("grateful", "благодарный", "GRAYT-ful", "I am grateful."),
            ("hopeful", "полный надежды", "HOHP-ful", "They sounded hopeful.")
        ])

        add(.nature, [
            ("forest", "лес", "FOR-ist", "The forest is quiet."),
            ("river", "река", "RIV-er", "The river is wide."),
            ("mountain", "гора", "MOWN-tin", "The mountain is high."),
            ("ocean", "океан", "OH-shun", "The ocean is cold."),
            ("island", "остров", "EYE-lund", "The island is small."),
            ("desert", "пустыня", "DEZ-ert", "The desert is dry."),
            ("weather", "погода", "WETH-er", "The weather changed."),
            ("cloud", "облако", "klowd", "A cloud covered the sun."),
            ("rain", "дождь", "rayn", "Rain started suddenly."),
            ("snow", "снег", "snoh", "Snow fell all night."),
            ("wind", "ветер", "wind", "The wind is strong."),
            ("flower", "цветок", "FLOW-er", "This flower smells sweet."),
            ("field", "поле", "feeld", "The field is green."),
            ("valley", "долина", "VAL-ee", "The valley is beautiful."),
            ("stone", "камень", "stohn", "Throw a small stone."),
            ("sunrise", "рассвет", "SUN-ryz", "Sunrise was early.")
        ])

        add(.technology, [
            ("device", "устройство", "di-VYS", "This device is new."),
            ("screen", "экран", "skreen", "The screen is bright."),
            ("keyboard", "клавиатура", "KEE-bord", "Use the keyboard."),
            ("password", "пароль", "PAS-word", "Change your password."),
            ("account", "аккаунт", "uh-KOWNT", "Create an account."),
            ("network", "сеть", "NET-work", "The network is slow."),
            ("software", "программа", "SAWFT-wair", "Update the software."),
            ("download", "скачивать", "DOWN-lohd", "Download the file."),
            ("upload", "загружать", "UP-lohd", "Upload the photo."),
            ("message", "сообщение", "MES-ij", "Send a message."),
            ("battery", "батарея", "BAT-er-ee", "The battery is low."),
            ("privacy", "конфиденциальность", "PRY-vuh-see", "Privacy is important."),
            ("browser", "браузер", "BROW-zer", "Open the browser."),
            ("folder", "папка", "FOHL-der", "Save it in this folder."),
            ("search", "поиск", "serch", "Search the web."),
            ("update", "обновление", "UP-dayt", "Install the update.")
        ])

        add(.study, [
            ("lesson", "урок", "LES-un", "The lesson begins now."),
            ("teacher", "учитель", "TEE-cher", "The teacher explains well."),
            ("student", "студент", "STOO-dent", "Every student reads aloud."),
            ("homework", "домашнее задание", "HOHM-work", "Do your homework."),
            ("exam", "экзамен", "ig-ZAM", "The exam is difficult."),
            ("grade", "оценка", "grayd", "She got a good grade."),
            ("notebook", "тетрадь", "NOHT-book", "Open your notebook."),
            ("dictionary", "словарь", "DIK-shun-er-ee", "Use a dictionary."),
            ("sentence", "предложение", "SEN-tens", "Write a sentence."),
            ("grammar", "грамматика", "GRAM-er", "Grammar takes practice."),
            ("meaning", "значение", "MEE-ning", "What is the meaning?"),
            ("mistake", "ошибка", "mi-STAYK", "Correct the mistake."),
            ("repeat", "повторять", "ri-PEET", "Repeat after me."),
            ("memorize", "запоминать", "MEM-uh-ryz", "Memorize five words."),
            ("fluent", "беглый", "FLOO-ent", "She is fluent in English."),
            ("practice", "практика", "PRAK-tis", "Practice every day.")
        ])

        add(.business, [
            ("client", "клиент", "KLY-ent", "The client agreed."),
            ("customer", "покупатель", "KUS-tuh-mer", "The customer is waiting."),
            ("contract", "контракт", "KON-trakt", "Sign the contract."),
            ("invoice", "счет-фактура", "IN-voys", "Send the invoice."),
            ("profit", "прибыль", "PROF-it", "Profit increased."),
            ("loss", "убыток", "laws", "The loss was small."),
            ("budget", "бюджет", "BUJ-it", "Set the budget."),
            ("market", "рынок", "MAR-kit", "The market is changing."),
            ("brand", "бренд", "brand", "The brand feels modern."),
            ("launch", "запуск", "lawnch", "The launch is tomorrow."),
            ("growth", "рост", "grohth", "Growth is steady."),
            ("strategy", "стратегия", "STRAT-uh-jee", "We need a strategy."),
            ("negotiate", "вести переговоры", "ni-GOH-shee-ayt", "They negotiate carefully."),
            ("partner", "партнер", "PART-ner", "Find a reliable partner."),
            ("revenue", "выручка", "REV-uh-nyoo", "Revenue grew fast."),
            ("startup", "стартап", "START-up", "The startup raised money.")
        ])

        add(.shopping, [
            ("price", "цена", "prys", "The price is low."),
            ("discount", "скидка", "DIS-kownt", "There is a discount."),
            ("receipt", "чек", "ri-SEET", "Keep the receipt."),
            ("cash", "наличные", "kash", "Pay with cash."),
            ("card", "карта", "kard", "Use a card."),
            ("size", "размер", "syz", "What size do you need?"),
            ("color", "цвет", "KUL-er", "Choose a color."),
            ("brand", "марка", "brand", "This brand is popular."),
            ("cheap", "дешевый", "cheep", "The bag is cheap."),
            ("expensive", "дорогой", "ik-SPEN-siv", "That coat is expensive."),
            ("return", "возврат", "ri-TERN", "Can I return it?"),
            ("exchange", "обмен", "iks-CHAYNJ", "I need an exchange."),
            ("cashier", "кассир", "ka-SHEER", "Pay the cashier."),
            ("basket", "корзина", "BAS-kit", "Put it in the basket."),
            ("delivery", "доставка", "di-LIV-er-ee", "Delivery is free."),
            ("sale", "распродажа", "sayl", "The sale ends tonight.")
        ])

        add(.sport, [
            ("game", "игра", "gaym", "The game was close."),
            ("player", "игрок", "PLAY-er", "The player scored."),
            ("coach", "тренер", "kohch", "The coach is strict."),
            ("team", "команда", "teem", "Our team won."),
            ("score", "счет", "skor", "What is the score?"),
            ("match", "матч", "mach", "The match starts soon."),
            ("train", "тренироваться", "trayn", "They train hard."),
            ("race", "гонка", "rays", "The race was fast."),
            ("swim", "плавать", "swim", "Can you swim?"),
            ("run", "бегать", "run", "Run every morning."),
            ("jump", "прыгать", "jump", "Jump over the line."),
            ("win", "побеждать", "win", "They want to win."),
            ("lose", "проигрывать", "looz", "Nobody likes to lose."),
            ("strong", "сильный", "strong", "He is strong."),
            ("fast", "быстрый", "fast", "She runs fast."),
            ("tournament", "турнир", "TOOR-nuh-ment", "The tournament is in July.")
        ])

        add(.art, [
            ("music", "музыка", "MYOO-zik", "Music fills the room."),
            ("painting", "картина", "PAYN-ting", "The painting is bright."),
            ("drawing", "рисунок", "DRAW-ing", "Her drawing is detailed."),
            ("theater", "театр", "THEE-uh-ter", "We went to the theater."),
            ("movie", "фильм", "MOO-vee", "The movie was funny."),
            ("song", "песня", "sawng", "This song is popular."),
            ("voice", "голос", "voys", "Her voice is clear."),
            ("stage", "сцена", "stayj", "Stand on the stage."),
            ("artist", "художник", "AR-tist", "The artist signed the print."),
            ("writer", "писатель", "RY-ter", "The writer lives here."),
            ("novel", "роман", "NOV-ul", "This novel is famous."),
            ("poem", "стихотворение", "POH-em", "Read the poem aloud."),
            ("gallery", "галерея", "GAL-er-ee", "The gallery is open."),
            ("design", "дизайн", "di-ZYN", "The design is clean."),
            ("creative", "творческий", "kree-AY-tiv", "She has a creative mind."),
            ("perform", "выступать", "per-FORM", "They perform tonight.")
        ])

        add(.phrasal, [
            ("look up", "искать информацию", "look up", "Look up the word."),
            ("give up", "сдаваться", "giv up", "Do not give up."),
            ("find out", "выяснить", "fynd owt", "Find out the truth."),
            ("turn on", "включить", "tern on", "Turn on the light."),
            ("turn off", "выключить", "tern off", "Turn off the phone."),
            ("pick up", "забрать", "pik up", "Pick up the package."),
            ("put off", "отложить", "put awf", "Do not put off practice."),
            ("come back", "вернуться", "kum bak", "Come back soon."),
            ("go on", "продолжать", "goh on", "Please go on."),
            ("get along", "ладить", "get uh-LAWNG", "They get along well."),
            ("take off", "взлетать, снимать", "tayk awf", "The plane takes off."),
            ("run out", "закончиться", "run owt", "We ran out of milk."),
            ("bring up", "поднимать тему", "bring up", "Do not bring up that topic."),
            ("carry on", "продолжать", "KAR-ee on", "Carry on with the lesson."),
            ("check in", "регистрироваться", "chek in", "Check in at the hotel."),
            ("work out", "получиться, тренироваться", "werk owt", "Everything will work out.")
        ])

        return result
    }
}
