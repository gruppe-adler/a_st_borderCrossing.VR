#include "script_component.hpp"
/*
 * Arguments:
 * 0: gate <OBJECT>
 * 1: gateGuardClass <STRING>
 * 2: side <SIDE>
 * 3: guardClass <STRING> <OPTIONAL>
 * 4: speedSign <STRING> <OPTIONAL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [this, "B_Story_SF_Captain_F", east] call grad_borderCrossing_fnc_addBorderCrossing;
 *
 * Public: No
 */

params ["_gate", "_gateGuardClass", "_side", ["_guardClass", ""], ["_speedSign", "CUP_sign_speed20"]];


[_gate] call grad_borderCrossing_fnc_gateDestroyedEH;

if (_guardClass == "") then {
		_guardClass = _gateGuardClass;
};

private _areaDistance = 50;
private _areaWidth = 10;

private _gatePos = getPos _gate;
private _areaPos = _gatePos getPos [_areaDistance, (getDir _gate) + 185];

private _gateGuard = (createGroup _side) createUnit [_gateGuardClass, (_gatePos getPos [10, (getDir _gate) + 240]), [], 0, "CAN_COLLIDE"];
private _guard = (createGroup _side) createUnit [_gateGuardClass, (_gatePos getPos [20, (getDir _gate) + 180]), [], 0, "CAN_COLLIDE"];

_guard setDir ((getDir _gate) + 180);
_gateGuard setDir ((getDir _gate) + 180);
doStop _guard;
doStop _gateGuard;

_gateGuard setVariable ["GRAD_BorderCrossing_guard_busy", false];
_gateGuard setVariable ["GRAD_BorderCrossing_gate", _gate];
_guard disableAI "ANIM";
_gateGuard disableAI "ANIM";

//add the guards to the GVAR
private _guards = _gate getVariable ["GRAD_BorderCrossing_assignedGuards", []];
_guards pushBackUnique _gateGuard;
_guards pushBackUnique _guard;
_gate setVariable ["GRAD_BorderCrossing_assignedGuards", _guards, true];

//create speed sign
private _speedSignPos = _gatePos getPos [100, (getDir _gate) + 180];
_speedSignPos set [2,-1.5];
private _speedSign = _speedSign createVehicle _speedSignPos;
_speedSign setDir ((getDir _gate) + 0);


// area to check for vehicles wanting to get in
private _areaArray = [_areaPos, _areaWidth, _areaDistance, 0, true, 10];

//trigger to handle vehicle checks
private _trigger = ([(_gatePos getPos [10, (getDir _gate) + 220]), "AREA:", [3, 3, 0, false], "ACT:", ["ANY", "PRESENT", true], "STATE:", ["(side (thisList select 0)) in [ resistance, civilian]", "[thisTrigger, thisList] call grad_borderCrossing_fnc_checkVehicle;", "[thisTrigger] call grad_borderCrossing_fnc_triggerClear;"]] call CBA_fnc_createTrigger) select 0;
_trigger setVariable ["GRAD_BorderCrossing_gateGuard", _gateGuard];

//debug
if (true) then {
	["mrk_GRAD_BorderCrossing_area", (_gatePos getPos [10, (getDir _gate) + 220]), "Rectangle", [3,3], "COLOR:", "ColorRed"] call CBA_fnc_createMarker;
	//["mrk_GRAD_BorderCrossing_area", _areaPos, "Rectangle", [_areaWidth,_areaDistance], "COLOR:", "ColorYellow"] call CBA_fnc_createMarker;
};

[{
	params ["_args", "_handle"];
	 _args params ["_areaArray", "_guard", "_gatePos", "_gate"];

	 //condition to end loop
 	if !([_gate, _gateGuard, _guard] call CBA_fnc_isAlive) then {
 		[_handle] call CBA_fnc_removePerFrameHandler;
 	};

    // if alarm runs, dont do anything
    if (_guard getVariable ["GRAD_borderCrossing_alarmRaised", false]) exitWith {};

	// only accept cars
    private _queue = _gate getVariable ["GRAD_BorderCrossing_queue", []];

	 {
		 diag_log format ["IsWest: %1", (side _x != west)];
		 diag_log format ["IsEast: %1", side _x != east];
		 diag_log format ["IsDriver: %1, Driver: %2, X: %3", (driver (vehicle _x)) isEqualTo _x, driver (vehicle _x), _x];
		 diag_log format ["IsAlive: %1 ", alive _x];

		 if (side _x != west && {side _x != east} && {(driver (vehicle _x)) isEqualTo _x} && {(alive _x)}) then {
			 diag_log format ["Add: %1 ", _x];
			_queue pushBackUnique _x;
		 };
	 }forEach (_gatePos nearEntities ["Man", 200]) inAreaArray _areaArray;
	 diag_log str(_queue);

	  if !(_queue isEqualTo []) then {
		  {
			  if (_x in _vehiclesWaiting) then {
				 _vehiclesWaiting deleteAt (_vehiclesWaiting find _x);
			  };
		  }forEach _queue;
	  };

	  if (count _vehiclesWaiting > 0) then {
		  _queue = _queue + _vehiclesWaiting;
		  _gate setVariable ["GRAD_BorderCrossing_queue", _queue, true];
	  };

},1,[_areaArray, _guard, _gatePos, _gate]] call CBA_fnc_addPerFrameHandler;

[_guard, _gate, _gateGuard] call grad_borderCrossing_fnc_handleQueue;
