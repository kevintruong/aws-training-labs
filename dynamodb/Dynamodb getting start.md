
Basic: DynamoDB is a NoSQL database service offered by Amazon Web Services (AWS) that provides fast and flexible storage for any type of data, including documents, key-value pairs, graphs, and more. It is designed to deliver reliable performance at any scale and can handle millions of requests per second.

Detail: DynamoDB is a fully managed, serverless, NoSQL database service offered by AWS. It's a non-relational database that uses a key-value store model to store and retrieve data. Unlike traditional databases, DynamoDB does not require tables to have a fixed schema, which allows for more flexibility and scalability.

DynamoDB is designed for high scalability and offers automatic scaling based on traffic volume, which means that you can easily add or remove capacity as needed. It also supports multi-region replication, which provides high availability and disaster recovery.

DynamoDB provides fast and predictable performance, with response times measured in single-digit milliseconds. It achieves this by using SSD storage and a distributed architecture that allows for automatic load balancing and partitioning of data across multiple nodes.

DynamoDB offers a number of features to simplify data management, including automatic backup and restore, automatic indexing, and fine-grained access control using AWS Identity and Access Management (IAM). It also provides a flexible data model that supports multiple data types, including documents, key-value pairs, graphs, and more.

Overall, DynamoDB is a powerful NoSQL database service that provides fast, flexible, and scalable storage for any type of data. It's easy to use and offers a number of features that simplify data management, making it a popular choice for web and mobile applications, gaming, IoT, and more.


DynamoDB partitions data based on a partition key, which is selected by the user when creating the table. 
The partition key determines how the data is distributed across multiple partitions, allowing for high scalability and performance. 

DynamoDB can automatically split and merge partitions as the table grows or shrinks in size. Each partition can handle a maximum of 10 GB of data and can handle up to 1,000 write capacity units or 3,000 read capacity units per second.

DynamoDB partitions data based on the partition key value, using partition keys to spread data across multiple partitions. 
Each partition key must be unique, and the partition key values are hashed to determine the partition on which the item will be stored.
DynamoDB dynamically manages partitions, so you don't need to worry about creating or maintaining them yourself.


In DynamoDB, a partition key is a primary key attribute used to uniquely identify items within a table. A single partition key means that the table has only one attribute acting as a partition key. 
This can limit the scalability of the table because all items with the same partition key must be stored on the same partition. As a result, if the table receives a high volume of requests, these requests can create hot partitions, which can lead to performance issues.

On the other hand, a composite partition key, also known as a combined partition key, consists of two or more attributes acting as a primary key. This allows for more flexibility in distributing data across partitions, for example, by distributing data evenly across multiple partitions, thereby preventing hot partitions. Additionally, it allows for hierarchical organization of data within a table.

Overall, the choice between a single partition key and a composite partition key depends on the specific use case and the expected workload of the table. It is important to consider the expected volume of data, the expected access patterns, and the need for scalability when designing a DynamoDB table.
detail about big table pattern in dynamodb and give sample example about the pattern

The big table pattern in DynamoDB involves storing all related data in a single table instead of distributing it across multiple tables. This design pattern leverages the scalability, high availability, and durability of DynamoDB to manage large datasets with high throughput and low latency. 

A sample example of the big table pattern in DynamoDB could be an e-commerce application that stores customer orders, products, and inventory data in a single table. Each item in the table would include a partition key to identify the specific customer or product, and could use different sort keys to group related items together. This approach enables efficient querying and updating of the data without requiring complicated joins or cross-table operations. For instance, a query for a specific order could use the customer ID as the partition key, and retrieve all items associated with that order using the sort key. Similarly, updating the inventory of a product would simply modify the corresponding item in the table, without needing to perform any additional operations.


## DynamoDB Table 

![[Dynamodb_table.excalidraw|600]]

- DynamoDB is a highly scalable NoSQL database provided by Amazon Web Services (AWS).
- It allows the creation and management of tables that can store and retrieve structured or unstructured data.
- Tables are defined by a primary key that uniquely identifies each item in the table.
- Data in tables is automatically replicated across three AWS Availability Zones for high durability and availability.
- DynamoDB offers fast and predictable performance, with low latency and throughput that can be adjusted as needed.
- It supports querying and filtering data based on any attribute in the table, not just the primary key.
- DynamoDB offers flexible data modeling options, allowing for hierarchical or flat data structures.
- It offers features such as automatic scaling, backup and restore, time to live (TTL) for data expiration, and global tables for multi-region replication.

## DynamoDB Operation 
### Reading and Writing 
- Capacity defined by speed read (RCU) and write (WCU)
- RCU:
	- 4KB per second 
- WCU
	- 1KB per second 
- RCU/WCU have round up block pricing model. Mean 
	- number of RCU/WCU = ( total sizing items / block sizing of operation ) + 1
	- For example: have total total sizing of all item need to write about 500,5 KB then what is RCU/WCU of read/write operation 
		- number of WCU =  int( 500,5/1 ) + 1 = 501 
		- number of RCU =  int( 500,5/ 4 ) + 1 = 126  
- Every Read/Write operation need 1 RCU/WCU 
- Each table have WCU , RCU brust pool (300 seconds)

## Query and Scan 

![[Dynamodb_query_scan.excalidraw]]

## Different between on-demand and provisioned mode in dynamodb

Provisioned mode and on-demand mode are two billing modes that can be used in Amazon DynamoDB.

Provisioned mode requires the user to specify the amount of read and write capacity units required for their DynamoDB tables. 
- It offers predictable and consistent performance by reserving a specific amount of capacity that is always available for the user's workloads.
- In provisioned mode, users pay for the provisioned capacity, whether it is utilized or not.

On-demand mode offers a flexible billing option where users are charged based on the actual usage of the DynamoDB tables. The capacity is automatically adjusted to support the user's application's workloads, and users are charged only for the capacity they have actually used. This provides a cost-effective solution for applications with unpredictable workloads.

Overall, provisioned mode offers predictable performance and pricing, while on-demand mode provides a cost-effective solution for applications with varying workloads. The choice between the two modes depends on the specific needs of the application. 

Note: 
Need to aware that, with on-demand mode, we pay x4 cost for WCU/RCU


 