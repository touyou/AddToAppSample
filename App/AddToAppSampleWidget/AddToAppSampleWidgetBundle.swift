//
//  AddToAppSampleWidgetBundle.swift
//  AddToAppSampleWidget
//
//  Created by 藤井陽介 on 2025/10/14.
//

import WidgetKit
import SwiftUI

@main
struct AddToAppSampleWidgetBundle: WidgetBundle {
    var body: some Widget {
        AddToAppSampleWidget()
        TodoCheckWidget()
    }
}
