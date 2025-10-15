import WidgetKit
import SwiftUI

struct EmptyProvider: TimelineProvider {
    func placeholder(in context: Context) -> EmptyEntry {
        EmptyEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (EmptyEntry) -> ()) {
        let entry = EmptyEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<EmptyEntry>) -> ()) {
        var entries: [EmptyEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = EmptyEntry(date: entryDate)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct EmptyEntry: TimelineEntry {
    let date: Date
}

struct LinkPreviewView: View {
    var item: EmptyEntry
    
    var body: some View {
        VStack {
            Text("🔗 リンク集")
                .font(.largeTitle.bold())
            HStack(spacing: 32) {
                VStack {
                    QrCodeView(data: "https://goodpatch.com/")
                        .frame(width: 100, height: 100)
                    Text("会社について")
                }
                VStack {
                    QrCodeView(data: "https://goodpatch-tech.hatenablog.com")
                        .frame(width: 100, height: 100)
                    Text("テックブログ")
                }
                VStack {
                    QrCodeView(data: "https://touyou.dev/")
                        .frame(width: 100, height: 100)
                    Text("touyou.dev")
                }
                VStack {
                    QrCodeView(data: "https://github.com/touyou/AddToAppSample")
                        .frame(width: 100, height: 100)
                    Text("今日の資料")
                }
            }
            .fontWeight(.bold)
        }
    }
}

struct LinkPreviewWidget: Widget {
    let kind: String = "linkpreview"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: EmptyProvider()) { entry in
            LinkPreviewView(item: entry)
                .containerBackground(.white, for: .widget)
        }
        .configurationDisplayName(Text("Link Preview"))
    }
}
