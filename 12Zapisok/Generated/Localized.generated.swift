// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen
// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length
// swiftlint:disable foundation_using

import Foundation

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
internal enum Localized {
  /// Разрешить
  internal static let allow = Localized.tr("Localizable", "ALLOW")
  /// Сменить город
  internal static let changeCity = Localized.tr("Localizable", "CHANGE_CITY")
  /// Передумал
  internal static let changeMind = Localized.tr("Localizable", "CHANGE_MIND")
  /// Выбрать город
  internal static let chooseCity = Localized.tr("Localizable", "CHOOSE_CITY")
  /// Выберите один из городов для начала игры
  internal static let chooseCityDescription = Localized.tr("Localizable", "CHOOSE_CITY_DESCRIPTION")
  /// Город не выбран
  internal static let cityNotChosen = Localized.tr("Localizable", "CITY_NOT_CHOSEN")
  /// Поздравляем
  internal static let congrats = Localized.tr("Localizable", "CONGRATS")
  /// Продолжить
  internal static let `continue` = Localized.tr("Localizable", "CONTINUE")
  /// текущий выбранный город
  internal static let currentCity = Localized.tr("Localizable", "CURRENT_CITY")
  /// Очень жаль, но возникли проблемы с загрузкой городов для игры, попробуйте еще раз
  internal static let emptyCityError = Localized.tr("Localizable", "EMPTY_CITY_ERROR")
  /// Хм, города должны были отобразиться.. попробуйте позже
  internal static let emptyCityMain = Localized.tr("Localizable", "EMPTY_CITY_MAIN")
  /// Похоже, что у нас проблемы с загрузкой, попробуем еще раз?
  internal static let emptyGameError = Localized.tr("Localizable", "EMPTY_GAME_ERROR")
  /// Извините, похоже есть проблема с загрузкой записок
  internal static let emptyGameMain = Localized.tr("Localizable", "EMPTY_GAME_MAIN")
  /// Похоже, что у нас проблемы с загрузкой, попробуем еще раз?
  internal static let emptyLeadError = Localized.tr("Localizable", "EMPTY_LEAD_ERROR")
  /// Кажется, в этом городе еще никто ничего не искал \n\nБудьте первым!
  internal static let emptyLeadMain = Localized.tr("Localizable", "EMPTY_LEAD_MAIN")
  /// Упс, статистика где-то потерялась, попробуем еще раз?
  internal static let emptyStatsError = Localized.tr("Localizable", "EMPTY_STATS_ERROR")
  /// Кажется, что вы еще не начинали играть \n\nВперед!
  internal static let emptyStatsMain = Localized.tr("Localizable", "EMPTY_STATS_MAIN")
  /// Найди как можно скорее
  internal static let findAsSoon = Localized.tr("Localizable", "FIND_AS_SOON")
  /// Но уже близко
  internal static let hintAlreadyClose = Localized.tr("Localizable", "HINT_ALREADY_CLOSE")
  /// До всех записок навсегда
  internal static let hintDistanceToAll = Localized.tr("Localizable", "HINT_DISTANCE_TO_ALL")
  /// Расстояние до одной записки
  internal static let hintDistanceToOne = Localized.tr("Localizable", "HINT_DISTANCE_TO_ONE")
  /// Возможность вводить адрес без посещения
  internal static let hintManualInput = Localized.tr("Localizable", "HINT_MANUAL_INPUT")
  /// Очередная записка за Вашими плечами
  internal static let hintOpen = Localized.tr("Localizable", "HINT_OPEN")
  /// Открыть одну записку
  internal static let hintOpenOne = Localized.tr("Localizable", "HINT_OPEN_ONE")
  /// Восстановить покупки
  internal static let hintRestoreAll = Localized.tr("Localizable", "HINT_RESTORE_ALL")
  /// Показать точку на карте
  internal static let hintShowMapPin = Localized.tr("Localizable", "HINT_SHOW_MAP_PIN")
  /// Вы уверены, что хотите купить эту подсказку?
  internal static let hintSureToBuy = Localized.tr("Localizable", "HINT_SURE_TO_BUY")
  /// Использовать подсказку?
  internal static let hintUse = Localized.tr("Localizable", "HINT_USE")
  /// В текущих поисках
  internal static let inCurrentSearch = Localized.tr("Localizable", "IN_CURRENT_SEARCH")
  /// Начальный
  internal static let levelBeginner = Localized.tr("Localizable", "LEVEL_BEGINNER")
  /// Теплее, уже ближе
  internal static let locStatusAverage = Localized.tr("Localizable", "LOC_STATUS_AVERAGE")
  /// Жарко, очень рядом
  internal static let locStatusClose = Localized.tr("Localizable", "LOC_STATUS_CLOSE")
  /// Холодно, бррр..
  internal static let locStatusFar = Localized.tr("Localizable", "LOC_STATUS_FAR")
  /// Место неизвестно
  internal static let locationUnknown = Localized.tr("Localizable", "LOCATION_UNKNOWN")
  /// Далее
  internal static let next = Localized.tr("Localizable", "NEXT")
  /// Нет
  internal static let no = Localized.tr("Localizable", "NO")
  /// Недоступна
  internal static let notAvailable = Localized.tr("Localizable", "NOT_AVAILABLE")
  /// Кажется, что вы еще не начинали играть \n\nВперед!
  internal static let notStartedGame = Localized.tr("Localizable", "NOT_STARTED_GAME")
  /// Записка #%@
  internal static func noteNumber(_ p1: String) -> String {
    return Localized.tr("Localizable", "NOTE_NUMBER", p1)
  }
  /// Доступ к геолокации
  internal static let onboardingAccessGeo = Localized.tr("Localizable", "ONBOARDING_ACCESS_GEO")
  /// Мы заметили, что Вы запретили геолокацию, в этом случае выберите город из списка для начала игры
  internal static let onboardingAccessGeoDenied = Localized.tr("Localizable", "ONBOARDING_ACCESS_GEO_DENIED")
  /// Позволит точнее определить Ваше местоположение и облегчит игру
  internal static let onboardingAccessGeoDsc = Localized.tr("Localizable", "ONBOARDING_ACCESS_GEO_DSC")
  /// Войти
  internal static let onboardingAuth = Localized.tr("Localizable", "ONBOARDING_AUTH")
  /// Авторизируйтесь для сохранения прогресса и участия в общем рейтиге игроков
  internal static let onboardingAuthDsc = Localized.tr("Localizable", "ONBOARDING_AUTH_DSC")
  /// Выберете Ваш город
  internal static let onboardingChooseCity = Localized.tr("Localizable", "ONBOARDING_CHOOSE_CITY")
  /// Вернитесь в детство
  internal static let onboardingGoChildhood = Localized.tr("Localizable", "ONBOARDING_GO_CHILDHOOD")
  /// Сыграйте в увлекательную игру, где Вам предстоит собрать 12 записок спрятанных в Вашем городе
  internal static let onboardingGoChildhoodDsc = Localized.tr("Localizable", "ONBOARDING_GO_CHILDHOOD_DSC")
  /// Ведите прогресс
  internal static let onboardingLeadProgress = Localized.tr("Localizable", "ONBOARDING_LEAD_PROGRESS")
  /// Правильно ли мы определили Ваш город?
  internal static let onboardingRightCity = Localized.tr("Localizable", "ONBOARDING_RIGHT_CITY")
  /// Открыта 
  internal static let `open` = Localized.tr("Localizable", "OPEN")
  /// Повторить
  internal static let repeate = Localized.tr("Localizable", "REPEATE")
  /// И напоследок
  internal static let rulesLast = Localized.tr("Localizable", "RULES_LAST")
  /// Играть можно: на природе, в офисе, в музее и кафе, по городу, дома.
  internal static let rulesLastDsc = Localized.tr("Localizable", "RULES_LAST_DSC")
  /// Основное правило
  internal static let rulesMain = Localized.tr("Localizable", "RULES_MAIN")
  /// Игрок получает записку №1, в которой зашифровано место, где находится следующая записка. Всего их 12 штук, чтобы найти следующую, необходимо расшифровать предыдущую. Это старая игра, ставшая прототипом популярных квестов.
  internal static let rulesMainDsc = Localized.tr("Localizable", "RULES_MAIN_DSC")
  /// И еще:
  internal static let rulesMore = Localized.tr("Localizable", "RULES_MORE")
  /// Виды заданий в записке: загадки, ребусы, пазлы, шифры, чернила симпатические (проявляющие под воздействием определенного вещества или нагревания), диктант графический, кроссворд, анаграммы.
  internal static let rulesMoreDsc = Localized.tr("Localizable", "RULES_MORE_DSC")
  /// Правило 2
  internal static let rulesOne = Localized.tr("Localizable", "RULES_ONE")
  /// В конце игры 12 записка обычно указывает, где спрятан приз – подарки или сладости.
  internal static let rulesOneDsc = Localized.tr("Localizable", "RULES_ONE_DSC")
  /// Кажется, что-то пошло не так...
  internal static let somethingWrong = Localized.tr("Localizable", "SOMETHING_WRONG")
  /// Увы
  internal static let sorry = Localized.tr("Localizable", "SORRY")
  /// Начать игру
  internal static let startGame = Localized.tr("Localizable", "START_GAME")
  /// Кажется, здесь пока пусто
  internal static let stillEmpty = Localized.tr("Localizable", "STILL_EMPTY")
  /// Сделано попыток: 
  internal static let totalAttempts = Localized.tr("Localizable", "TOTAL_ATTEMPTS")
  /// Найдено записок: 
  internal static let totalNotes = Localized.tr("Localizable", "TOTAL_NOTES")
  /// Набрано очков: 
  internal static let totalScores = Localized.tr("Localizable", "TOTAL_SCORES")
  /// Да
  internal static let yes = Localized.tr("Localizable", "YES")
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension Localized {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
