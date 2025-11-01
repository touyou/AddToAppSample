# Liquid Glass に関する話

## 今回使った箇所

- Tab
  - 基本的に Liquid Glass の代表的な適用場所
  - 使っていないが最小化することもできる
  - 検索画面は role で分離した
- Toolbar
  - 今回から NavigationBar も Toolbar に統一された
  - 直近の Apple 製アプリに合わせて Native タブではインラインラージタイトルがスクロール時に消える表現を採用した（参考： [【iOS】 Apple 標準アプリ風にスクロールでナビゲーションタイトルを消す方法を共有したい](https://dev.classmethod.jp/articles/ios-apple-navigation-title-hidden-with-scroll/)）
- アイコン
  - Icon Composer で構築した
- Widget
  - 別ドキュメントにもまとめたように一部 clear でも色が残るようにしつつ組んでいる

## 考え方について

- 詳細は[extension DC 2025 Day2 で Liquid Glass と App Intents の話をしてきた](https://goodpatch-tech.hatenablog.com/entry/liquid_glass_and_app_intents)にまとめている
- 基本的に重要なのはコンテンツファーストという考え方
- HIG で参照するべきは[マテリアル](https://developer.apple.com/jp/design/human-interface-guidelines/materials)
- デベロッパとして参照するのは[Adopting Liquid Glass](https://developer.apple.com/documentation/technologyoverviews/adopting-liquid-glass)、ここに基本的な使い方は書いてある
  - 逆にこれ以外のドキュメントを見るとできること（カスタム View への適用など）は本当に必要であると整理できた時のみ使うことが推奨される
