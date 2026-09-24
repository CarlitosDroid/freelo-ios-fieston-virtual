import CoreData

extension UserEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var avatar: String?
    @NSManaged public var firstName: String?
    @NSManaged public var id: Int64
    @NSManaged public var idEvent: Int64
    @NSManaged public var lastName: String?
    @NSManaged public var ranking: Int16
    @NSManaged public var token: String?
    @NSManaged public var totalScore: Int64
}
