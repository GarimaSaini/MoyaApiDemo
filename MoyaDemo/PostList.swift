//
//  PostList.swift

import Foundation
import SwiftyJSON

public final class PostList: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let title = "title"
    static let userId = "userId"
    static let id = "id"
    static let body = "body"
  }

  // MARK: Properties
  public var title: String?
  public var userId: Int?
  public var id: Int?
  public var body: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    title = json[SerializationKeys.title].string
    userId = json[SerializationKeys.userId].int
    id = json[SerializationKeys.id].int
    body = json[SerializationKeys.body].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = userId { dictionary[SerializationKeys.userId] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = body { dictionary[SerializationKeys.body] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.userId = aDecoder.decodeObject(forKey: SerializationKeys.userId) as? Int
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.body = aDecoder.decodeObject(forKey: SerializationKeys.body) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(userId, forKey: SerializationKeys.userId)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(body, forKey: SerializationKeys.body)
  }

}
