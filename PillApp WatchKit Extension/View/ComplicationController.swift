//
//  ComplicationController.swift
//  PillApp WatchKit Extension
//
//  Created by Raphael Braun on 08/03/2018.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import WatchKit

class ComplicationController: NSObject, CLKComplicationDataSource {
    var  count = 0
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([])
    }
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        switch complication.family {
        case .modularSmall:
            let template = CLKComplicationTemplateModularSmallRingText()
            count+=1
            template.textProvider = CLKSimpleTextProvider(text: "\(count)")
            template.tintColor = #colorLiteral(red: 0.003921568627, green: 0.9960784314, blue: 0.968627451, alpha: 1)
            template.textProvider.tintColor = .white
            template.fillFraction = 0.5
            handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template))
        default:
            handler(nil)
        }
    }
    
}
