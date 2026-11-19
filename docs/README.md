# Business Central и AL — подробный модульный курс

Курс на русском для разработчика: бизнес-смысл операций, устройство учёта и расширения на AL. Названия страниц, действий, полей и объектов сохранены на английском для работы с английским интерфейсом.

## С чего начать

Прочитайте [правила обучения](0.0-how-to-study.md) и при необходимости [бухгалтерскую основу](0.1-accounting-basics.md). В каждом основном модуле есть теория, примеры, тонкости, практика и самопроверка с ответами. Все числовые примеры учебные, а не утверждения о состоянии вашей базы.

По `prompt.md` этап 1 уже пройден, этап 2 ещё не начат. Поэтому ваш текущий маршрут — [2.0. Среда AL](2.0-al-environment.md); остальные файлы можно использовать как подробный справочник.

## Этап 1. Business Central без кода

| Модуль | Содержание |
|---|---|
| [1.0. Что такое BC](1.0-what-bc-is.md) | ERP, архитектура, навигация, справочники, Number Series, Dimensions, версии |
| [1.1. Запасы и документы](1.1-inventory.md) | Item Journal, Item Ledger Entry, Value Entry, закупки, продажи, partial posting, transfers |
| [1.2. Исправления и возвраты](1.2-corrections-and-returns.md) | Undo, Credit Memo, Return Order, применение записей, Exact Cost Reversing |
| [1.3. Себестоимость и проводки](1.3-costing-and-posting.md) | FIFO, LIFO, Average, Specific, Standard, cost adjustment, Posting Groups, General Ledger |
| [1.4. Склады и ячейки](1.4-locations-and-warehouse.md) | Location, Bin, уровни склада, Receipt, Shipment, Pick, Put-away, Warehouse Entry |
| [1.5. Производство](1.5-manufacturing.md) | Production BOM, статусы, Consumption, Output, WIP, Routing, flushing |
| [1.6. Tracking и резервирование](1.6-item-tracking.md) | Lot, Serial, Reservation Entry, Tracking Specification, warehouse tracking, expiration |
| [1.7. Пользователи и доступ](1.7-users-and-permissions.md) | Лицензии, Permission Sets, Security Groups, Profile, компании и среды |

## Этап 2. Разработка на AL

| Модуль | Содержание |
|---|---|
| [2.0. Среда](2.0-al-environment.md) | app.json, launch.json, symbols, runtime, сборка, публикация, отладка |
| [2.1. Объекты](2.1-al-objects.md) | Синтаксис и типы, Table, Page, Codeunit, Enum, extensions, permissions |
| [2.2. Данные](2.2-al-data.md) | Record, фильтры, ключи, Get, FindSet, Validate, FlowFields, temporary, производительность |
| [2.3. Логика](2.3-al-logic-and-transactions.md) | Triggers, Error, Confirm, Message, Commit, TryFunction, конкурентность |
| [2.4. События](2.4-al-events.md) | Publisher, Subscriber, поиск событий, var, IsHandled, транзакционные границы |
| [2.5. Тесты](2.5-al-tests.md) | Test Codeunit, asserterror, handlers, TestPage, библиотеки, изоляция |

## Углубление и справочники

| Файл | Назначение |
|---|---|
| [3.0. PTE и AppSource](3.0-appsource-and-lifecycle.md) | Marketplace, совместимость, affix, диапазоны, schema upgrade, obsolete, анализаторы |
| [4.0. Сквозной практикум](4.0-end-to-end-labs.md) | Сценарии, прогнозы, контрольные суммы и критерии завершения |
| [4.1. Словарь и карта данных](4.1-glossary-and-data-map.md) | Термины, таблицы, связи документов и учётных записей |
| [4.2. Диагностика](4.2-troubleshooting.md) | Ошибки склада, стоимости, tracking, permissions и AL |
| [4.3. Следующие темы](4.3-advanced-topics.md) | API, фоновые задания, отчёты, интеграции, CI и границы курса |

## Версии и проверяемость

Редакция: **19 ноября 2026 года**. В файлах проекта указаны контейнер `test`, US localization, Base Application 29.1 и platform 29.0. Это сведения из ваших заметок, а не результат подключения к контейнеру при подготовке курса.

Business Central 29.0 соответствует AL runtime 18.0. Номер приложения 29.1 сам по себе не означает runtime 18.1. Сверяйте совместимость по [официальной таблице runtime](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-choosing-runtime) и возможностям целевой среды.

UI, события и сигнатуры стандартных методов зависят от версии, локализации и расширений. Окончательная проверка AL — symbols вашей среды, компиляция и тесты. Примеры в Markdown не компилировались и не запускались в вашем контейнере при подготовке этой редакции.

Темы исходного плана с отметкой `Safe to skip` вынесены в краткие углубления. Их можно отложить при первом прохождении. Курс покрывает весь исходный план и важные связи между модулями; специализированные локализации и все отраслевые возможности ERP требуют отдельного изучения.
