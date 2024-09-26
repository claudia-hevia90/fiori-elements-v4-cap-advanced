using TravelService from '../../srv/travel-service';
using from '../../db/schema';


//
// annotatios that control the fiori layout
//

annotate TravelService.Travel with @(
  UI                    : {

    Identification        : [
      {
        $Type : 'UI.DataFieldForAction',
        Action: 'TravelService.acceptTravel',
        Label : '{i18n>AcceptTravel}'
      },
      {
        $Type : 'UI.DataFieldForAction',
        Action: 'TravelService.rejectTravel',
        Label : '{i18n>RejectTravel}'
      },
      {
        $Type : 'UI.DataFieldForAction',
        Action: 'TravelService.deductDiscount',
        Label : '{i18n>DeductDiscount}'
      }
    ],
    HeaderInfo            : {
      TypeName      : '{i18n>Travel}',
      TypeNamePlural: '{i18n>Travels}',
      Title         : {
        $Type: 'UI.DataField',
        Value: Description
      },
      Description   : {
        $Type: 'UI.DataField',
        Value: TravelID
      }
    },
    PresentationVariant   : {
      Text          : 'Default',
      Visualizations: ['@UI.LineItem'],
      SortOrder     : [{
        $Type     : 'Common.SortOrderType',
        Property  : TravelID,
        Descending: true
      }]
    },
    SelectionFields       : [
      to_Agency_AgencyID,
      to_Customer_CustomerID,
      TravelStatus_code,
      BeginDate,
      EndDate,
    ],
    LineItem              : [
      {
        $Type : 'UI.DataFieldForAction',
        Action: 'TravelService.acceptTravel',
        Label : '{i18n>AcceptTravel}'
      },
      {
        $Type : 'UI.DataFieldForAction',
        Action: 'TravelService.rejectTravel',
        Label : '{i18n>RejectTravel}'
      },
      {
        Value            : TravelID,
        ![@UI.Importance]: #High
      },
      {
        Value            : to_Customer_CustomerID,
        ![@UI.Importance]: #High
      },
      {Value: BeginDate},
      {Value: EndDate},
      {Value: BookingFee},
      {Value: TotalPrice},
      {
        $Type            : 'UI.DataField',
        Value            : TravelStatus_code,
        Criticality      : TravelStatus.criticality,
        ![@UI.Importance]: #High
      },
      {Value: to_Agency_AgencyID},
      {
        $Type : 'UI.DataFieldForAction',
        Action: 'TravelService.deductDiscount',
        Label : '{i18n>DeductDiscount}',
      },
      {
        $Type : 'UI.DataFieldForAnnotation',
        Target: '@UI.DataPoint#Progress',
        Label : '{i18n>ProgressOfTravel}',
      },
    ],
    Facets                : [
      {
        $Type : 'UI.CollectionFacet',
        Label : '{i18n>GeneralInformation}',
        ID    : 'Travel',
        Facets: [
          { // travel details
            $Type : 'UI.ReferenceFacet',
            ID    : 'TravelData',
            Target: '@UI.FieldGroup#TravelData',
            Label : '{i18n>GeneralInformation}'
          },
          { // price information
            $Type : 'UI.ReferenceFacet',
            ID    : 'PriceData',
            Target: '@UI.FieldGroup#PriceData',
            Label : '{i18n>Prices}'
          },
          { // date information
            $Type : 'UI.ReferenceFacet',
            ID    : 'DateData',
            Target: '@UI.FieldGroup#DateData',
            Label : '{i18n>Dates}'
          }
        ]
      },
      { // booking list
        $Type : 'UI.ReferenceFacet',
        Target: 'to_Booking/@UI.PresentationVariant',
        Label : '{i18n>Bookings}'
      }
    ],
    FieldGroup #TravelData: {Data: [
      {Value: TravelID},
      {Value: to_Agency_AgencyID},
      {Value: to_Customer_CustomerID},
      {Value: Description},
      {
        $Type      : 'UI.DataField',
        Value      : TravelStatus_code,
        Criticality: TravelStatus.criticality,
        Label      : '{i18n>Status}' // label only necessary if differs from title of element
      }
    ]},
    FieldGroup #DateData  : {Data: [
      {
        $Type: 'UI.DataField',
        Value: BeginDate
      },
      {
        $Type: 'UI.DataField',
        Value: EndDate
      }
    ]},
    FieldGroup #PriceData : {Data: [
      {
        $Type: 'UI.DataField',
        Value: BookingFee
      },
      {
        $Type: 'UI.DataField',
        Value: TotalPrice
      }
    ]}
  },
  UI.DataPoint #Progress: {
    Value        : Progress,
    Visualization: #Progress,
    TargetValue  : 100,
  },
);

