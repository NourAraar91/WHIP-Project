//
//  Response.swift
//  WIHP Project
//
//  Created by Nour Araar on 6/19/20.
//  Copyright © 2020 Nour Araar. All rights reserved.
//

import Foundation

// MARK: - Response
class ResponseAPIResponse: Codable {
    var httpStatus: Int?
    let response : ResponseClass?

    enum CodingKeys: String, CodingKey {

        case httpStatus = "httpStatus"
        case response = "response"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        httpStatus = try values.decodeIfPresent(Int.self, forKey: .httpStatus)
        response = try values.decodeIfPresent(ResponseClass.self, forKey: .response)
    }
}


// MARK: - ResponseClass
struct ResponseClass: Codable {
    var message: String
    var data: DataClass
}



// MARK: - DataClass
struct DataClass: Codable {
    var analytics: Analytics
}


// MARK: - Analytics
struct Analytics: Codable {
    var job: Job
    var lineCharts: [[LineChart]]
    var pieCharts: [PieChart]
    var rating: Rating
    var service: Job
}

// MARK: - Job
struct Job: Codable {
    var jobDescription: String
    var items: [GrowthItem]
    var title: String

    enum CodingKeys: String, CodingKey {
        case jobDescription = "description"
        case items, title
    }
}

// MARK: - JobItem
struct GrowthItem: Codable {
    var title: String
    var itemDescription: String
    var growth: Int

    enum CodingKeys: String, CodingKey {
        case itemDescription = "description"
        case growth, title
    }
}


// MARK: - LineChart
struct LineChart: Codable {
    var chartType, lineChartDescription: String
    var items: [LineChartItem]
    var title: String

    enum CodingKeys: String, CodingKey {
        case chartType
        case lineChartDescription = "description"
        case items, title
    }
}


// MARK: - LineChartItem
struct LineChartItem: Codable {
    var key: String
    var value: [ChartItem]
}


// MARK: - ValueElement
struct ChartItem: Codable {
    var key: String
    var value: Double
}



// MARK: - PieChart
struct PieChart: Codable {
    var chartType, pieChartDescription: String
    var items: [ChartItem]
    var title: String

    enum CodingKeys: String, CodingKey {
        case chartType
        case pieChartDescription = "description"
        case items, title
    }
}


// MARK: - Rating
struct Rating: Codable {
    var avg: Int
    var ratingDescription: String
    var items: [String: Int]
    var title: String

    enum CodingKeys: String, CodingKey {
        case avg
        case ratingDescription = "description"
        case items, title
    }
}
