@IsTest
private class ParcelTrackingControllerTest {

    @IsTest
    static void testParcelTracking() {
        Parcel__c parcel = new Parcel__c(
            Name = 'Test Parcel',
            Parcel_ID__c = 'SP1001',
            Status__c = 'In Transit',
            Weight__c = 2.5,
            Estimated_Delivery_Date__c = Date.today().addDays(3)
        );
        insert parcel;

        ParcelTrackingController.TrackingRequest request =
            new ParcelTrackingController.TrackingRequest();
        request.parcelId = 'SP1001';

        Test.startTest();
        List<ParcelTrackingController.TrackingResponse> result =
            ParcelTrackingController.trackParcel(
                new List<ParcelTrackingController.TrackingRequest>{request}
            );
        Test.stopTest();

        System.assertEquals(1, result.size());
        System.assertEquals('SP1001', result[0].parcelId);
        System.assertEquals('In Transit', result[0].status);
    }

    @IsTest
    static void testUnknownParcel() {
        ParcelTrackingController.TrackingRequest request =
            new ParcelTrackingController.TrackingRequest();
        request.parcelId = 'UNKNOWN';

        Test.startTest();
        List<ParcelTrackingController.TrackingResponse> result =
            ParcelTrackingController.trackParcel(
                new List<ParcelTrackingController.TrackingRequest>{request}
            );
        Test.stopTest();

        System.assertEquals('Parcel not found.', result[0].message);
    }
}
