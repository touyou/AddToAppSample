import WidgetKit
import SwiftUI

struct IntroductionView: View {
    var item: EmptyEntry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("🎙️ このLTの発表者")
                .font(.largeTitle.bold())
            HStack {
                Image(.logo)
                    .resizable()
                    .widgetAccentedRenderingMode(.fullColor)
                    .frame(width: 50, height: 50)
                    .clipShape(.circle)
                Text("とうよう / 藤井陽介")
                    .font(.headline.bold())
            }
            HStack {
                Text("株式会社グッドパッチ")
                Spacer()
                Text("デザインエンジニア")
            }
            .font(.subheadline)
            Text("デザイン好きなエンジニア。\nクライアントワークにてiOS / Web / Flutterなど幅広い領域で実装・テックディレクション等を担当。\n直近はFlutterで「Habee」というアプリの制作をお手伝いしています。\n好きなものはApple、原神、サッカー、楽器演奏など。")
        }
    }
}

struct IntroductionWidget: Widget {
    let kind: String = "introduction"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: EmptyProvider()) { entry in
            IntroductionView(item: entry)
                .containerBackground(.white, for: .widget)
        }
        .configurationDisplayName(Text("Introduction View"))
    }
}
