sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'my.space.galacticspacefarerexplorer',
            componentId: 'SpaceFarerObjectPage',
            contextPath: '/SpaceFarer'
        },
        CustomPageDefinitions
    );
});