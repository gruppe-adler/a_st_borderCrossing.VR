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

private _areaDistance = 100;
private _areaWidth = 10;

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

//add the guards to the GVAR
private _guards = _gate getVariable ["GRAD_BorderCrossing_assignedGuards", []];
_guards pushBackUnique _gateGuard;
_guards pushBackUnique _guard;
_gate setVariable ["GRAD_BorderCrossing_assignedGuards", _guards, true];

//create speed sign
private _speedSignPos = _gatePos getPos [100, (getDir _gate) + 180];
_speedSignPos set [2,-1];
private _speedSign = _speedSign createVehicle _speedSignPos;
_speedSign setDir ((getDir _gate) + 0);


// area to check for vehicles wanting to get in
private _areaArray = [_areaPos, _areaWidth, _areaDistance, 0, true, 10];

//trigger to handle vehicle checks
private _trigger = ([(_gatePos getPos [5, (getDir _gate) + 180]), "AREA:", [5, 5, 0, false], "ACT:", ["ANY", "PRESENT", true],"STATE":  [QUOTE((side (thisList select 0)) in ["Resitance","CIV"]), QUOTE([thisTrigger, thisList] call grad_borderCrossing_fnc_checkVehicle;), QUOTE([thisTrigger] call grad_borderCrossing_fnc_triggerClear;)]] call CBA_fnc_createTrigger) select 0;
_trigger setVariable ["GRAD_BorderCrossing_gateGuard", _gateGuard];

//debug
if (Debug) then {
	["mrk_GRAD_BorderCrossing_area", _areaPos, "Rectangle", [_areaWidth,_areaDistance], "COLOR:", "ColorYellow"] call CBA_fnc_createMarker;
	["mrk_GRAD_BorderCrossing_area", (_gatePos getPos [5, (getDir _gate) + 180]), "Rectangle", [5,5], "COLOR:", "ColorRed"] call CBA_fnc_createMarker;
};

[_guard, _gate, _gateGuard, _areaArray] call grad_borderCrossing_fnc_handleQueue;
