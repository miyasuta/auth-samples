sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'miyasuta/salesorderui/test/integration/pages/MainListReport' ,
        'miyasuta/salesorderui/test/integration/pages/MainObjectPage',
        'miyasuta/salesorderui/test/integration/OpaJourney'
    ],
    function(JourneyRunner, MainListReport, MainObjectPage, Journey) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('miyasuta/salesorderui') + '/index.html'
        });

        
        JourneyRunner.run(
            {
                pages: { onTheMainPage: MainListReport, onTheDetailPage: MainObjectPage }
            },
            Journey.run
        );
        
    }
);