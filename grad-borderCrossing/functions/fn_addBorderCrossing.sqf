/*
[this, "B_Story_SF_Captain_F", west] call
grad_borderCrossing_fnc_addBorderCrossing;
*/

params ["_gate", "_guardClass", "_side"];

[_gate] call GRAD_borderCrossing_fnc_gateDestroyedEH;


private _areaDistance = 100;
private _areaWidth = 5;

private _gatePos = position _gate;
private _guardPos = _gatePos getPos [10, (getDir _gate) + 180];
private _areaPos = _gatePos getPos [_areaDistance/2, (getDir _gate) + 180];

private _guard = (createGroup _side) createUnit [_guardClass, _guardPos, [], 0, "CAN_COLLIDE"];

_guard setDir ((getDir _gate) + 180);
doStop _guard;

_guard setVariable ["grad_borderCrossing_guard_busy", false];
_guard disableAI "ANIM";

private _guards = _gate getVariable ["GRAD_borderCrossing_assignedGuards", []];
_guards pushBackUnique _guard;
_gate setVariable ["GRAD_borderCrossing_assignedGuards", _guards, true];

private _speedSignPos = _gatePos getPos [100, (getDir _gate) + 180];
_speedSignPos set [2,-1];
private _speedSign = "CUP_sign_speed20" createVehicle _speedSignPos;
_speedSign setDir ((getDir _gate) + 0);


// area to check for vehicles wanting to get in
private _areaArray = [_areaPos, _areaWidth, _areaDistance, 0, true, -1];

/* debug */
private _markerstr = createMarker ["mrk_area", _areaPos];
_markerstr setMarkerShape "RECTANGLE";
_markerstr setMarkerSize [_areaWidth,_areaDistance];
/* end debug */

[{
	params ["_args", "_handle"];
	 _args params ["_areaArray", "_guard", "_gatePos", "_gate"];

    // if alarm runs, dont do anything
    if (_guard getVariable ["GRAD_borderCrossing_alarmRaised", false]) exitWith {};

	// only accept cars
    private _vehiclesWaiting = (
    	(_gatePos nearEntities [["Man"], 200]) inAreaArray _areaArray
    ) select { 
    	side _x != west && {(driver (vehicle _x)) isEqualTo _x} && {alive _x}
    };

    // systemChat str _vehiclesWaiting;

	 if (count _vehiclesWaiting > 0 && !(_guard getVariable ["grad_borderCrossing_guard_busy", true])) then {
	 	// systemChat "guard active";
	 	_guard setVariable ["grad_borderCrossing_guard_busy", true];


		private _vehicle = [_vehiclesWaiting, _gate] call GRAD_borderCrossing_fnc_getBorderCrossingVehicle;
		if (!isNull _vehicle) then {
			[_areaArray, _vehicle, _guard, _gate] call GRAD_borderCrossing_fnc_directVehicle;
		} else {
			_guard setVariable ["grad_borderCrossing_guard_busy", false];
		};
	};

	// todo add condition to end loop
	if (false) then {
		[_handle] call CBA_fnc_removePerFrameHandler;
	};

},1,[_areaArray, _guard, _gatePos, _gate]] call CBA_fnc_addPerFrameHandler;

