using {IntergalacticService} from './intergalactic-service.cds';

annotate IntergalacticService.SpaceFarer with @(restrict: [{
    grant: '*',
    where: 'originPlanet_ID = $user.originPlanet'
}]);

annotate IntergalacticService.Planet with @(restrict: [{
    grant: '*',
    where: 'ID = $user.originPlanet'
}]);
