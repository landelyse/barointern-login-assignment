//
//  CoreDataStack.swift
//  login-assignment
//
//  Created by 박진홍 on 6/10/25.
//

import CoreData

final class CoreDataStack<T: NSManagedObject> {
    private let containerName: String = "UserModel"
    private let persistentContainer: NSPersistentContainer
    private let backgroundContext: NSManagedObjectContext

    init() {
        self.persistentContainer = NSPersistentContainer(name: containerName)
        self.backgroundContext = persistentContainer.newBackgroundContext()
        setupContext()
    }

    @discardableResult
    func createEntity() async throws -> T {
        try await backgroundContext.perform {
            let entity: T = T(context: self.backgroundContext)
            do {
                try self.backgroundContext.save()
                return entity
            } catch {
                let name: String = T.entity().name ?? "\(T.self)"
                throw DataError.failedToCreateEntity(name)
            }

        }
    }

    @discardableResult
    func createEntity(_ configure: @escaping (T) -> Void) async throws -> T {
        try await backgroundContext.perform {
            let entity: T = T(context: self.backgroundContext)
            configure(entity)
            try self.backgroundContext.save()
            return entity
        }
    }

    func fetchEntityByKeyValue(_ key: CoreDataKey<T>, value: CVarArg) async throws -> T {
        try await backgroundContext.perform {
            return try Self.resolveEntity(key: key.name, value: value, in: self.backgroundContext)
        }
    }

    func deleteEntityByKeyValue(_ key: CoreDataKey<T>, value: CVarArg) async throws {
        try await backgroundContext.perform {
            let entity: T = try Self.resolveEntity(key: key.name, value: value, in: self.backgroundContext)
            self.backgroundContext.delete(entity)
            try self.backgroundContext.save()
        }
    }

    func checkEntityExists(_ key: CoreDataKey<T>, value: CVarArg) async throws -> Bool {
        try await backgroundContext.perform {
            return try Self.entityExists(key: key.name, value: value, in: self.backgroundContext)
        }
    }

    private func setupContext() {
        self.backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}

extension CoreDataStack {
    static func resolveEntity(key: String, value: CVarArg, in context: NSManagedObjectContext) throws -> T {
        let request = NSFetchRequest<T>(entityName: String(describing: T.self))
        request.predicate = NSPredicate(format: "%K == %@", key, value)
        request.fetchLimit = 1

        guard let result = try context.fetch(request).first else {
            throw DataError.coreDataEntityNotFound
        }

        return result
    }

    static func entityExists(key: String, value: CVarArg, in context: NSManagedObjectContext) throws -> Bool {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: T.self))
        request.predicate = NSPredicate(format: "%K == %@", key, value)
        request.fetchLimit = 1
        request.includesPropertyValues = false
        request.includesSubentities = false

        let count = try context.count(for: request)
        return count > 0
    }
}
