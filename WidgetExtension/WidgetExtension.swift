//
//  WidgetExtension.swift
//  WidgetExtension
//
//  Created by Jilamika on 21/9/2567 BE.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    @AppStorage("CreateWidget", store: UserDefaults(suiteName: "group.com.jilamika")) var primaryData : Data = Data()
    func placeholder(in context: Context) -> SimpleEntry {
        let balance = Balance(balance:100.00)
        return SimpleEntry(balance:balance)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        guard let balance = try? JSONDecoder().decode(Balance.self, from: primaryData) else {
            return SimpleEntry(balance:Balance(balance:100.00))
        }
        return SimpleEntry(balance:balance)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
//        var entries: [SimpleEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, configuration: configuration)
//            entries.append(entry)
//        }
//
//        return Timeline(entries: entries, policy: .atEnd)
        var simpleEntry: [SimpleEntry] = []
        guard let balance = try? JSONDecoder().decode(Balance.self, from: primaryData) else {
            let defaultEntry = SimpleEntry(
                balance: Balance(balance: 0.00)
            )
            simpleEntry.append(defaultEntry)
            return  Timeline(entries: simpleEntry ,policy: .atEnd)
        }
        simpleEntry.append(SimpleEntry(balance: balance))
        return  Timeline(entries: simpleEntry,policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date = Date()
    let balance : Balance
}

struct WidgetExtensionEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Balance")
            Text(String(entry.balance.balance))
        }
    }
}

struct WidgetExtension: Widget {
    let kind: String = "WidgetExtension"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            WidgetExtensionEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

#Preview(as: .systemSmall) {
    WidgetExtension()
} timeline: {
    let balance = Balance(balance:111.0)
    SimpleEntry(balance: balance)
    
}
