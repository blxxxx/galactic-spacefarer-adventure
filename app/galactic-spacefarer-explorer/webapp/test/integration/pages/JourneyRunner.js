sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"my/space/galacticspacefarerexplorer/test/integration/pages/SpaceFarerList",
	"my/space/galacticspacefarerexplorer/test/integration/pages/SpaceFarerObjectPage"
], function (JourneyRunner, SpaceFarerList, SpaceFarerObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('my/space/galacticspacefarerexplorer') + '/test/flp.html#app-preview',
        pages: {
			onTheSpaceFarerList: SpaceFarerList,
			onTheSpaceFarerObjectPage: SpaceFarerObjectPage
        },
        async: true
    });

    return runner;
});

