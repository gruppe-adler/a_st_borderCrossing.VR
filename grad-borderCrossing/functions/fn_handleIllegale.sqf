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

params ["_target", "_gate", "_guard"];

if !(isPlayer _target || alive _player) exitWith {};

_guard setVariable ["GRAD_BorderCrossing_stopCrossing", true, true];
//todo tell player to get out of vehicle

//handle AI in vehicle
{
   if !(isPlayer _x) then {
      doGetOut _x;
      unassignVehicle _x;
      [_x, true] call ACE_captives_fnc_setSurrendered;
   };
}forEach crew (vehicle _target);

//handle the players in the vehicle
[
   {(vehicle (_this select 0) != (_this select 0))},
   {
      //todo tell player to surrender
   },
   [_target],
   30,
   {
      //if player does not respond, raise Alarm
      ["grad_borderCrossing_alert", [_target, _gate]] call CBA_fnc_globalEvent;
   }
] call CBA_fnc_waitUntilAndExecute;

 [{
    params ["_args", "_handle"];
    _args params [];


}, [], 1] call CBA_fnc_addPerFrameHandler;
