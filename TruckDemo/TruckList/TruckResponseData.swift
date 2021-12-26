//
//  TruckListResponse.swift
//  TruckDemo
//
//  Created by Aaditya Verma on 23/12/21.
//

import Foundation

// MARK: - TruckResponseData
struct TruckResponseData: Codable {
    let responseCode: ResponseCode?
    let data: [TruckData]?
}

struct TruckData: Codable {
    let id, companyID, truckTypeID, truckSizeID: Int?
    let truckNumber: String?
    let transporterID, trackerType: Int?
    let imeiNumber, simNumber: String?
    let name: Name?
    let password: Password?
    let createTime: Int?
    let deactivated, breakdown: Bool?
    let lastWaypoint: LastWaypoint?
    let lastRunningState: LastRunningState?
    let durationInsideSite: Int?
    let fuelSensorInstalled, externalTruck: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case companyID = "companyId"
        case truckTypeID = "truckTypeId"
        case truckSizeID = "truckSizeId"
        case truckNumber
        case transporterID = "transporterId"
        case trackerType, imeiNumber, simNumber, name, password, createTime, deactivated, breakdown, lastWaypoint, lastRunningState, durationInsideSite, fuelSensorInstalled, externalTruck
    }
}

struct LastRunningState: Codable {
    let truckID, stopStartTime, truckRunningState: Int?
    let lat, lng: Double?
    let stopNotficationSent: Int?

    enum CodingKeys: String, CodingKey {
        case truckID = "truckId"
        case stopStartTime, truckRunningState, lat, lng, stopNotficationSent
    }
}

struct LastWaypoint: Codable {
    let id: Int?
    let lat, lng: Double?
    let createTime, accuracy, bearing, truckID: Int?
    let speed: Double?
    let updateTime: Int?
    let ignitionOn: Bool?
    let odometerReading: Double?
    let batteryPower: Bool?
    let fuelLevel, batteryLevel: Int?

    enum CodingKeys: String, CodingKey {
        case id, lat, lng, createTime, accuracy, bearing
        case truckID = "truckId"
        case speed, updateTime, ignitionOn, odometerReading, batteryPower, fuelLevel, batteryLevel
    }
}

enum Name: String, Codable {
    case empty = ""
    case sukhi = "sukhi"
}

enum Password: String, Codable {
    case empty = ""
    case sukhi123 = "sukhi123"
}

struct ResponseCode: Codable {
    let responseCode: Int?
    let message: String?
}
