/* ==========================================================================
   Контент сайта. Чтобы добавить объект или новость — допишите элемент в массив.
   Карточки на главной, в каталоге и детальные страницы строятся отсюда.
   Позже этот файл легко заменить на запрос к API / CMS (JSON той же структуры).

   Источники фактов: tbn.ge (старый сайт), geoln.com (объекты 603 и tbn-varketili),
   madloba.info (ноябрь 2026). Перед публикацией сверьте цифры и статусы с компанией.
   ========================================================================== */

/* Текстовые поля — объекты { ru, en, ka }. Если перевода нет, показывается ru. */
window.TBN = {
  company: {
    name: "TBN Development",
    since: 2014,
    mapUrl: "https://www.google.com/maps?q=41.79012,44.81297",
    phones: ["+995 568 40 80 80"],
    email: "info@tbn.ge",          /* ⚠ уточнить у компании: на старом сайте почты нет */
    facebook: null                 /* ссылки на соцсети не найдены — добавить, когда будут */
    /* адрес, часы работы и юр. название — в assets/js/i18n.js (ui.address, ui.hours, ft.legal) */
  },

  /* status: "active" — строится/в продаже, "done" — сдан. Первые 3 показываются на главной. */
  projects: [
    {
      id: "varketili",
      title: "TBN Varketili",
      district: { ru: "Варкетили, ул. Петре Хведелидзе, 8", en: "Varketili, 8 Petre Khvedelidze St", ka: "ვარკეთილი, პეტრე ხვედელიძის ქ. 8" },
      status: "active",
      statusLabel: { ru: "В продаже", en: "On sale", ka: "იყიდება" },
      year: "2025",
      floors: 14,
      apartments: 224,
      area: { ru: "от 43,7 м²", en: "from 43.7 m²", ka: "43,7 მ²-დან" },
      price: { ru: "от $1 150 / м²", en: "from $1,150 / m²", ka: "$1 150-დან / მ²" },
      summary: {
        ru: "14-этажный монолитный жилой комплекс на 224 квартиры в трёх минутах ходьбы от метро «Варкетили». Подземный паркинг, детская площадка и ресепшен в доме.",
        en: "A 14-storey monolithic residential complex with 224 apartments, a three-minute walk from Varketili metro station. Underground parking, a playground and a staffed reception.",
        ka: "14-სართულიანი მონოლითური საცხოვრებელი კომპლექსი 224 ბინით, მეტრო „ვარკეთილიდან“ სამ წუთში. მიწისქვეშა პარკინგი, საბავშვო მოედანი და რეცეფცია."
      },
      features: {
        ru: ["Монолитный железобетонный каркас", "3 минуты пешком до метро «Варкетили»", "Квартиры от 43,7 м²", "Сдача в «чёрном каркасе»", "Подземный паркинг", "Детская площадка во дворе", "Ресепшен в доме", "Ипотека банков-партнёров"],
        en: ["Monolithic reinforced-concrete frame", "3-minute walk to Varketili metro", "Apartments from 43.7 m²", "Delivered as “black frame”", "Underground parking", "Playground in the courtyard", "Staffed reception", "Mortgage from partner banks"],
        ka: ["მონოლითური რკინაბეტონის კარკასი", "3 წუთი ფეხით მეტრო „ვარკეთილამდე“", "ბინები 43,7 მ²-დან", "ჩაბარება „შავ კარკასში“", "მიწისქვეშა პარკინგი", "საბავშვო მოედანი ეზოში", "რეცეფცია შენობაში", "იპოთეკა პარტნიორი ბანკებისგან"]
      },
      palette: ["#e9eef3", "#f39200"]
    },
    {
      id: "akhmeteli",
      title: "TBN Akhmeteli",
      district: { ru: "Глдани-Надзаладеви, ул. Шешелидзе, 124", en: "Gldani-Nadzaladevi, 124 Sheshelidze St", ka: "გლდანი-ნაძალადევი, შეშელიძის ქ. 124" },
      status: "done",
      statusLabel: { ru: "Реализован", en: "Completed", ka: "დასრულებული" },
      year: "2020",
      floors: 15,
      apartments: 120,
      area: { ru: "от 45,5 м²", en: "from 45.5 m²", ka: "45,5 მ²-დან" },
      price: { ru: "от $1 785 / м²", en: "from $1,785 / m²", ka: "$1 785-დან / მ²" },
      summary: {
        ru: "15-этажный дом премиум-класса на 120 квартир напротив Gldani Mall, рядом с метро «Театр Ахметели». Два этажа коммерции и двухуровневый подземный паркинг.",
        en: "A 15-storey premium residential building with 120 apartments opposite Gldani Mall, near Akhmeteli Theatre metro. Two commercial floors and a two-level underground car park.",
        ka: "15-სართულიანი პრემიუმ კლასის საცხოვრებელი სახლი 120 ბინით, გლდანი მოლის პირდაპირ, მეტრო „ახმეტელის თეატრთან“ ახლოს. ორი კომერციული სართული და ორდონიანი მიწისქვეშა პარკინგი."
      },
      features: {
        ru: ["Монолитный каркас, 15 этажей", "Потолки 3,0 м", "2 лифта", "Двухуровневый подземный паркинг", "Коммерческие помещения на двух этажах", "Домофон и видеонаблюдение", "Детская площадка; рядом школа, детсад, супермаркет", "Рассрочка: от 30% взноса, до 30 месяцев"],
        en: ["Monolithic frame, 15 floors", "3.0 m ceilings", "2 elevators", "Two-level underground parking", "Commercial premises on two floors", "Intercom and CCTV", "Playground; school, kindergarten and supermarket nearby", "Installments: from 30% down, up to 30 months"],
        ka: ["მონოლითური კარკასი, 15 სართული", "ჭერი 3,0 მ", "2 ლიფტი", "ორდონიანი მიწისქვეშა პარკინგი", "კომერციული ფართები ორ სართულზე", "დომოფონი და ვიდეოთვალთვალი", "საბავშვო მოედანი; ახლოს სკოლა, ბაღი, სუპერმარკეტი", "განვადება: 30%-იანი შენატანიდან, 30 თვემდე"]
      },
      palette: ["#f1f4f7", "#005080"]
    }
  ],

  /* Новости / статьи. Первая — реальная (со старого tbn.ge), остальные — шаблонные
     примеры (demo: true): замените на реальные материалы компании перед запуском. */
  news: [
    {
      id: "akhmeteli-start",
      date: "2020-10-05",
      tag: { ru: "Новости", en: "News", ka: "სიახლეები" },
      title: {
        ru: "Новый жилой дом у метро «Театр Ахметели»",
        en: "New residential building near Akhmeteli Theatre metro",
        ka: "ახალი საცხოვრებელი სახლი მეტრო „ახმეტელის თეატრთან“"
      },
      excerpt: {
        ru: "TBN Development строит 15-этажный дом на 120 квартир на ул. Шешелидзе, 124 — с коммерцией на первых этажах и двухуровневым подземным паркингом.",
        en: "TBN Development is building a 15-storey, 120-apartment building at 124 Sheshelidze St, with retail on the lower floors and a two-level underground car park.",
        ka: "TBN Development აშენებს 15-სართულიან, 120-ბინიან სახლს შეშელიძის ქ. 124-ში — კომერციული ფართებით ქვედა სართულებზე და ორდონიანი მიწისქვეშა პარკინგით."
      }
    },
    {
      id: "varketili-sales",
      date: "2025-07-10",
      tag: { ru: "Новости", en: "News", ka: "სიახლეები" },
      title: {
        ru: "Открыты продажи в TBN Varketili",
        en: "Sales open at TBN Varketili",
        ka: "TBN Varketili-ში გაყიდვები დაიწყო"
      },
      excerpt: {
        ru: "224 квартиры от 43,7 м² в трёх минутах от метро «Варкетили». Цены — от $1 150 за квадратный метр.",
        en: "224 apartments from 43.7 m², three minutes from Varketili metro. Prices from $1,150 per square metre.",
        ka: "224 ბინა 43,7 მ²-დან, მეტრო „ვარკეთილიდან“ სამ წუთში. ფასი — $1 150-დან კვადრატულ მეტრზე."
      },
      demo: true
    },
    {
      id: "black-frame",
      date: "2026-03-02",
      tag: { ru: "Статьи", en: "Articles", ka: "სტატიები" },
      title: {
        ru: "Квартира в «чёрном каркасе»: что вы получаете и сколько стоит ремонт",
        en: "A “black frame” apartment: what you get and what renovation costs",
        ka: "ბინა „შავ კარკასში“: რას იღებთ და რა ღირს რემონტი"
      },
      excerpt: {
        ru: "Разбираем, что входит в «чёрный каркас» в новостройках Тбилиси и как спланировать бюджет на отделку.",
        en: "What a “black frame” apartment includes in Tbilisi new builds, and how to budget for finishing.",
        ka: "რას მოიცავს „შავი კარკასი“ თბილისის ახალაშენებულ სახლებში და როგორ დავგეგმოთ მოპირკეთების ბიუჯეტი."
      },
      demo: true
    }
  ]
};

