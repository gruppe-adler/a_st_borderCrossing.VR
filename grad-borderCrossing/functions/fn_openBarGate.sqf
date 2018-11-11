params ["_areaArray", "_vehicle", "_guard", "_gate"];

_guard setVariable ["grad_borderCrossing_vehicle", _vehicle];
_guard setVariable ["grad_borderCrossing_gate", _gate];

_guard playMoveNow "Acts_ShowingTheRightWay_in";
_gate animate ["Door_1_rot", 1];


_guard addEventHandler ["AnimDone", {
	params ["_unit", "_anim"];

	if (_anim == "Acts_ShowingTheRightWay_in") then {
		_unit playMoveNow "Acts_ShowingTheRightWay_loop";
	};

	if (_anim == "Acts_ShowingTheRightWay_loop") then {
		_unit playMove "Acts_ShowingTheRightWay_loop";
	};
}];

[{
	params ["_areaArray", "_guard", "_vehicle", "_gate"];
	count ([_vehicle] inAreaArray _areaArray) == 0
},
{
	params ["_areaArray", "_guard", "_vehicle", "_gate"];
	_guard removeAllEventHandlers "AnimDone";
	_guard playMoveNow "Acts_ShowingTheRightWay_out";
	_guard setVariable ["grad_borderCrossing_guard_busy", false];
	_gate animate ["Door_1_rot", 0];
		
}, [_areaArray, _guard, _vehicle, _gate]] call CBA_fnc_waitUntilAndExecute;