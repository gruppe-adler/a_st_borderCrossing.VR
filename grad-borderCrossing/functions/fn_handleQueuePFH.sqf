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
 * [_guard, _gate, _gateGuard] call GRAD_BorderCrossing_fnc_handleQueue;
 *
 * Public: No
 */

[{
    params ["_args","_handle"];
    _args params ["_gate", "_gateGuard", "_guard", "_areaPosCheck", "_waitZones", "_areaPosAddToLine", "_areaDistance", "_areaWidth"];

    //condition to end loop
   if !([_gate, _gateGuard, _guard] call CBA_fnc_isAlive) then {
      [_handle] call CBA_fnc_removePerFrameHandler;
   };

   private _gvar = format ["GRAD_BorderCrossing_%1", _gate];

   //zone where new vehicles are added to the line
   private _vehiclesToAdd = (allUnits inAreaArray [_areaPosAddToLine, _areaWidth, _areaDistance, 0, true, 10]) select {((side _x) in [resistance, civilian]) && {(driver (vehicle _x)) isEqualTo _x} && {alive _x}};

   {
       if (_x getVariable [_gvar + "_inLine", false]) then {
           _x setVariable [_gvar + "_inLine", false];
           if !(isPlayer _x) then {
               doStop _x;
               //_x stop true;
           };

           _gate setVariable ["GRAD_BorderCrossing_queue", (_gate getVariable ["GRAD_BorderCrossing_queue", []] pushBackUnique _x)];
       };
   }forEach _vehiclesToAdd;

   //waiting queue handling
   {
       private _zonePos = _x;
       private _id = format ["GRAD_BorderCrossing_%1", ((_gate getVariable ["GRAD_BorderCrossing_zones", []]) select (_forEachIndex +1))];
       private _vehiclesInZone = (allUnits inAreaArray [_zonePos, _areaWidth, _areaDistance, 0, true, 10]) select {((side _x) in [resistance, civilian]) && {(driver (vehicle _x)) isEqualTo _x} && {alive _x}};

       if (_vehiclesInZone isEqualTo []) then {
           if (_gate getVariable [_id + "_active", false]) then {
               _gate setVariable [_id + "_active", false];
           };
       }else{
           if !(_gate getVariable [_id + "_active", false]) then {
               _gate setVariable [_id + "_active", true];
               _gate setVariable [_id + "_vehicleInMarker", _vehiclesInZone select 0];

           };
       };
   }forEach _waitZones;

    private _vehiclesNeedingChecking = {(allUnits inAreaArray [_areaPosCheck, _areaWidth, _areaDistance, 0, true, 10]) select {((side _x) in [resistance, civilian]) && {(driver (vehicle _x)) isEqualTo _x} && {alive _x}}};

    switch (true) do {
        case ((count _vehiclesNeedingChecking) == 1) : {
            private _vehicle = _vehiclesNeedingChecking select 0;

            if !(_vehicle getVariable ["GRAD_BorderCrossing_checkInProgress", false]) then {
                [_vehicle] call GRAD_BorderCrossing_fnc_checkPassport;
            };
        };
        case (count _vehiclesNeedingChecking > 1) : {
            {
            private _vehicle = _x;
                if !(!(_vehicle getVariable ["GRAD_BorderCrossing_checkInProgress", false]) && {!(_vehicle getVariable ["GRAD_BorderCrossing_checkFine", false])}) then {

                };
            }forEach _vehiclesNeedingChecking;
        };
    };

}, 1, _this] call CBA_fnc_addPerFrameHandler;










/*
[{
   params ["_args","_handle"];
   _args params [ "_gate", ];

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
*/
