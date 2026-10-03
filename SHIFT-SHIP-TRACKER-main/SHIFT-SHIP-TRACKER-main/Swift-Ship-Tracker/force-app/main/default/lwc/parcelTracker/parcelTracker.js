import { LightningElement } from 'lwc';
import getParcel from '@salesforce/apex/ParcelTrackingController.getParcel';

export default class ParcelTracker extends LightningElement {
    parcelId = '';
    result;
    errorMessage;

    handleInput(event) {
        this.parcelId = event.target.value;
    }

    async handleTrack() {
        this.result = undefined;
        this.errorMessage = '';

        if (!this.parcelId.trim()) {
            this.errorMessage = 'Please enter a Parcel ID.';
            return;
        }

        try {
            this.result = await getParcel({
                parcelId: this.parcelId.trim()
            });

            if (!this.result.parcelId) {
                this.errorMessage = this.result.message;
                this.result = undefined;
            }
        } catch (error) {
            this.errorMessage =
                error.body?.message || 'Unable to retrieve parcel.';
        }
    }
}
