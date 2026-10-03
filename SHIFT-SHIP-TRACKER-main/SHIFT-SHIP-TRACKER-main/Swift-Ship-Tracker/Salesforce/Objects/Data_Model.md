# Swift Ship Tracker Data Model

## Parcel__c
Core shipment record.

## Sender__c
Stores sender contact information.

## Receiver__c
Stores receiver contact information.

## Delivery__c
Stores delivery tracking information.

## Relationships

Sender → Parcel
Receiver → Parcel
Parcel → Delivery

## Lifecycle

Booked → In Transit → Out for Delivery → Delivered
