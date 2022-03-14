import Foundation

public struct Token: Decodable {
    enum CodingKeys: String, CodingKey {
        case Access_Token = "access_token"
        case Refresh_Token = "refresh_token"
    }
    public let Access_Token : String
    public let Refresh_Token : String
}
