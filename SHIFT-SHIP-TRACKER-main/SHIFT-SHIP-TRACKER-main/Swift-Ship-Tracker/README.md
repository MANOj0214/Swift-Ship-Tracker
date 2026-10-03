# Swift Ship Tracker

## AI-Powered Parcel Delivery Management System

Swift Ship Tracker is a Salesforce CRM-based parcel management prototype that combines custom data modelling, Flow automation, Apex, Lightning Web Components, security controls, and Agentforce AI to support the parcel lifecycle from booking to delivery.

## Core Features

- Parcel, Sender, Receiver and Delivery data model
- Parcel lifecycle tracking
- Automated delivery record creation/update
- Apex parcel tracking action
- Lightning Web Component tracking interface
- Agentforce parcel tracking configuration
- Prompt Builder guidance
- Permission-set based access control
- Documentation and demo evidence

## Parcel Lifecycle

`Booked → In Transit → Out for Delivery → Delivered`

## Repository Structure

```text
Swift-Ship-Tracker/
├── README.md
├── sfdx-project.json
├── Documentation/
├── Ideation-Phase/
├── force-app/main/default/
│   ├── objects/
│   ├── flows/
│   ├── classes/
│   ├── lwc/
│   └── permissionsets/
├── Salesforce/
│   ├── Agentforce/
│   ├── Flows/
│   ├── Objects/
│   └── Apex/
└── Screenshots/
```

## Setup

1. Install Salesforce CLI and Salesforce Extension Pack for VS Code.
2. Open this repository in VS Code.
3. Authenticate to a Salesforce Developer Org:

```bash
sf org login web --alias SwiftShipOrg --set-default
```

4. Deploy the source:

```bash
sf project deploy start --source-dir force-app/main/default --target-org SwiftShipOrg
```

5. Run the Apex test:

```bash
sf apex run test --class-names ParcelTrackingControllerTest --target-org SwiftShipOrg --result-format human --wait 10
```

6. Configure the Flow and Agentforce components using the included configuration documentation.
7. Add the `parcelTracker` LWC to a Lightning App Page.

## Important

The Agentforce configuration is documented under `Salesforce/Agentforce/`. Agentforce setup can vary by Salesforce org edition, enabled features, permissions, and current platform capabilities, so the configuration should be completed and validated inside the target org.

## Demo Test Data

Example Parcel ID:

`SP1001`

Example status:

`In Transit`

## Project Status

Academic Salesforce CRM prototype.

## Future Enhancements

- GPS tracking
- Courier API integrations
- Mobile application
- Predictive delivery analytics
- Advanced AI assistance
- Production sandbox/UAT and CI/CD
