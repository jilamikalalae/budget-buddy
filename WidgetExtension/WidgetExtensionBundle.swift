//
//  WidgetExtensionBundle.swift
//  WidgetExtension
//
//  Created by Jilamika on 21/9/2567 BE.
//

import WidgetKit
import SwiftUI

@main
struct WidgetExtensionBundle: WidgetBundle {
    var body: some Widget {
        WidgetExtension()
        WidgetExtensionLiveActivity()
    }
}
