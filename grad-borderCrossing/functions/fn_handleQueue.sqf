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
   _args params ["_guard", "_gate", "_gateGuard"];

   //condition to end loop
  if !([_gate, _gateGuard, _guard] call CBA_fnc_isAlive) then {
     [_handle] call CBA_fnc_removePerFrameHandler;
  };

   private _queue = _gate getVariable ["GRAD_BorderCrossing_queue", []];
   if (_queue isEqualTo []) exitWith {};
   private _nextVehicle = _queue select 0;

   diag_log format ["Watching: %1", _nextVehicle];
   _guard lookAt _nextVehicle;
   _guard doWatch _nextVehicle;
   diag_log format ["Watching: %1, Speed: %2, Busy: %3", _nextVehicle, (speed _nextVehicle), (_gateGuard getVariable ["GRAD_BorderCrossing_guard_busy", false])];
   if (_gateGuard getVariable ["GRAD_BorderCrossing_guard_busy", false]) then {
      if (speed _nextVehicle > 0) then {

      };
   }else{
      diag_log format ["Wavethrough: %1", (_guard getVariable ["GRAD_BorderCrossing_waveThrough", false])];
      if (speed _nextVehicle > 0 && {!(_guard getVariable ["GRAD_BorderCrossing_waveThrough", false])}) then {

      }else{
         _guard setVariable ["GRAD_BorderCrossing_waveThrough", true];
         [{_this setVariable ["GRAD_BorderCrossing_waveThrough", false];}, _guard, 15] call CBA_fnc_waitAndExecute;
      };
   };
}, 1, _this] call CBA_fnc_addPerFrameHandler;