/* --------------------------------------------------------------------------
   Иллюстрации-заглушки (SVG), пока нет фотографий объектов.
   Чтобы поставить реальное фото — добавьте в объект поле image: "assets/img/xxx.jpg".
   -------------------------------------------------------------------------- */
window.TBN.buildingSVG = function (floors, palette, seed) {
  const [wall, accent] = palette || ["#e9eef3", "#f39200"];
  const W = 400, H = 300;
  const f = Math.max(4, Math.min(floors || 9, 16));
  const fh = 200 / f;
  const bw = 150;
  const bx = (W - bw) / 2 + ((seed || 0) % 2 ? 30 : -30);
  const by = 262 - f * fh;
  let win = "";
  const cols = 6, cw = bw / cols;
  for (let r = 0; r < f; r++) {
    for (let c = 0; c < cols; c++) {
      const x = bx + c * cw + cw * 0.2, y = by + r * fh + fh * 0.22;
      win += `<rect x="${x.toFixed(1)}" y="${y.toFixed(1)}" width="${(cw * 0.6).toFixed(1)}" height="${(fh * 0.52).toFixed(1)}" rx="1" fill="#1e3a55" opacity="${(0.5 + ((r * 7 + c * 3 + (seed || 0)) % 5) * 0.09).toFixed(2)}"/>`;
    }
  }
  /* второй, более низкий корпус */
  const f2 = Math.max(3, Math.round(f * 0.6)), b2x = bx + ((seed || 0) % 2 ? -95 : bw + 5), b2y = 262 - f2 * fh;
  let win2 = "";
  for (let r = 0; r < f2; r++) for (let c = 0; c < 3; c++)
    win2 += `<rect x="${(b2x + 8 + c * 28).toFixed(1)}" y="${(b2y + r * fh + fh * 0.22).toFixed(1)}" width="16" height="${(fh * 0.5).toFixed(1)}" fill="#1e3a55" opacity=".55"/>`;
  return `<svg viewBox="0 0 ${W} ${H}" preserveAspectRatio="xMidYMid slice" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
    <defs><linearGradient id="sky${seed}" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#cfe3f3"/><stop offset="1" stop-color="#f4f7fa"/></linearGradient></defs>
    <rect width="${W}" height="${H}" fill="url(#sky${seed})"/>
    <path d="M0 215 Q90 175 180 205 T400 195 V300 H0Z" fill="#d9e3ec"/>
    <rect x="${b2x}" y="${b2y}" width="90" height="${f2 * fh}" fill="#dde5ec"/>${win2}
    <rect x="${bx}" y="${by}" width="${bw}" height="${f * fh}" fill="${wall}"/>
    <rect x="${bx}" y="${by}" width="${cw * 0.9}" height="${f * fh}" fill="${accent}" opacity=".92"/>
    ${win}
    <rect x="${bx - 4}" y="${by - 5}" width="${bw + 8}" height="5" fill="#0b2b45"/>
    <rect x="${bx}" y="${262 - fh * 1.6}" width="${bw}" height="${fh * 1.6}" fill="#0b2b45" opacity=".85"/>
    <rect x="0" y="262" width="${W}" height="38" fill="#c3ced8"/>
    <circle cx="${bx - 40}" cy="246" r="15" fill="#86a874"/><rect x="${bx - 41.5}" y="252" width="3" height="12" fill="#6b5a48"/>
  </svg>`;
};

