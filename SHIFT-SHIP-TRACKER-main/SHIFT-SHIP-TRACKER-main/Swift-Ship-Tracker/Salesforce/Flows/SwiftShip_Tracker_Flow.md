# SwiftShip Tracker Flow

## Flow Type
Record-Triggered Flow

## Object
Parcel__c

## Trigger
When a Parcel record is created or updated and the status changes.

## Intended Logic

1. Start when Parcel__c is created or updated.
2. Check whether Status__c changed.
3. Get the related Delivery__c record.
4. If no Delivery record exists, create one.
5. If it exists, update its Delivery_Status__c.
6. Copy Estimated_Delivery_Date__c to Delivery_Date__c.
7. Save the Delivery record.
8. Optionally invoke an email notification action.

## Important
Build and activate this Flow in the target Salesforce org, then retrieve the resulting Flow metadata into `force-app/main/default/flows/`.
