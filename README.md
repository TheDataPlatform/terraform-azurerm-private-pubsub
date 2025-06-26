# terraform-azurerm-private-pubsub
A spoke module with pubsub and private endpoints.

Make sure to add `.terraform.lock.hcl` to the gitignore file to avoid publishing terraform lock files.

# High-Level Objectives

All resources will be private endpointed and deployed to a spoke.  We will reference hub resources, which is a prerequisite.

- resource group
- user assigned identity for passwordless authentication and intra subscription tasks
- blob storage
- azure functions to stage the data
- database with a schema for staging the data
- azure app service for data enrichment
- database with a schema for servicing the data (second schema in the same database)
- service bus for pub sub 
- function app for processing downstream api calls
- log analytics workspace
- app insights
- key vault for storing connection strings

# Potential Enhancement

- eventgrid
- storage queue for enhanced event driven architecture
- eventhub for additional decoupling options


