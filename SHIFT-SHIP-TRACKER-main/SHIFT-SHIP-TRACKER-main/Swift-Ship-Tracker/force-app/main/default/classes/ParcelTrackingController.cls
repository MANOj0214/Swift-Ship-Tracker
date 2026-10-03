public with sharing class ParcelTrackingController {

    public class TrackingRequest {
        @InvocableVariable(required=true label='Parcel ID')
        public String parcelId;
    }

    public class TrackingResponse {
        @InvocableVariable(label='Parcel ID')
        public String parcelId;

        @InvocableVariable(label='Status')
        public String status;

        @InvocableVariable(label='Estimated Delivery')
        public String estimatedDelivery;

        @InvocableVariable(label='Message')
        public String message;
    }

    @InvocableMethod(
        label='Track Parcel'
        description='Retrieves parcel tracking information'
    )
    public static List<TrackingResponse> trackParcel(
        List<TrackingRequest> requests
    ) {
        Set<String> parcelIds = new Set<String>();

        for (TrackingRequest req : requests) {
            if (req != null && String.isNotBlank(req.parcelId)) {
                parcelIds.add(req.parcelId.trim());
            }
        }

        Map<String, Parcel__c> parcelMap = new Map<String, Parcel__c>();

        if (!parcelIds.isEmpty()) {
            for (Parcel__c parcel : [
                SELECT Parcel_ID__c, Status__c, Estimated_Delivery_Date__c
                FROM Parcel__c
                WHERE Parcel_ID__c IN :parcelIds
                WITH USER_MODE
            ]) {
                parcelMap.put(parcel.Parcel_ID__c, parcel);
            }
        }

        List<TrackingResponse> results = new List<TrackingResponse>();

        for (TrackingRequest req : requests) {
            TrackingResponse response = new TrackingResponse();
            String id = req == null ? null : req.parcelId;

            if (String.isBlank(id)) {
                response.message = 'Please provide a Parcel ID.';
            } else {
                id = id.trim();
                response.parcelId = id;
                Parcel__c parcel = parcelMap.get(id);

                if (parcel == null) {
                    response.message = 'Parcel not found.';
                } else {
                    response.status = parcel.Status__c;
                    response.estimatedDelivery =
                        parcel.Estimated_Delivery_Date__c == null
                        ? 'Not available'
                        : String.valueOf(parcel.Estimated_Delivery_Date__c);
                    response.message =
                        'Parcel ' + id + ' status: ' + parcel.Status__c;
                }
            }
            results.add(response);
        }
        return results;
    }

    @AuraEnabled
    public static TrackingResponse getParcel(String parcelId) {
        TrackingResponse response = new TrackingResponse();

        if (String.isBlank(parcelId)) {
            response.message = 'Enter a Parcel ID.';
            return response;
        }

        List<Parcel__c> records = [
            SELECT Parcel_ID__c, Status__c, Estimated_Delivery_Date__c
            FROM Parcel__c
            WHERE Parcel_ID__c = :parcelId.trim()
            WITH USER_MODE
            LIMIT 1
        ];

        if (records.isEmpty()) {
            response.message = 'Parcel not found.';
            return response;
        }

        Parcel__c parcel = records[0];
        response.parcelId = parcel.Parcel_ID__c;
        response.status = parcel.Status__c;
        response.estimatedDelivery =
            parcel.Estimated_Delivery_Date__c == null
            ? 'Not available'
            : String.valueOf(parcel.Estimated_Delivery_Date__c);
        response.message = 'Tracking information retrieved successfully.';
        return response;
    }
}
