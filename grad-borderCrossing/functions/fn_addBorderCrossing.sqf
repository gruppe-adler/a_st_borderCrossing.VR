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
 * [this, "B_Story_SF_Captain_F", east] call GRAD_BorderCrossing_fnc_addBorderCrossing;
 *
 * Public: No
 */

params ["_gate", "_gateGuardClass", "_side", ["_guardClass", ""], ["_speedSign", "CUP_sign_speed20"]];

[_gate] call GRAD_BorderCrossing_fnc_gateDestroyedEH;

if (_guardClass == "") then {
		_guardClass = _gateGuardClass;
};

private _areaDistance = 100;
private _areaWidth = 5;

private _gatePos = position _gate;
private _areaPos = _gatePos getPos [_areaDistance/2, (getDir _gate) + 180];

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

private _guards = _gate getVariable ["GRAD_BorderCrossing_ssignedGuards", []];
_guards pushBackUnique _gateGuard;
_guards pushBackUnique _guard;
_gate setVariable ["GRAD_BorderCrossing_ssignedGuards", _guards, true];

private _speedSignPos = _gatePos getPos [100, (getDir _gate) + 180];
_speedSignPos set [2,-1];
private _speedSign = _speedSign createVehicle _speedSignPos;
_speedSign setDir ((getDir _gate) + 0);


// area to check for vehicles wanting to get in
private _areaArray = [_areaPos, _areaWidth, _areaDistance, 0, true, 10];

// debug
if (DEBUG_MODE_FULL) then {
	["mrk_GRAD_BorderCrossing_area", _areaPos, "Rectangle", [_areaWidth,_areaDistance], "ColorYellow"] call CBA_fnc_createMarker;
};

[{
	params ["_args", "_handle"];
	 _args params ["_areaArray", "_gateGuard", "_gatePos", "_gate", "_guard"];

    // if alarm runs, dont do anything
    if (_gateGuard getVariable ["GRAD_BorderCrossing_larmRaised", false]) exitWith {};

	// only accept cars
    private _vehiclesWaiting = (
    	(_gatePos nearEntities [["Man"], 200]) inAreaArray _areaArray
    ) select {
    	side _x != west && {(driver (vehicle _x)) isEqualTo _x} && {alive _x}
    };

    systemChat str _vehiclesWaiting;

	 if (count _vehiclesWaiting > 0 && !(_gateGuard getVariable ["GRAD_BorderCrossing_guard_busy", true])) then {
	 	systemChat "guard active";
	 	_gateGuard setVariable ["GRAD_BorderCrossing_guard_busy", true];


		private _vehicle = [_vehiclesWaiting, _gate] call GRAD_BorderCrossing_fnc_getBorderCrossingVehicle;
		if (!isNull _vehicle) then {
			[_areaArray, _vehicle, _gateGuard, _gate] call GRAD_BorderCrossing_fnc_directVehicle;
		} else {
			_gateGuard setVariable ["GRAD_BorderCrossing_guard_busy", false];
		};
	};

	// todo add condition to end loop
	if !([_gate, _gateGuard, _guard] call CBA_fnc_isAlive) then {
		[_handle] call CBA_fnc_removePerFrameHandler;
	};

},1,[_areaArray, _gateGuard, _gatePos, _gate, _guard]] call CBA_fnc_addPerFrameHandler;