/* Большая иллюстрация для первого экрана: башня, корпус, кран и метро */
window.TBN.heroSVG = function () {
  let w = "";
  for (let r = 0; r < 15; r++) for (let c = 0; c < 5; c++)
    w += `<rect x="${118 + c * 26}" y="${92 + r * 24}" width="15" height="13" fill="#5aaee6" opacity="${(0.25 + ((r * 3 + c * 5) % 7) * 0.09).toFixed(2)}"/>`;
  let w2 = "";
  for (let r = 0; r < 9; r++) for (let c = 0; c < 3; c++)
    w2 += `<rect x="${268 + c * 24}" y="${236 + r * 24}" width="13" height="12" fill="#5aaee6" opacity="${(0.2 + ((r + c * 2) % 5) * 0.1).toFixed(2)}"/>`;
  let stripes = "";
  for (let i = 0; i < 6; i++) stripes += `<rect x="${108 + i * 9}" y="${44 + i * 4}" width="4" height="${44 - i * 4}" fill="#fff" opacity=".9"/>`;
  return `<svg viewBox="0 0 400 500" preserveAspectRatio="xMidYMid slice" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
    <defs>
      <linearGradient id="hsky" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#0f3d62"/><stop offset="1" stop-color="#16507d"/></linearGradient>
      <linearGradient id="htower" x1="0" y1="0" x2="1" y2="0"><stop offset="0" stop-color="#123b5c"/><stop offset="1" stop-color="#0b2b45"/></linearGradient>
    </defs>
    <rect width="400" height="500" fill="url(#hsky)"/>
    <circle cx="320" cy="90" r="46" fill="#f39200" opacity=".9"/>
    <g stroke="#f39200" stroke-width="3" fill="none" opacity=".85">
      <path d="M355 470 V40"/><path d="M300 40 H395"/><path d="M355 40 L375 60"/><path d="M370 40 V120"/>
    </g>
    <rect x="365" y="120" width="10" height="12" fill="#f39200"/>
    <path d="M100 90 L180 40 L240 90Z" fill="#f39200"/>
    ${stripes}
    <rect x="104" y="88" width="142" height="382" fill="url(#htower)"/>
    <rect x="104" y="88" width="8" height="382" fill="#f39200"/>
    ${w}
    <rect x="258" y="226" width="86" height="244" fill="#0e3352"/>
    ${w2}
    <rect x="0" y="470" width="400" height="30" fill="#082136"/>
    <g transform="translate(46 300)">
      <circle r="24" fill="#d7262e"/><text x="0" y="9" text-anchor="middle" font-family="Montserrat, sans-serif" font-weight="800" font-size="26" fill="#fff">M</text>
    </g>
    <rect x="44" y="324" width="4" height="146" fill="#c9d4de"/>
  </svg>`;
};

