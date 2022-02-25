//
//  CoreDataManager.m
//  Pokedex
//
//  Created by Abraham Abreu on 01/02/22.
//

#import "CoreDataManager.h"

@interface CoreDataManager()

@property(nonatomic, strong)NSManagedObjectContext *managedObjectContext;

@end

@implementation CoreDataManager

-(instancetype)init {
    self = [super init];
    [self setUpCoreDataStack];
    return self;
}

-(void)setUpCoreDataStack
{
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:[NSBundle allBundles]];
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    NSURL *url = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"Pokedex.sqlite"];
    
    NSDictionary *options = @{NSPersistentStoreFileProtectionKey: NSFileProtectionComplete,
                              NSMigratePersistentStoresAutomaticallyOption:@YES};
    NSError *error = nil;
    NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:options error:&error];
    if (!store)
    {
        NSLog(@"Error adding persistent store. Error %@",error);

        NSError *deleteError = nil;
        if ([[NSFileManager defaultManager] removeItemAtURL:url error:&deleteError])
        {
            error = nil;
            store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:options error:&error];
        }
        
        if (!store)
        {
            // Also inform the user...
            NSLog(@"Failed to create persistent store. Error %@. Delete error %@",error,deleteError);
            abort();
        }
    }
    
    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.managedObjectContext.persistentStoreCoordinator = psc;
}
-(void)saveContext {
    NSError *error = nil;
    if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error]) {
        NSLog(@"Can't save! %@ %@", error, [error localizedDescription]);
    } else {
        NSLog(@"Saved Successfully");
    }
}

-(void)saveNewPokemon:(PokemonDisplay*)pokemon {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Pokemon"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"pokemonId == %ld", pokemon.pokemonNumber];
    [request setPredicate: predicate];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest: request error: &error];

    if ([results count] == 0) {
        [self createNewEntryWith: pokemon];
    } else {
        NSLog(@"Error already exists %@", error.localizedDescription);
    }
}

-(NSMutableArray<PokemonDisplay *>*)fetchResults {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Pokemon"];
     
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching pokemon objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    NSLog(@"Results %@", results);
    NSMutableArray<PokemonDisplay*>* list = [[NSMutableArray alloc]init];
    for (PokemonMO *result in results) {
        [list addObject: [[PokemonDisplay alloc]initWithModel: result]];
    }
    return list;
}

-(void)deleteAllPokemons {
    NSFetchRequest * allRecords = [[NSFetchRequest alloc] init];
    [allRecords setEntity:[NSEntityDescription entityForName: @"Pokemon" inManagedObjectContext: self.managedObjectContext]];
    [allRecords setIncludesPropertyValues:NO];
    NSError * error = nil;
    NSArray * result = [self.managedObjectContext executeFetchRequest: allRecords error: &error];
    for (NSManagedObject *pokemon in result) {
        [self.managedObjectContext deleteObject: pokemon];
    }
    [self saveContext];
}

-(void)createNewEntryWith:(PokemonDisplay*)pokemon {
    PokemonMO *model = [NSEntityDescription insertNewObjectForEntityForName: @"Pokemon" inManagedObjectContext: self.managedObjectContext];
    if (model != nil) {
        model.name = pokemon.pokemonName;
        model.pokemonId = pokemon.pokemonNumber;
        model.pokemonURL = pokemon.pokemonImage;
        [self saveContext];
    } else {
        NSLog(@"Error to save Model");
    }
}

@end
