# Генерирует внутренние страницы из общего шаблона (head + шапка + подвал).
# Запуск:  powershell -ExecutionPolicy Bypass -File _build\make-pages.ps1
# Русский текст пишется прямо в HTML; EN/KA — в assets/js/i18n.js по ключам data-i18n.
# Шапка и подвал подставляются на клиенте из assets/js/main.js.
$ErrorActionPreference = "Stop"
$root = Split-Path $PSScriptRoot -Parent
$utf8 = New-Object System.Text.UTF8Encoding($false)

function Bc($k, $t) { "<li class=`"breadcrumb-item active`" aria-current=`"page`" data-i18n=`"$k`">$t</li>" }
function Stub($icon, $k, $text) { "<div class=`"vx-stub`"><i class=`"bi bi-$icon`"></i><p class=`"mt-3 mb-0`" data-i18n=`"$k`">$text</p></div>" }
function Svc($icon, $k, $h, $p) { "<div class=`"col-md-6`"><div class=`"vx-service`"><div class=`"vx-service__icon`"><i class=`"bi bi-$icon`"></i></div><h3 data-i18n=`"$k.t`">$h</h3><p data-i18n=`"$k.d`">$p</p></div></div>" }
function Faq($id, $q, $a, $open) {
  $btn = if ($open) { "" } else { " collapsed" }; $show = if ($open) { " show" } else { "" }
  "<div class=`"accordion-item`"><h3 class=`"accordion-header`"><button class=`"accordion-button$btn`" type=`"button`" data-bs-toggle=`"collapse`" data-bs-target=`"#$id`" data-i18n=`"$id.q`">$q</button></h3><div id=`"$id`" class=`"accordion-collapse collapse$show`" data-bs-parent=`"#faqAcc`"><div class=`"accordion-body`" data-i18n=`"$id.a`">$a</div></div></div>"
}

