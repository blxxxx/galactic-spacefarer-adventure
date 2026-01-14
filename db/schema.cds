namespace my.space;

using {
    cuid,
    managed,
} from '@sap/cds/common';

entity SpaceFarer : cuid, managed {
    key ID                      : UUID;
        name                    : String(20)                                 @mandatory;
        email                   : String(100)                                @mandatory  @assert.format: '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
        suiteColor              : String(20)                                 @mandatory;
        collectedStardust       : Integer                                    @mandatory;
        wormholeNavigationSkill : Integer                                    @mandatory  @assert.range : [
            0,
            10
        ];
        department              : Association to one IntergalacticDepartment @mandatory;
        position                : Association to one IntergalacticPosition   @mandatory;
        originPlanet            : Association to one Planet                  @mandatory;
}

@cds.autoexpose
entity Planet {
    key ID   : String(20);
        name : String(20);
}

@cds.autoexpose
entity IntergalacticDepartment {
    key ID          : UUID;
        name        : String(20);
        description : String(200);

}

@cds.autoexpose
entity IntergalacticPosition {
    key ID                         : UUID;
        title                      : String(50);
        minStardust                : Integer;
        minWormholeNavigationSkill : Integer @assert.range: [
            0,
            10
        ]
}
