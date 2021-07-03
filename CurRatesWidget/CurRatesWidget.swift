//
//  CurRatesWidget.swift
//  CurRatesWidget
//
//  Created by Maksim Kalik on 3/28/21.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    @AppStorage("currency", store: UserDefaults(suiteName: Constants.suiteName)) var currencyData = Data()
    
    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date(), currency: CurrencyViewModel(currency: Currency.gbr))
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        guard let id = try? JSONDecoder().decode(String.self, from: self.currencyData) else { return }
        CureRatesProvider.getCurrency(by: id) { currency in
            let entry = SimpleEntry(date: Date(), currency: currency)
            completion(entry)
        }
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        guard let id = try? JSONDecoder().decode(String.self, from: self.currencyData) else { return }
        CureRatesProvider.getCurrency(by: id) { currency in
            let currentDate = Date()
            for hourOffset in 0 ..< 5 {
                let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
                let entry = SimpleEntry(date: entryDate, currency: currency)
                entries.append(entry)
            }
            
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
        
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let currency: CurrencyViewModel
}

struct CurRatesWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        CurRatesWidgetView(currency: entry.currency)
    }
}

@main
struct CurRatesWidget: Widget {
    let kind: String = Constants.widgetKind

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            CurRatesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium, .systemSmall])
    }
}

struct CurRatesWidget_Previews: PreviewProvider {
    static var previews: some View {
        CurRatesWidgetEntryView(entry: SimpleEntry(date: Date(), currency: CurrencyViewModel(currency: Currency.gbr)))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        CurRatesWidgetEntryView(entry: SimpleEntry(date: Date(), currency: CurrencyViewModel(currency: Currency.gbr)))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
