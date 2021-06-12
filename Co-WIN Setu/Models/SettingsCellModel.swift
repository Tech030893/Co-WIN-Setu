import Foundation

struct SettingsCellModel
{
    let title: String
    let handler: (() -> Void)
}

enum SettingsURLType
{
    case terms, privacy, faq
}
