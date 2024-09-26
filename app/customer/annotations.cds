using TravelService as service from '../../srv/travel-service';
annotate service.Passenger with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : CustomerID,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>CountryCode}',
                Value : CountryCode_code,
            },
            {
                $Type : 'UI.DataField',
                Value : PostalCode,
            },
            {
                $Type : 'UI.DataField',
                Value : Street,
            },
            {
                $Type : 'UI.DataField',
                Value : City,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : FullName,
        },
        {
            $Type : 'UI.DataField',
            Value : CountryCode.code,
        },
        {
            $Type : 'UI.DataField',
            Value : CountryCode.descr,
        },
        {
            $Type : 'UI.DataField',
            Value : PostalCode,
        },
        {
            $Type : 'UI.DataField',
            Value : Street,
        },
        {
            $Type : 'UI.DataField',
            Value : City,
        },
    ],
    UI.SelectionFields : [
        CountryCode_code,
        City,
        PostalCode,
    ],
    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Contact Detail',
            ID : 'ContactDetail',
            Target : '@UI.FieldGroup#ContactDetail',
        },
    ],
    UI.FieldGroup #ContactDetail : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : FullName,
            },
            {
                $Type : 'UI.DataField',
                Value : PhoneNumber,
            },
            {
                $Type : 'UI.DataField',
                Value : EMailAddress,
            },
        ],
    },
    UI.HeaderInfo : {
        TypeName : '{i18n>CustomerID}',
        TypeNamePlural : '{i18n>Customers}',
        Title : {
            $Type : 'UI.DataField',
            Value : FullName,
        },
    },
);

