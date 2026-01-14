using {my.space as db} from '../db/schema';


service IntergalacticService {
    @odata.draft.enabled
    entity SpaceFarer as
        projection on db.SpaceFarer {
            ID,
            name,
            email,
            suiteColor,
            collectedStardust,
            wormholeNavigationSkill,
            department,
            position,
            originPlanet
        }
}

annotate IntergalacticService.SpaceFarer with @(
    title: '{i18n>SpaceFarer}',
    UI   : {
        HeaderInfo            : {
            TypeName      : '{i18n>SpaceFarer}',
            TypeNamePlural: '{i18n>SpaceFarers}',
            Title         : {Value: name},
            Description   : {Value: position.title}
        },
        Facets                : [
            {
                $Type : 'UI.ReferenceFacet',
                Label : '{i18n>GeneralInformation}',
                Target: '@UI.FieldGroup#General'
            },
            {
                $Type : 'UI.ReferenceFacet',
                Label : '{i18n>JobDetails}',
                Target: '@UI.FieldGroup#JobDetails'
            }
        ],
        FieldGroup #General   : {Data: [
            {Value: name},
            {Value: email},
            {Value: suiteColor},
            {Value: collectedStardust},
            {Value: wormholeNavigationSkill},
            {Value: originPlanet_ID}
        ]},
        FieldGroup #JobDetails: {Data: [
            {Value: department_ID},
            {Value: position_ID}
        ]},
        LineItem              : [
            {
                $Type: 'UI.DataField',
                Value: name
            },
            {
                $Type: 'UI.DataField',
                Value: email
            },
            {
                $Type: 'UI.DataField',
                Value: suiteColor
            },
            {
                $Type: 'UI.DataField',
                Value: collectedStardust
            },
            {
                $Type: 'UI.DataField',
                Value: wormholeNavigationSkill
            },
            {
                $Type: 'UI.DataField',
                Value: department_ID
            },
            {
                $Type: 'UI.DataField',
                Value: position_ID
            },
            {
                $Type: 'UI.DataField',
                Value: originPlanet_ID
            }
        ]
    }
) {
    name                    @(title: '{i18n>SpaceFarer_name}');
    email                   @(title: '{i18n>SpaceFarer_email}');
    suiteColor              @(title: '{i18n>SpaceFarer_suiteColor}');
    collectedStardust       @(title: '{i18n>SpaceFarer_collectedStardust}');
    wormholeNavigationSkill @(title: '{i18n>SpaceFarer_wormholeNavigationSkill}');
    department              @(
        title                 : '{i18n>SpaceFarer_department}',
        Common.Text           : department.name,
        Common.TextArrangement: #TextOnly,
        Common.ValueList      : {
            CollectionPath: 'IntergalacticDepartment',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'description'
                }
            ]
        }
    );
    position                @(
        title                 : '{i18n>SpaceFarer_position}',
        Common.Text           : position.title,
        Common.TextArrangement: #TextOnly,
        Common.ValueList      : {
            CollectionPath: 'IntergalacticPosition',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'title'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'minStardust'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'minWormholeNavigationSkill'
                }
            ]
        }
    );
    originPlanet            @(
        title                 : '{i18n>SpaceFarer_originPlanet}',
        Common.Text           : originPlanet.name,
        Common.TextArrangement: #TextOnly,
        Common.ValueList      : {
            CollectionPath: 'Planet',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'name'
            }]
        }
    );
};

annotate IntergalacticService.Planet with @(title: '{i18n>Planet}') {
    ID   @(
        Common.Text           : name,
        Common.TextArrangement: #TextOnly,
    );
    name @(title: '{i18n>Planet_name}');
};

annotate IntergalacticService.IntergalacticDepartment with @(title: '{i18n>IntergalacticDepartment}') {
    ID          @(
        Common.Text           : name,
        Common.TextArrangement: #TextOnly,
    );
    name        @(title: '{i18n>IntergalacticDepartment_name}');
    description @(title: '{i18n>IntergalacticDepartment_description}');
};

annotate IntergalacticService.IntergalacticPosition with @(title: '{i18n>IntergalacticPosition}') {
    ID                         @(
        Common.Text           : title,
        Common.TextArrangement: #TextOnly,
    );
    title                      @(title: '{i18n>IntergalacticPosition_title}');
    minStardust                @(title: '{i18n>IntergalacticPosition_minStardust}');
    minWormholeNavigationSkill @(title: '{i18n>IntergalacticPosition_minWormholeNavigationSkill}');
};