/* Иллюстрация-заглушка для новостей */
window.TBN.newsSVG = function (i) {
  const tones = [["#0b2b45", "#f39200"], ["#0f3d62", "#5aaee6"], ["#f39200", "#0b2b45"]][i % 3];
  return `<svg viewBox="0 0 320 180" preserveAspectRatio="xMidYMid slice" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
    <rect width="320" height="180" fill="${tones[0]}"/>
    <g stroke="${tones[1]}" stroke-width="2" fill="none" opacity=".8">
      <path d="M60 150 V40 H130 V150"/><path d="M130 150 V80 H190 V150"/><path d="M200 150 V55 H250 V150"/><path d="M20 150 H300"/>
    </g>
    <g fill="${tones[1]}" opacity=".4">
      <rect x="72" y="55" width="12" height="10"/><rect x="104" y="55" width="12" height="10"/><rect x="72" y="80" width="12" height="10"/><rect x="104" y="80" width="12" height="10"/>
      <rect x="72" y="105" width="12" height="10"/><rect x="104" y="105" width="12" height="10"/><rect x="145" y="95" width="30" height="10"/><rect x="145" y="118" width="30" height="10"/>
      <rect x="212" y="70" width="26" height="9"/><rect x="212" y="92" width="26" height="9"/><rect x="212" y="114" width="26" height="9"/>
    </g>
  </svg>`;
};
