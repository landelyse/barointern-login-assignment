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
    
    func fetchEntityById(_ id: UUID) async throws -> T {
        try await backgroundContext.perform {
            let entity: T = try Self.resolveEntity(id: id, in: self.backgroundContext)
            return entity
        }
    }
    
    func deleteEntityById(_ id: UUID) async throws {
        try await backgroundContext.perform {
            let entity: NSManagedObject = try Self.resolveEntity(id: id, in: self.backgroundContext)
            self.backgroundContext.delete(entity)
            try self.backgroundContext.save()
        }
    }
    
    private func setupContext() {
        self.backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}

extension CoreDataStack {
    static func resolveEntity(id: UUID, in context: NSManagedObjectContext) throws -> T {
        let request = NSFetchRequest<T>(entityName: String(describing: T.self))
        request.predicate = NSPredicate(format: "uuid == %@", id as CVarArg)
        request.fetchLimit = 1
        
        guard let result = try context.fetch(request).first else {
            throw DataError.coreDataEntityNotFound
        }
        
        return result
    }
}