# $pk — префикс ключей страницы (p.<имя>): .title / .desc / .lead
function Page($file, $key, $pk, $title, $desc, $crumbs, $h1, $lead, $body, $h1attr = $null, $leadKey = $null) {
  if ($null -eq $h1attr) { $h1attr = " data-i18n=`"$pk.title`"" }
  if ($null -eq $leadKey) { $leadKey = "$pk.lead" }
  $html = @"
<!doctype html>
<html lang="ru">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title data-i18n-doc="$pk.title">$title — TBN Development</title>
  <meta name="description" content="$desc" data-i18n-content="$pk.desc">
  <meta name="theme-color" content="#0b2b45">
  <link rel="icon" href="assets/img/favicon.svg" type="image/svg+xml">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@600;700;800&family=Noto+Sans:wght@400;500;600;700&family=Noto+Sans+Georgian:wght@400;600;700;800&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <link href="assets/css/style.css" rel="stylesheet">
  <script data-goatcounter="https://olegi808.goatcounter.com/count" async src="https://gc.zgo.at/count.js"></script>
</head>
<body data-page="$key">
  <a class="visually-hidden-focusable position-absolute top-0 start-0 m-2 btn btn-primary btn-sm" href="#main" data-i18n="ui.skip">Перейти к содержимому</a>
  <div data-include="header"></div>

  <main id="main">
    <section class="vx-page-head">
      <div class="vx-hero__grid"></div>
      <div class="container position-relative">
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb mb-3">
            <li class="breadcrumb-item"><a href="index.html" data-i18n="nav.home">Главная</a></li>
            $crumbs
          </ol>
        </nav>
        <h1 class="mb-3"$h1attr>$h1</h1>
        <p class="lead opacity-75 mb-0" style="max-width:42rem" data-i18n="$leadKey">$lead</p>
      </div>
    </section>
$body
  </main>

  <div data-include="footer"></div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="assets/js/i18n.js"></script>
  <script src="assets/js/data.js"></script>
  <script src="assets/js/main.js"></script>
</body>
</html>
"@
  [IO.File]::WriteAllText((Join-Path $root $file), $html, $utf8)
  Write-Output "OK $file"
}

# ---------- Проекты ----------
Page "projects.html" "projects" "p.projects" "Проекты" "Жилые комплексы TBN Development в Тбилиси: в продаже и реализованные." (Bc "p.projects.title" "Проекты") "Проекты" "Многоэтажные жилые комплексы рядом с метро — в продаже и реализованные." @"
    <section class="vx-section">
      <div class="container">
        <div class="vx-filter d-flex flex-wrap gap-2 mb-4" data-filter role="group" aria-label="Фильтр проектов" data-i18n-aria="flt.aria">
          <button class="btn active" data-value="all" type="button" data-i18n="flt.all">Все</button>
          <button class="btn" data-value="active" type="button" data-i18n="flt.active">В продаже</button>
          <button class="btn" data-value="done" type="button" data-i18n="flt.done">Реализованные</button>
        </div>
        <div class="row g-4" data-projects></div>
        <div class="mt-5">$(Stub "map" "stub.map" "Здесь будет интерактивная карта объектов (Google Maps / Leaflet) со станциями метро и фильтром по площади и цене.")</div>
      </div>
    </section>
"@

# ---------- Проект (детальная, по ?id=) ----------
Page "project.html" "projects" "p.project" "Проект" "Описание жилого проекта TBN Development." `
  "<li class=`"breadcrumb-item`"><a href=`"projects.html`" data-i18n=`"nav.projects`">Проекты</a></li><li class=`"breadcrumb-item active`" aria-current=`"page`" data-p=`"title`"></li>" `
  "<span data-p=`"title`"></span>" "<span data-p=`"summary`"></span>" @"
    <section class="vx-section" data-project-detail>
      <div class="container">
        <div class="row g-4 g-lg-5">
          <div class="col-lg-7">
            <div class="rounded-4 overflow-hidden mb-4" style="aspect-ratio:4/3" data-visual></div>
            $(Stub "images" "stub.gallery" "Галерея фото и рендеров, ход строительства по месяцам, веб-камера с объекта.")
            <h2 class="h4 fw-bold mt-5 mb-3" data-i18n="pr.layouts">Планировки</h2>
            $(Stub "grid-3x3" "stub.layouts" "Шахматка квартир и планировки с ценами — подключается из CRM или таблицы.")
          </div>
          <div class="col-lg-5">
            <div class="vx-spec mb-4" data-spec></div>
            <h2 class="h5 fw-bold mb-3" data-i18n="pr.features">Особенности</h2>
            <ul class="vx-check mb-4" data-features></ul>
            <a href="index.html#lead" class="btn btn-primary w-100 mb-2" data-i18n="pr.cta">Узнать о свободных квартирах</a>
            <a href="tel:+995568408080" class="btn btn-outline-dark w-100"><i class="bi bi-telephone me-2"></i>+995 568 40 80 80</a>
          </div>
        </div>
      </div>
    </section>
"@ "" "-"

# ---------- О компании ----------
Page "about.html" "about" "p.about" "О компании" "TBN Development — девелопер жилых комплексов в Тбилиси с 2014 года." (Bc "p.about.title" "О компании") "О компании" "TBN Development с 2014 года строит жилые комплексы рядом с метро в Тбилиси." @"
    <section class="vx-section">
      <div class="container">
        <div class="row g-4 g-lg-5">
          <div class="col-lg-7">
            <h2 class="h3 fw-bold mb-3" data-i18n="ab.who">Кто мы</h2>
            <p data-i18n="ab.p1">TBN Development — бренд ООО «Тибин Груп» (შპს „თიბინ ჯგუფი“), основанного в Тбилиси в 2014 году. Компания строит многофункциональные жилые комплексы и общественные здания: от выбора участка и проектирования до строительства, продаж и сдачи дома.</p>
            <p data-i18n="ab.p2">Среди наших объектов — TBN Akhmeteli, 15-этажный дом на 120 квартир напротив Gldani Mall, и TBN Varketili, 14-этажный комплекс на 224 квартиры в трёх минутах от метро «Варкетили». В каждом проекте — подземный паркинг, детская площадка и прозрачные условия покупки с рассрочкой от застройщика.</p>
            <div class="mt-5">$(Stub "people" "stub.team" "Блок «Команда»: руководство, инженеры, отдел продаж — фото и краткие биографии.")</div>
            <div class="mt-4">$(Stub "camera-video" "stub.certs" "Разрешения на строительство, банки-партнёры, реализованные проекты по годам, веб-камеры с объектов.")</div>
          </div>
          <div class="col-lg-5">
            <div class="vx-spec">
              <div><small data-i18n="ab.k1">На рынке</small><strong data-i18n="ab.v1">с 2014 года</strong></div>
              <div><small data-i18n="ab.k2">Квартир</small><strong>344</strong></div>
              <div><small data-i18n="ab.k3">Специализация</small><strong data-i18n="ab.v3">Многоэтажное жильё</strong></div>
              <div><small data-i18n="ab.k4">Районы</small><strong data-i18n="ab.v4">Варкетили, Глдани</strong></div>
              <div><small data-i18n="ab.k5">Языки</small><strong>GE · EN · RU</strong></div>
            </div>
          </div>
        </div>
      </div>
    </section>
"@

# ---------- Услуги ----------
Page "services.html" "services" "p.services" "Услуги" "Жилые комплексы, коммерческие помещения, управление проектами и ремонт в Тбилиси." (Bc "p.services.title" "Услуги") "Услуги" "Полный цикл: от участка и проекта до строительства, продаж и сдачи дома." @"
    <section class="vx-section">
      <div class="container">
        <div class="row g-4">
          $(Svc "buildings" "svc.design" "Жилые комплексы" "Многоэтажные монолитные дома с продуманными планировками от 43 м².")
          $(Svc "shop" "svc.build" "Коммерция" "Помещения под магазины, офисы и сервисы на нижних этажах наших домов.")
          $(Svc "clipboard-check" "svc.finish" "Управление проектом" "Технический надзор, сроки и бюджет под контролем на всём цикле стройки.")
          $(Svc "tools" "svc.repair" "Ремонт" "Отделка квартир и реконструкция жилых и коммерческих помещений.")
        </div>
        <div class="mt-5">$(Stub "file-earmark-text" "stub.services" "Отдельные страницы: аренда и продажа коммерции, парковочные места, строительство для партнёров.")</div>
      </div>
    </section>
"@

# ---------- Новости ----------
Page "news.html" "news" "p.news" "Новости и статьи" "Новости TBN Development и статьи о покупке жилья в Тбилиси." (Bc "p.news.title" "Новости и статьи") "Новости и статьи" "Новости строительства, старт продаж и полезные материалы для покупателей." @"
    <section class="vx-section">
      <div class="container">
        <div class="alert alert-warning small"><i class="bi bi-info-circle me-2"></i><span data-i18n="news.demo">Первый материал взят со старого сайта tbn.ge, остальные — шаблонные примеры. Замените их на реальные новости компании в <code>assets/js/data.js</code>.</span></div>
        <div class="row g-4" data-news></div>
        <div class="mt-5">$(Stub "funnel" "stub.news" "Фильтр по рубрикам, поиск, пагинация, подписка на рассылку.")</div>
      </div>
    </section>
"@

# ---------- Статья (по ?id=) ----------
Page "article.html" "news" "p.article" "Статья" "Материал TBN Development." `
  "<li class=`"breadcrumb-item`"><a href=`"news.html`" data-i18n=`"p.news.title`">Новости и статьи</a></li><li class=`"breadcrumb-item active`" aria-current=`"page`" data-i18n=`"art.crumb`">Материал</li>" `
  "" "" @"
    <section class="vx-section" data-article>
      <div class="container" style="max-width:820px">
        <div class="small text-secondary mb-3" data-a-meta></div>
        <p class="lead" data-a-lead></p>
        <div class="rounded-4 overflow-hidden my-4" style="aspect-ratio:16/9" data-a-visual></div>
        $(Stub "pencil-square" "stub.article" "Тело статьи из CMS: текст, фото, цитаты, блок «Читайте также».")
        <a href="news.html" class="btn btn-outline-dark mt-4"><i class="bi bi-arrow-left me-2"></i><span data-i18n="art.back">Ко всем материалам</span></a>
      </div>
    </section>
"@ " data-a-title" "-"

# ---------- Покупателям ----------
Page "buyers.html" "buyers" "p.buyers" "Покупателям" "Рассрочка, ипотека и ответы на вопросы покупателей." (Bc "p.buyers.title" "Покупателям") "Покупателям" "Условия покупки: внутренняя рассрочка, ипотека банков-партнёров, оформление сделки." @"
    <section class="vx-section">
      <div class="container">
        <div class="row g-4 mb-5">
          $(Svc "cash-coin" "by.inst" "Рассрочка" "Первый взнос от 30%, остаток — до 30 месяцев без процентов и без банка.")
          $(Svc "bank" "by.mort" "Ипотека" "Оформление через банки-партнёры. Условия уточняйте у менеджера.")
        </div>
        <h2 class="h4 fw-bold mb-3" id="faq" data-i18n="by.faq">Частые вопросы</h2>
        <div class="accordion" id="faqAcc">
          $(Faq "q1" "Что значит «чёрный каркас»?" "Квартира сдаётся без отделки: стены и перекрытия, окна, входная дверь и подведённые коммуникации. Ремонт вы делаете под свой вкус." $true)
          $(Faq "q2" "Может ли иностранец купить квартиру в Грузии?" "Да, нерезиденты могут приобретать жилую недвижимость. Право собственности регистрируется в Национальном агентстве публичного реестра." $false)
          $(Faq "q3" "Можно ли следить за стройкой?" "Да. На наших объектах установлены веб-камеры, а менеджер организует показ дома." $false)
        </div>
      </div>
    </section>
"@

# ---------- Контакты ----------
Page "contacts.html" "contacts" "p.contacts" "Контакты" "Офис TBN Development: Тбилиси, ул. Т. Шешелидзе, 124. Телефон и WhatsApp." (Bc "p.contacts.title" "Контакты") "Контакты" "Приезжайте в офис или позвоните — ответим на грузинском, английском или русском." @"
    <section class="vx-section">
      <div class="container">
        <div class="row g-4 g-lg-5">
          <div class="col-lg-5">
            <ul class="vx-check">
              <li><i class="bi bi-geo-alt"></i><span><strong data-i18n="ct.addr">Адрес</strong><br><span data-i18n="ui.address">Тбилиси, ул. Т. Шешелидзе, 124 (Глдани)</span></span></li>
              <li><i class="bi bi-telephone"></i><span><strong data-i18n="ct.phones">Телефон</strong><br><a href="tel:+995568408080">+995 568 40 80 80</a></span></li>
              <li><i class="bi bi-whatsapp"></i><span><strong>WhatsApp</strong><br><a href="https://wa.me/995568408080" target="_blank" rel="noopener">+995 568 40 80 80</a></span></li>
              <li><i class="bi bi-envelope"></i><span><strong data-i18n="ct.email">Email</strong><br><a href="mailto:info@tbn.ge">info@tbn.ge</a></span></li>
              <li><i class="bi bi-clock"></i><span><strong data-i18n="ct.hours">Часы работы</strong><br><span data-i18n="ui.hours">Пн–Пт, 10:00–19:00</span></span></li>
            </ul>
            <a href="index.html#lead" class="btn btn-primary mt-4" data-i18n="ct.btn">Оставить заявку</a>
          </div>
          <div class="col-lg-7">
            <div class="ratio ratio-4x3 rounded-4 overflow-hidden border">
              <iframe title="Офис TBN Development на карте" data-i18n-title="ct.map" src="https://www.google.com/maps?q=41.79012,44.81297&z=15&output=embed" loading="lazy" referrerpolicy="no-referrer-when-downgrade" style="border:0"></iframe>
            </div>
          </div>
        </div>
      </div>
    </section>
"@

# ---------- Заглушки ----------
Page "careers.html" "careers" "p.careers" "Вакансии" "Работа в TBN Development" (Bc "p.careers.title" "Вакансии") "Вакансии" "Страница в разработке." "    <section class=`"vx-section`"><div class=`"container`">$(Stub 'people' 'stub.careers' 'Раздел вакансий: открытые позиции и форма отклика.')</div></section>" $null "p.wip"
Page "privacy.html" "privacy" "p.privacy" "Политика конфиденциальности" "Политика обработки персональных данных" (Bc "p.privacy.title" "Политика конфиденциальности") "Политика конфиденциальности" "Страница в разработке." "    <section class=`"vx-section`"><div class=`"container`">$(Stub 'shield-lock' 'stub.privacy' 'Текст политики обработки персональных данных (согласовать с юристом).')</div></section>" $null "p.wip"
Page "404.html" "" "p.404" "Страница не найдена" "Страница не найдена" (Bc "p.404.title" "404") "Страница не найдена" "Возможно, она переехала или ещё строится." "    <section class=`"vx-section`"><div class=`"container text-center`"><a href=`"index.html`" class=`"btn btn-primary`" data-i18n=`"e.home`">На главную</a> <a href=`"projects.html`" class=`"btn btn-outline-dark ms-2`" data-i18n=`"e.projects`">К проектам</a></div></section>"
