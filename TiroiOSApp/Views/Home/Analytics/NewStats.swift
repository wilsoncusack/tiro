//
//  NewStats.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/5/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import CoreData

func isInPeriod(date: Date, startDate: Date, endDate: Date) -> Bool{
    let dateWithoutTimestamp = date.removeTimeStamp()
    let endWithoutTimestamp = endDate.removeTimeStamp()
    return dateWithoutTimestamp.compare(startDate.removeTimeStamp()) ==
        ComparisonResult.orderedDescending
        && (dateWithoutTimestamp.compare(endWithoutTimestamp) == ComparisonResult.orderedAscending || dateWithoutTimestamp.compare(endWithoutTimestamp) == ComparisonResult.orderedSame)
}


func isInSevenDaysTrailing<Element>(element: Element, dateKey: KeyPath<Element, Date>) -> Bool{
    let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
    return isInPeriod(date: element[keyPath: dateKey], startDate: startDate, endDate: Date())
}

func isInToday<Element>(element: Element, dateKey: KeyPath<Element, Date>) -> Bool{
    let startDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
    let endDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())!
    return isInPeriod(date: element[keyPath: dateKey], startDate: startDate, endDate:  endDate)
}

func isInWeek<Element>(element: Element, dateKey: KeyPath<Element, Date>) -> Bool{
    // this is actually Monday to Monday, search is exclusive on beginning
    // inclusive on end
    return isInPeriod(date: element[keyPath: dateKey], startDate: Date.today().previous(.sunday), endDate: Date.today().next(.sunday))
}

func isInMonth<Element>(element: Element, dateKey: KeyPath<Element, Date>) -> Bool{
    return isInPeriod(date: element[keyPath: dateKey], startDate: Date().startOfMonth(), endDate: Date().endOfMonth())
}

func isInAllTime<Element>(element: Element, dateKey: KeyPath<Element, Date>) -> Bool{
    return isInPeriod(date: element[keyPath: dateKey], startDate: Date.distantPast, endDate: Date())
}

func attributeCount<Element, Attribute>(elements: [Element], getAttributes: @escaping (Element) -> [Attribute]) -> Dictionary<Attribute, Int> {
    var dict = Dictionary<Attribute, Int>()
    for element in elements {
        //let attributes = element[keyPath: key]
        let attributes = getAttributes(element)
        for attribute in attributes {
            if let count = dict[attribute]{
                dict[attribute] = count + 1
            } else {
                dict[attribute] = 1
            }
        }
    }
    return dict
}


struct AnalyticsCardData: Hashable {
    var name: String
    var count: Int
}

struct PercentBarData: Hashable {
    var name: String
    var count: Int
    var percent: Double
    var color: Color
}

struct StatCard: View {
    var title: String
    var cardData: AnalyticsCardData
    
    var body: some View{
        VStack{
            Text(cardData.name)
            Text(cardData.count.description)
                .font(.title)
                .bold()
            Text(title)
                .font(.footnote)
        }.padding().border(Color.gray, width: 1)
    }
}

func attributeCountTouples<Element, Attribute>
    (elements: [Element],
     getAttributes: @escaping (Element) -> [Attribute],
     getString: @escaping (Attribute) -> String) -> [AnalyticsCardData]
    where Attribute: Hashable
{
    let dict : Dictionary<Attribute, Int> = attributeCount(elements: elements, getAttributes: getAttributes)
    var touples = [AnalyticsCardData]()
    for (attribute, count) in dict {
        touples.append(AnalyticsCardData(name: getString(attribute), count: count))
    }
    touples.sort { (touple1, touple2) -> Bool in
        return touple1.count - touple2.count > 0
    }
    return touples
}

func getColor(_ name: String) -> Color {
    switch name {
    case "math":
        return .red
    case "science":
        return .blue
    case "writing":
        return .orange
    case "foreign language":
        return .yellow
    case "history":
        return .purple
    case "reading":
        return .green
    default:
        return .gray
    }
    
}

struct percentageBarText: View {
    var percentageData: [PercentBarData]
    var dataLength: Int {
        percentageData.count
    }
    
    var body: some View{
        VStack(alignment: .leading){
            HStack(alignment: .top){
                ForEach(percentageData[..<min(3, dataLength)], id: \.self){d in
                    HStack{
                        Text(d.count.description)
                            .foregroundColor(d.color)
                        Text(d.name)
                            .foregroundColor(d.color)
                    }
                    
                }
            }
            HStack(alignment: .top){
                if(dataLength > 3){
                    ForEach(percentageData[min(3, dataLength)..<min(7, dataLength)], id: \.self){d in
                        HStack{
                            Text(d.count.description)
                                .foregroundColor(d.color)
                            Text(d.name)
                                .foregroundColor(d.color)
                        }
                        
                    }
                    
                }
            }
        }
    }
}

struct PercentageBar: View {
    var tagAnalyticsData: [AnalyticsCardData]
    var barWidth = UIScreen.main.bounds.width - 40
    
    
    var tagsWithPercent: [PercentBarData]{
        let total = tagAnalyticsData
            .map {$0.count}
            .reduce(0, {x, y in
                x + y
            })
        return tagAnalyticsData.map {x in
            PercentBarData(name: x.name, count: x.count, percent: Double(x.count)/Double(total), color: getColor(x.name))
        }
    }
    
    func buildBar(_ percentDatum: PercentBarData) -> some View {
        Rectangle()
            .frame(width: CGFloat(Double(barWidth) * percentDatum.percent), height: 10)
            .foregroundColor(percentDatum.color)
    }
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(spacing: 0){
                ForEach(tagsWithPercent, id: \.self){percentDatum in
                    self.buildBar(percentDatum)
                }
            }.frame(height: 10).cornerRadius(8)
            percentageBarText(percentageData: tagsWithPercent)
            
        }
    }
}


struct NewStats: View {
    @FetchRequest(entity: Activity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Activity.activity_date, ascending: false)])
    var activities: FetchedResults<Activity>
    let startDate = Calendar.current.nextWeekend(startingAfter: Date())
    
    @FetchRequest(entity: Question.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Question.date_created, ascending: false)])
    var questions: FetchedResults<Question>
    
    
    var activitiesInTrailing7Days: [Activity] {
        activities
            .filter {activity in
                return isInSevenDaysTrailing(element: activity, dateKey: \.activity_date)
        }
    }
    
    var activitiesToday: [Activity] {
        activities
            .filter {activity in
                return isInToday(element: activity, dateKey: \.activity_date)
        }
    }
    
    
    
    var learnerAnalyticsData: [AnalyticsCardData] {
        attributeCountTouples(elements: activitiesInTrailing7Days, getAttributes: {activity in activity.participants?.allObjects as! [Learner]}, getString: {learner in learner.name})
    }
    
    var tagAnalyticsData: [AnalyticsCardData] {
        attributeCountTouples(elements: activitiesInTrailing7Days, getAttributes: {activity in activity.tags?.allObjects as! [Tag]}, getString: {tag in tag.name})
    }
    
    
    
    
    
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text("\(activitiesInTrailing7Days.count) \(activitiesInTrailing7Days.count == 1 ? "Activity" : "Activities") in the last 7 days").foregroundColor(.secondary).padding(.leading, 15).padding(.top, 10)
            PercentageBar(tagAnalyticsData: tagAnalyticsData).padding(.leading, 15)
        }
        
    }
}

struct NewStats_Previews: PreviewProvider {
    static var previews: some View {
        NewStats()
    }
}

