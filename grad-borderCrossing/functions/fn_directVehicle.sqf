params ["_areaArray", "_vehicle", "_guard", "_gate"];
{_x enableGunLights "forceOff"} foreach (units group _guard);
_guard setDir (_guard getDir _vehicle);
_guard playMoveNow "Acts_ShieldFromSun_in";
_guard playMove "Acts_ShieldFromSun_loop";

_guard addEventHandler ["AnimDone", {
    params ["_unit", "_anim"];
	_unit playMove "Acts_ShieldFromSun_loop";
}];

[{
    params ["_areaArray", "_guard", "_vehicle", "_gate"];
	_guard distance _vehicle < 40
},
{   
    params ["_areaArray", "_guard", "_vehicle", "_gate"];
	_guard removeAllEventHandlers "AnimDone";
	_guard playMoveNow "Acts_ShieldFromSun_out";
    _guard doWatch _vehicle;
    
	[_areaArray, _guard, _vehicle, _gate] call GRAD_borderCrossing_fnc_checkVehicle;
		
}, [_areaArray, _guard, _vehicle, _gate]] call CBA_fnc_waitUntilAndExecute;

/*
["Acts_ShieldFromSun_in",1.166]
["Acts_ShieldFromSun_loop",5]
["Acts_ShieldFromSun_out",1.82]

["Acts_ShowingTheRightWay_in",1.799]
["Acts_ShowingTheRightWay_loop",1.832]
["Acts_ShowingTheRightWay_out",1.9]

["Acts_WalkingChecking", 26.178]
*/