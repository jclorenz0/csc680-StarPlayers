import Foundation

// BELOW IS FOR GENERAL PLAYER DATA (PLAYER SEARCH API)
struct APIResponse: Decodable {
    let data: [PlayerData]
}

struct PlayerData: Codable {
    var id: Int
    var FN: String
    var LN: String
    var JN: String
    var POS: String
    var team: Team
    
    enum CodingKeys: String, CodingKey {
        case id
        case FN = "first_name"
        case LN = "last_name"
        case JN = "jersey_number"
        case POS = "position"
        case team
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        FN = try container.decode(String.self, forKey: .FN)
        LN = try container.decode(String.self, forKey: .LN)
        JN = try container.decodeIfPresent(String.self, forKey: .JN) ?? "N/A"
        POS = try container.decodeIfPresent(String.self, forKey: .POS) ?? "N/A"
        team = try container.decode(Team.self, forKey: .team)
    }
}

struct Team: Codable {
    var teamName: String
    
    enum CodingKeys: String, CodingKey {
        case teamName = "full_name"
    }
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            teamName = try container.decodeIfPresent(String.self, forKey: .teamName) ?? "No Team Name"
        }
}

// BELOW IS FOR STATISTIC DATA (SEASON AVG API)
struct StatsResponse: Codable {
    let data: [PlayerStats]
}

struct PlayerStats: Codable {
    let pts: Float
    let ast: Float
    let reb: Float
    let turnover: Float
    
    let fg_pct: Float
    let fg3_pct: Float
    let ft_pct: Float
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            pts = try container.decodeIfPresent(Float.self, forKey: .pts) ?? 0.0
            ast = try container.decodeIfPresent(Float.self, forKey: .ast) ?? 0.0
            reb = try container.decodeIfPresent(Float.self, forKey: .reb) ?? 0.0
            turnover = try container.decodeIfPresent(Float.self, forKey: .turnover) ?? 0.0
            
            fg_pct = try container.decodeIfPresent(Float.self, forKey: .fg_pct) ?? 0.0
            fg3_pct = try container.decodeIfPresent(Float.self, forKey: .fg3_pct) ?? 0.0
            ft_pct = try container.decodeIfPresent(Float.self, forKey: .ft_pct) ?? 0.0
        }
}
