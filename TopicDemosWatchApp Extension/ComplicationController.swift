//
//  ComplicationController.swift
//  TopicDemosWatchApp Extension
//
//  Created by Sida Wang on 2/14/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

import ClockKit
import WatchConnectivity
import WatchKit


let ComplicationTextData = "ComplicationTextData"
let ComplicationShortTextData = "ComplicationShortTextData"
class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    //TODO: not working on simulator for now
    //TODO: before future & scrolling
    //TODO: more family support,  use case thinking
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
        let myDelegate = WKExtension.shared().delegate as! ExtensionDelegate
        var data = myDelegate.myComplicationData[ComplicationCurrentEntry] as! [String: Any]
        var entry : CLKComplicationTimelineEntry?
        let now = Date()
        if complication.family == .modularSmall {
            //should get from user defaults
            data[ComplicationTextData] = "text data"
            data[ComplicationShortTextData] = "Complication short data"
            let textTemplate = CLKComplicationTemplateModularSmallSimpleText()
            textTemplate.textProvider = CLKSimpleTextProvider(text: data[ComplicationTextData] as! String, shortText: data[ComplicationShortTextData] as? String)
            entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: textTemplate)
        }
        handler(entry)
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        let myDelegate = WKExtension.shared().delegate as! ExtensionDelegate
        var data = myDelegate.myComplicationData[ComplicationCurrentEntry] as! [String: Any]
        var entry : CLKComplicationTimelineEntry?
        let now = Date()
        if complication.family == .modularSmall {
            //should get from user defaults
            data[ComplicationTextData] = "placeholder text data"
            data[ComplicationShortTextData] = "holder Complication short data"
            let textTemplate = CLKComplicationTemplateModularSmallSimpleText()
            textTemplate.textProvider = CLKSimpleTextProvider(text: data[ComplicationTextData] as! String, shortText: data[ComplicationShortTextData] as? String)
            entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: textTemplate)
            handler(textTemplate)

        }
        handler(nil)
    }
    
}
