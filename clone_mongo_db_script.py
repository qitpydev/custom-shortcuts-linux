from pymongo import MongoClient

source_uri = input("Enter the source MongoDB URI: ")
source_db_name = input("Enter the source database name: ")
target_uri = input("Enter the target MongoDB URI: ")
target_db_name = input("Enter the target database name: ")

# Connection to the source MongoDB server
source_client = MongoClient(source_uri)
source_db = source_client[source_db_name]

# Connection to the local MongoDB server
local_uri = target_uri
local_client = MongoClient(local_uri)
local_db = local_client[target_db_name]

# List the collections in the source database
collections = source_db.list_collection_names()

# Clone each collection from source to local database
for collection_name in collections:
    source_collection = source_db[collection_name]
    local_collection = local_db[collection_name]

    # Copy all documents from the source collection to the local collection
    local_collection.insert_many(source_collection.find())

print("Database cloned successfully.")
