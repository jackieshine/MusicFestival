//
//  FestivalServiceSpec.swift
//  MusicFestivalTests
//
//  Created by Jackie on 31/12/21.
//

import XCTest
@testable import MusicFestival

class FestivalServiceSpec: XCTestCase {
  func test_get_festivals_success_with_sorted_recordLabels() {
    let apiClient = FestivalAPIClientMock()
    apiClient.shouldSuccess = true
    apiClient.mockJSONName = "FestivalResponse_Success"

    let festivalService = FestivalService(festivalAPIClient: apiClient)

    festivalService.getRecordLabels { result in
      switch result {
      case .success(let recordLabels):
        XCTAssertEqual(recordLabels.count, 11)

        XCTAssertEqual(recordLabels[0].name, "")
        XCTAssertEqual(recordLabels[0].bands.count, 3)
        XCTAssertEqual(recordLabels[0].bands[0].name, "")
        XCTAssertEqual(recordLabels[0].bands[0].attendedFestivals.count, 1)
        XCTAssertEqual(recordLabels[0].bands[0].attendedFestivals[0], "")
        XCTAssertEqual(recordLabels[0].bands[1].name, "Squint-281")
        XCTAssertEqual(recordLabels[0].bands[1].attendedFestivals.count, 1)
        XCTAssertEqual(recordLabels[0].bands[1].attendedFestivals[0], "Twisted Tour")
        XCTAssertEqual(recordLabels[0].bands[2].name, "Winter Primates")
        XCTAssertEqual(recordLabels[0].bands[2].attendedFestivals.count, 1)
        XCTAssertEqual(recordLabels[0].bands[2].attendedFestivals[0], "LOL-palooza")

        XCTAssertEqual(recordLabels[1].name, "ACR")
        XCTAssertEqual(recordLabels[1].bands.count, 2)
        XCTAssertEqual(recordLabels[1].bands[0].name, "Critter Girls")
        XCTAssertEqual(recordLabels[1].bands[0].attendedFestivals.count, 1)
        XCTAssertEqual(recordLabels[1].bands[0].attendedFestivals[0], "")
        XCTAssertEqual(recordLabels[1].bands[1].name, "Manish Ditch")
        XCTAssertEqual(recordLabels[1].bands[1].attendedFestivals.count, 1)
        XCTAssertEqual(recordLabels[1].bands[1].attendedFestivals[0], "Trainerella")

        XCTAssertEqual(recordLabels[2].name, "Anti Records")
        XCTAssertEqual(recordLabels[2].bands.count, 1)
        XCTAssertEqual(recordLabels[2].bands[0].name, "YOUKRANE")
        XCTAssertEqual(recordLabels[2].bands[0].attendedFestivals.count, 1)
        XCTAssertEqual(recordLabels[2].bands[0].attendedFestivals[0], "Trainerella")

        XCTAssertEqual(recordLabels[3].name, "Fourth Woman Records")
        XCTAssertEqual(recordLabels[3].bands.count, 2)
        XCTAssertEqual(recordLabels[3].bands[0].name, "Jill Black")
        XCTAssertEqual(recordLabels[3].bands[0].attendedFestivals.count, 1)
        XCTAssertEqual(recordLabels[3].bands[0].attendedFestivals[0], "LOL-palooza")
        XCTAssertEqual(recordLabels[3].bands[1].name, "The Black Dashes")
        XCTAssertEqual(recordLabels[3].bands[1].attendedFestivals.count, 1)
        XCTAssertEqual(recordLabels[3].bands[1].attendedFestivals[0], "Small Night In")

        XCTAssertEqual(recordLabels[4].name, "Marner Sis. Recording")
        XCTAssertEqual(recordLabels[4].bands.count, 3)
        XCTAssertEqual(recordLabels[4].bands[0].name, "Auditones")
        XCTAssertEqual(recordLabels[4].bands[0].attendedFestivals.count, 1)
        XCTAssertEqual(recordLabels[4].bands[0].attendedFestivals[0], "Twisted Tour")
        XCTAssertEqual(recordLabels[4].bands[1].name, "Green Mild Cold Capsicum")
        XCTAssertEqual(recordLabels[4].bands[1].attendedFestivals.count, 1)
        XCTAssertEqual(recordLabels[4].bands[1].attendedFestivals[0], "Small Night In")
        XCTAssertEqual(recordLabels[4].bands[2].name, "Wild Antelope")
        XCTAssertEqual(recordLabels[4].bands[2].attendedFestivals.count, 1)
        XCTAssertEqual(recordLabels[4].bands[2].attendedFestivals[0], "Small Night In")

        XCTAssertEqual(recordLabels[5].name, "MEDIOCRE Music")
        XCTAssertEqual(recordLabels[5].bands.count, 1)
        XCTAssertEqual(recordLabels[5].bands[0].name, "Yanke East")
        XCTAssertEqual(recordLabels[5].bands[0].attendedFestivals.count, 1)
        XCTAssertEqual(recordLabels[5].bands[0].attendedFestivals[0], "Small Night In")

        XCTAssertEqual(recordLabels[6].name, "Monocracy Records")
        XCTAssertEqual(recordLabels[6].bands.count, 1)
        XCTAssertEqual(recordLabels[6].bands[0].name, "Adrian Venti")
        XCTAssertEqual(recordLabels[6].bands[0].attendedFestivals.count, 1)
        XCTAssertEqual(recordLabels[6].bands[0].attendedFestivals[0], "Trainerella")

        XCTAssertEqual(recordLabels[7].name, "Outerscope")
        XCTAssertEqual(recordLabels[7].bands.count, 2)
        XCTAssertEqual(recordLabels[7].bands[0].name, "Squint-281")
        XCTAssertEqual(recordLabels[7].bands[0].attendedFestivals.count, 1)
        XCTAssertEqual(recordLabels[7].bands[0].attendedFestivals[0], "Small Night In")
        XCTAssertEqual(recordLabels[7].bands[1].name, "Summon")
        XCTAssertEqual(recordLabels[7].bands[1].attendedFestivals.count, 1)
        XCTAssertEqual(recordLabels[7].bands[1].attendedFestivals[0], "Twisted Tour")

        XCTAssertEqual(recordLabels[8].name, "Pacific Records")
        XCTAssertEqual(recordLabels[8].bands.count, 2)
        XCTAssertEqual(recordLabels[8].bands[0].name, "Frank Jupiter")
        XCTAssertEqual(recordLabels[8].bands[0].attendedFestivals.count, 2)
        XCTAssertEqual(recordLabels[8].bands[0].attendedFestivals[0], "LOL-palooza")
        XCTAssertEqual(recordLabels[8].bands[0].attendedFestivals[1], "Small Night In")
        XCTAssertEqual(recordLabels[8].bands[1].name, "Propeller")
        XCTAssertEqual(recordLabels[8].bands[1].attendedFestivals.count, 1)
        XCTAssertEqual(recordLabels[8].bands[1].attendedFestivals[0], "")

        XCTAssertEqual(recordLabels[9].name, "Still Bottom Records")
        XCTAssertEqual(recordLabels[9].bands.count, 1)
        XCTAssertEqual(recordLabels[9].bands[0].name, "Wild Antelope")
        XCTAssertEqual(recordLabels[9].bands[0].attendedFestivals.count, 1)
        XCTAssertEqual(recordLabels[9].bands[0].attendedFestivals[0], "Trainerella")

        XCTAssertEqual(recordLabels[10].name, "XS Recordings")
        XCTAssertEqual(recordLabels[10].bands.count, 2)
        XCTAssertEqual(recordLabels[10].bands[0].name, "")
        XCTAssertEqual(recordLabels[10].bands[0].attendedFestivals.count, 1)
        XCTAssertEqual(recordLabels[10].bands[0].attendedFestivals[0], "LOL-palooza")
        XCTAssertEqual(recordLabels[10].bands[1].name, "Werewolf Weekday")
        XCTAssertEqual(recordLabels[10].bands[1].attendedFestivals.count, 1)
        XCTAssertEqual(recordLabels[10].bands[1].attendedFestivals[0], "LOL-palooza")


      case .failure:
        XCTFail("Expected success case.")
      }
    }
  }

  func test_get_festivals_failure() {
    let apiClient = FestivalAPIClientMock()
    apiClient.shouldSuccess = false
    let festivalService = FestivalService(festivalAPIClient: apiClient)

    festivalService.getRecordLabels { result in
      switch result {
      case .success:
        XCTFail("Expected failure case.")
      case .failure(let error):
        XCTAssertNotNil(error)
      }
    }
  }
}

final class FestivalAPIClientMock: FestivalAPIObjectProviding {
  var httpClient: HTTPRequestMaking = HTTPClientMock()
  var shouldSuccess = true
  var mockJSONName: String?
  var error: NetworkError = .undefined(error: nil)

  func getFestivals(success: @escaping FestivalAPISuccessAction, failure: @escaping FestivalAPIFailureAction) {
    if shouldSuccess {
      let jsonDecoder = JSONDecoder()
      let jsonData = Bundle(for: type(of: self)).jsonData(fromResource: mockJSONName ?? "") ?? Data()
      let festivals = try? jsonDecoder.decode([MusicFestival].self, from: jsonData)
      success(festivals ?? [])
    } else {
      failure(error)
    }
  }
}
