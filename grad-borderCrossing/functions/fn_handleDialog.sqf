#include "script_component.hpp"
/*
* Arguments:
* None
*
* Return Value:
* None
*
* Example:
* [] call grad_borderCrossing_fnc_handleDiaglog;
*
* Public: No
*/

private _dialog = createDialog "RscDisplayGame";
if !(_dialog) exitWith {
   ERROR_WITH_TITLE("Dialog not open","The dialog to handle passport check could not open!");
   player getVariable ["GRAD_BorderCrossing_playerCheck", [player, true], true];
};