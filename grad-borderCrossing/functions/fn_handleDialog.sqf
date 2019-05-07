
/*
* Arguments:
* None
*
* Return Value:
* None
*
* Example:
* [] call GRAD_BorderCrossing_fnc_handleDiaglog;
*
* Public: No
*/

/*
systemChat "Opening Dialog";
private _dialog = createDialog "RscDisplayGame";
if !(_dialog) exitWith {
   diag_log "The dialog to handle passport check could not open!";
   player setVariable ["GRAD_BorderCrossing_playerCheck", true];
};
*/
player setVariable ["GRAD_BorderCrossing_playerCheck", true, true];
