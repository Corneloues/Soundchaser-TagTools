/**
 * icon (svg/jpg) must be present in the skin\icon folder anbd have the exact same name and case as in the 2nd parameter.
 */

(function () {
    window.uitools.addToolButton('righttoolbuttons', 'ClearComments', function () {
		actions.ClearComments.execute();
    }, 'Clear Comments');

    window.uitools.addToolButton('righttoolbuttons', 'ClearEverything', function () {
		actions.ClearEverything.execute();
    }, 'Clear Everything');

//    window.uitools.addToolButton('righttoolbuttons', 'ActionTemplate', function () {
// 		actions.ClearEverything.execute();
//     }, 'Action Tooltip');
})();