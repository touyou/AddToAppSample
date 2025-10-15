import WidgetKit
import SwiftUI

struct MessageView: View {
    var item: EmptyEntry
    
    var body: some View {
        Text("ご清聴ありがとうございました！")
            .font(.largeTitle.bold())
    }
}

struct MessageWidget: Widget {
    let kind: String = "message"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: EmptyProvider()) { entry in
            MessageView(item: entry)
                .containerBackground(.white, for: .widget)
        }
        .configurationDisplayName(Text("Message View"))
    }
}
