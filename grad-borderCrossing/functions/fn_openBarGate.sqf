#include "script_component.hpp"
/*
 * Arguments:
 * 0: areaArray <ARRAY>
 * 1: vehicle <OBJECT>
 * 2: guard <OBJECT>
 * 3: gate <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_areaArray, _vehicle, _guard, _gate] call grad_borderCrossing_fnc_openBarGate;
 *
 * Public: No
 */

params ["_areaArray", "_vehicle", "_guard", "_gate"];

_guard setVariable ["GRAD_BorderCrossing_vehicle", _vehicle];


[_guard,  "Acts_ShowingTheRightWay_in", 1] call ace_common_fnc_doAnimation;
_gate animate ["Door_1_rot", 1];


[{
	params ["_areaArray", "_guard", "_vehicle", "_gate"];
	count ([_vehicle] inAreaArray _areaArray) == 0
},
{
	params ["_areaArray", "_guard", "_vehicle", "_gate"];
	[_guard, "Acts_ShowingTheRightWay_out", 0] call ace_common_fnc_doAnimation;
	_guard setVariable ["GRAD_BorderCrossing_guard_busy", false];
	_gate animate ["Door_1_rot", 0];

}, [_areaArray, _guard, _vehicle, _gate]] call CBA_fnc_waitUntilAndExecute;
