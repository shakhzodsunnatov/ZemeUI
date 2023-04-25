//
//  PropertyModel.swift
//  ReZeme
//
//  Created by Shakhzod on 08/04/23.
//

import Foundation

// MARK: - PropertyModel
struct PropertyModel: Codable {
    let count: Int?
    let next, previous: Int?
    let results: [Property]?
}

typealias Properties = [Property]

// MARK: - Result
struct Property: Codable {
    let id: Int?
    let generalInformation: ResultGeneralInformation?
    let economicInformation: EconomicInformationModel?
    let imageInformation: ImageInformation?
    let amenityInformation: [String: Bool]?
    let chargeInformation: ChargeInformation?
    let utilityInformation: UtilityInformation?
    let documentInformation: DocumentInformation?
    let statisticInformation: StatisticInformation?
    let creationDate, lastUpdate: String?

    enum CodingKeys: String, CodingKey {
        case id
        case generalInformation = "general_information"
        case economicInformation = "economic_information"
        case imageInformation = "image_information"
        case amenityInformation = "amenity_information"
        case chargeInformation = "charge_information"
        case utilityInformation = "utility_information"
        case documentInformation = "document_information"
        case statisticInformation = "statistic_information"
        case creationDate = "creation_date"
        case lastUpdate = "last_update"
    }
}

extension Property: Equatable {
    static func == (lhs: Property, rhs: Property) -> Bool {
        return lhs.id == rhs.id
    }
}


// MARK: - ChargeInformation
struct ChargeInformation: Codable {
    let firstMonthRent, securityDeposit, brokerFee, applicationFee: Int?
    let extraFeeName: String?
    let extraFeeCost: Double?

    enum CodingKeys: String, CodingKey {
        case firstMonthRent = "first_month_rent"
        case securityDeposit = "security_deposit"
        case brokerFee = "broker_fee"
        case applicationFee = "application_fee"
        case extraFeeName = "extra_fee_name"
        case extraFeeCost = "extra_fee_cost"
    }
}

// MARK: - DocumentInformation
struct DocumentInformation: Codable {
    let plaidVerifiedFinancials, photoID, rentalHistory, employmentVerification: Bool?
    let creditCheck, paystubs, w2Form, bankStatements: Bool?
    let taxReturns: Bool?

    enum CodingKeys: String, CodingKey {
        case plaidVerifiedFinancials = "plaid_verified_financials"
        case photoID = "photo_id"
        case rentalHistory = "rental_history"
        case employmentVerification = "employment_verification"
        case creditCheck = "credit_check"
        case paystubs
        case w2Form = "w2_form"
        case bankStatements = "bank_statements"
        case taxReturns = "tax_returns"
    }
}

// MARK: - EconomicInformation
struct EconomicInformationModel: Codable {
    let cost, updatedCost, minCredit, minSalary: Int?

    enum CodingKeys: String, CodingKey {
        case cost
        case updatedCost = "updated_cost"
        case minCredit = "min_credit"
        case minSalary = "min_salary"
    }
}

// MARK: - ResultGeneralInformation
struct ResultGeneralInformation: Codable {
    let agent: Agent?
    let address: String?
    let floor, bedrooms, bathrooms, squareFootage: Int?
    let apartmentNumber: Int?
    let propertyName, dataAvailable: String?

    enum CodingKeys: String, CodingKey {
        case agent, address, floor, bedrooms, bathrooms
        case squareFootage = "square_footage"
        case apartmentNumber = "apartment_number"
        case propertyName = "property_name"
        case dataAvailable = "data_available"
    }
}

// MARK: - Agent
struct Agent: Codable {
    let id: Int?
    let generalInformation: AgentGeneralInformation?
    let agentInformation: AgentInformation?

    enum CodingKeys: String, CodingKey {
        case id
        case generalInformation = "general_information"
        case agentInformation = "agent_information"
    }
}

// MARK: - AgentInformation
struct AgentInformation: Codable {
    let profilePicture: String?

    enum CodingKeys: String, CodingKey {
        case profilePicture = "profile_picture"
    }
}

// MARK: - AgentGeneralInformation
struct AgentGeneralInformation: Codable {
    let firstName, middleName, lastName: String?
    let verified: Bool?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case middleName = "middle_name"
        case lastName = "last_name"
        case verified
    }
}

// MARK: - ImageInformation
struct ImageInformation: Codable {
    let images: [ImageModel]?
}

// MARK: - Image
struct ImageModel: Codable {
    let id: Int?
    let image: String?
}

// MARK: - StatisticInformation
struct StatisticInformation: Codable {
    let views, saves: Int?
}

// MARK: - UtilityInformation
struct UtilityInformation: Codable {
    let gas, sewage, electricity, internet: Bool?
    let water, garbage, cable, satelliteTv: Bool?
    let otherUtilities: [String]?

    enum CodingKeys: String, CodingKey {
        case gas, sewage, electricity, internet, water, garbage, cable
        case satelliteTv = "satellite_tv"
        case otherUtilities = "other_utilities"
    }
}

