#include "script_component.hpp"
/*
 * Arguments:
 * 0: areaArray <ARRAY>
 * 1: vehicle <OBJECT>
 * 2: guard <OBJECT>
 * 3: gate <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_areaArray, _vehicle, _guard, _gate] call grad_borderCrossing_fnc_openBarGate;
 *
 * Public: No
 */

params ["_unit", "_destinationPos"];

_unit disableAI "MOVE";
_unit disableAI "TARGET";
_unit disableAI "WEAPONAIM";
_unit disableAI "CHECKVISIBLE";
_unit setDir (_unit getRelDir _destinationPos);

[{
   params ["_args", "_handle"];
   _args params ["_unit", "_destinationPos"];

   //leave loop when done
   if (getPos _unit == _destinationPos || _unit getVariable ["GRAD_borderCrossing_alarmRaised", false]) exitWith {
      _unit enableAI "MOVE";
      _unit enableAI "TARGET";
      _unit enableAI "WEAPONAIM";
      _unit enableAI "CHECKVISIBLE";
      [_handle] call CBA_fnc_removePerFrameHandler;
   };

   //do animation

   //move unit


},1,[_unit, _destinationPos]] call CBA_fnc_addPerFrameHandler;
