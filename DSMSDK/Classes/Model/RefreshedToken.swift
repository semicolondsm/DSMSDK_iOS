import Foundation

struct RefreshedToken: Decodable {
    enum CodingKeys: String, CodingKey {
        case Access_Token = "access_token"
    }
    public let Access_Token : String
}
