#include "script_component.hpp"
/*
 * Arguments:
 * 0: guard <OBJECT>
 * 1: gate <OBJECT>
 * 2: gateGuard <OBJECT>
 * 3: areaArray <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_guard, _gate, _gateGuard] call grad_borderCrossing_fnc_handleQueue;
 *
 * Public: No
 */

[{
   params ["_args","_handle"];
   _args params ["_guard", "_gate", "_gateGuard", "_areaArray"];

   private _queue = _gate getVariable ["GRAD_BorderCrossing_queue", []];

   private _vehiclesWaiting = (
     (_gatePos nearEntities [["Man"], 200]) inAreaArray _areaArray
   ) select {
     side _x != west && {((assignedVehicleRole _x) select 0) isEqualTo "Driver"} && {alive _x}
   };

   if (_queue isEqualTo [] && {_vehiclesWaiting isEqualTo []}) exitWith {};

   _queue = _queue + _vehiclesWaiting;
   private _nextVehicle = _queue select 0;

   _guard lookAt _nextVehicle;
   _guard doWatch _nextVehicle;

   if (_gateGuard getVariable ["GRAD_BorderCrossing_guard_busy", false]) then {
      if (speed _nextVehicle > 0) then {

      };
   }else{
      if (speed _nextVehicle > 0 && !(_guard getVariable ["GRAD_BorderCrossing_waveThrough", false])) then {

      }else{
         _guard setVariable ["GRAD_BorderCrossing_waveThrough", true];
         [{_this setVariable ["GRAD_BorderCrossing_waveThrough", false];}, _guard, 5] call CBA_fnc_waitAndExecute;
      };
   };
}, 1, _this] call CBA_fnc_addPerFrameHandler;


_guard lookAt _vehicle;
_guard doWatch _vehicle;
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
    params ["_guard", "_vehicle", "_gate"];
	_guard removeAllEventHandlers "AnimDone";
	_guard playMoveNow "Acts_ShieldFromSun_out";
    _guard doWatch _vehicle;

	[_guard, _vehicle, _gate] call grad_borderCrossing_fnc_checkVehicle;

}, [_guard, _vehicle, _gate]] call CBA_fnc_waitUntilAndExecute;
