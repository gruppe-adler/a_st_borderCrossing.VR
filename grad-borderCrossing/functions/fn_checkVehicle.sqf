#include "script_component.hpp"
params ["_areaArray", "_guard", "_vehicle", "_gate"];

_guard playMoveNow "Acts_PercMstpSlowWrflDnon_handup2c";

_guard setVariable ["GRAD_BorderCrossing_guard_vehicle", _vehicle];
_guard setVariable ["GRAD_BorderCrossing_guard_gate", _gate];


_guard addEventHandler ["AnimDone", {
	params ["_unit", "_anim"];

	private _status = _unit getVariable ["GRAD_BorderCrossing_status", "unknown"];

	if (_status isEqualTo "combat") exitWith {

	};

	if (_status isEqualTo "denied") exitWith {
		switch (_anim) do {
			case "Acts_listeningToRadio_Loop": {
				_unit playmovenow "Acts_listeningToRadio_Out";
			};
			case "Acts_listeningToRadio_Out": {
				_unit playActionNow "ace_gestures_point";
			};
			default {
			};
		};
	};

	if (_status isEqualTo "accepted") exitWith {
		switch (_anim) do {
			case "Acts_listeningToRadio_Loop": {
				_unit playmovenow "Acts_listeningToRadio_Out";
			};
			case "Acts_ShowingTheRightWay_in" : {
				_unit playMoveNow "Acts_ShowingTheRightWay_loop";
			};
			case "Acts_ShowingTheRightWay_loop" : {
				_unit playMoveNow "Acts_ShowingTheRightWay_out";
			};
			default {
				_unit playMoveNow "Acts_ShowingTheRightWay_in";
			};
		};
		// AmovPercMstpSlowWrflDnon_gear
		// AmovPercMstpSlowWrflDnon_diary
	};

	if (_status isEqualTo "checking") exitWith {
		switch (_anim) do {
			case "Acts_listeningToRadio_In": {
				_unit playMoveNow "Acts_listeningToRadio_Loop";
			};
			case "Acts_listeningToRadio_Loop": {
				_unit playMoveNow "Acts_listeningToRadio_Loop";
			};
			default {
				_unit playMoveNow "Acts_listeningToRadio_In";
			};
		};
	};

	switch (_anim) do {
		case "Acts_PercMstpSlowWrflDnon_handup2c": {
			_unit playMoveNow "Acts_PercMstpSlowWrflDnon_handup2c";
		};


		case "Acts_listeningToRadio_In" : {
			_unit playMoveNow "Acts_listeningToRadio_Loop";
		};
		case "Acts_listeningToRadio_Loop" : {
			_unit playMoveNow "Acts_listeningToRadio_Out";
		};
		case "Acts_listeningToRadio_Out": {
			// return to default
		};


		case "Acts_JetsMarshallingSlow_in" : {
			_unit playMoveNow "Acts_JetsMarshallingSlow_Loop";
		};
		case "Acts_JetsMarshallingSlow_Loop" : {
			_unit playMoveNow "Acts_JetsMarshallingSlow_Out";
		};


		default { };
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
	_guard setVariable ["GRAD_BorderCrossing_guard_busy", false];
	_gate animate ["Door_1_rot", 0];
	_guard setRandomLip false;

}, [_areaArray, _guard, _vehicle, _gate]] call CBA_fnc_waitUntilAndExecute;