annotate TravelService.Booking with @(
  UI                            : {
    Identification                : [{Value: BookingID}, ],
    HeaderInfo                    : {
      TypeName      : '{i18n>Bookings}',
      TypeNamePlural: '{i18n>Bookings}',
      Title         : {Value: to_Customer.LastName},
      Description   : {Value: BookingID}
    },
    PresentationVariant           : {
      Visualizations: ['@UI.LineItem'],
      SortOrder     : [{
        $Type     : 'Common.SortOrderType',
        Property  : BookingID,
        Descending: false
      }]
    },
    SelectionFields               : [],
    LineItem                      : [
      {
        Value: to_Carrier.AirlinePicURL,
        Label: '  '
      },
      {Value: BookingID},
      {Value: BookingDate},
      {Value: to_Customer_CustomerID},
      {Value: to_Carrier_AirlineID},
      {
        Value: ConnectionID,
        Label: '{i18n>FlightNumber}'
      },
      {Value: FlightDate},
      {Value: FlightPrice},
      {Value: BookingStatus_code},
      {
        $Type : 'UI.DataFieldForAnnotation',
        Target: '@UI.Chart#TotalSupplPrice1',
        Label : '{i18n>Suplemments}',
      },
    ],
    Facets                        : [
      {
        $Type : 'UI.CollectionFacet',
        Label : '{i18n>GeneralInformation}',
        ID    : 'Booking',
        Facets: [
          { // booking details
            $Type : 'UI.ReferenceFacet',
            ID    : 'BookingData',
            Target: '@UI.FieldGroup#GeneralInformation',
            Label : '{i18n>Booking}'
          },
          { // flight details
            $Type : 'UI.ReferenceFacet',
            ID    : 'FlightData',
            Target: '@UI.FieldGroup#Flight',
            Label : '{i18n>Flight}'
          }
        ]
      },
      { // supplements list
        $Type : 'UI.ReferenceFacet',
        Target: 'to_BookSupplement/@UI.PresentationVariant',
        Label : '{i18n>BookingSupplements}'
      }
    ],
    FieldGroup #GeneralInformation: {Data: [
      {Value: BookingID},
      {Value: BookingDate, },
      {Value: to_Customer_CustomerID},
      {Value: BookingDate, },
      {Value: BookingStatus_code}
    ]},
    FieldGroup #Flight            : {Data: [
      {Value: to_Carrier_AirlineID},
      {Value: ConnectionID},
      {Value: FlightDate},
      {Value: FlightPrice}
    ]},
  },
  UI.DataPoint #TotalSupplPrice : {
    Value       : TotalSupplPrice,
    MinimumValue: 0,
    MaximumValue: 120,
  },
  UI.Chart #TotalSupplPrice     : {
    ChartType        : #Bullet,
    Measures         : [TotalSupplPrice, ],
    MeasureAttributes: [{
      DataPoint: '@UI.DataPoint#TotalSupplPrice',
      Role     : #Axis1,
      Measure  : TotalSupplPrice,
    }, ],
  },
  UI.DataPoint #TotalSupplPrice1: {
    Value       : TotalSupplPrice,
    MinimumValue: 0,
    MaximumValue: 120,
  },
  UI.Chart #TotalSupplPrice1    : {
    ChartType        : #Bullet,
    Measures         : [TotalSupplPrice, ],
    MeasureAttributes: [{
      DataPoint: '@UI.DataPoint#TotalSupplPrice1',
      Role     : #Axis1,
      Measure  : TotalSupplPrice,
    }, ],
  },
);

annotate TravelService.BookingSupplement with @UI: {
  Identification     : [{Value: BookingSupplementID}],
  HeaderInfo         : {
    TypeName      : '{i18n>BookingSupplement}',
    TypeNamePlural: '{i18n>BookingSupplements}',
    Title         : {Value: BookingSupplementID},
    Description   : {Value: BookingSupplementID}
  },
  PresentationVariant: {
    Text          : 'Default',
    Visualizations: ['@UI.LineItem'],
    SortOrder     : [{
      $Type     : 'Common.SortOrderType',
      Property  : BookingSupplementID,
      Descending: false
    }]
  },
  LineItem           : [
    {Value: BookingSupplementID},
    {
      Value: to_Supplement_SupplementID,
      Label: '{i18n>ProductID}'
    },
    {
      Value: Price,
      Label: '{i18n>ProductPrice}'
    }
  ],
};

annotate TravelService.Flight with @UI: {PresentationVariant #SortOrderPV: { // used in the value help for ConnectionId in Bookings
SortOrder: [{
  Property  : FlightDate,
  Descending: true
}]}};
