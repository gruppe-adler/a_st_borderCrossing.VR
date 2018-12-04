#include "script_component.hpp"
/*
 * Arguments:
 * 0: trigger <OBJECT>
 * 1: triggerList <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_thisTrigger, _thisList] call grad_borderCrossing_fnc_addBorderCrossing;
 *
 * Public: No
 */

params ["_trigger", "_triggerList"];

systemChat format ["Trigger: %1, List: %2", _trigger, _triggerList];

private _check = false;
private _vehicle = vehicle (_triggerList select 0);

if (isNil "_vehicle") exitWith {ERROR_WITH_TITLE("No unit or vehicle", "Passed list has no unit or vehicle.");};

{
    if !(vehicle _x != _x) then {
      _check = true;
      [] call grad_borderCrossing_fnc_handleUnitNotInVehicle;
   };
   if ((vehicle _x) != _vehicle) then {
      _check = true;
      [] call grad_borderCrossing_fnc_handleMultipleVehicles;
   };
} forEach _triggerList;

if (_check) exitWith {};

private _guard = _trigger getVariable ["GRAD_BorderCrossing_gateGuard",nil];
if (isNil "_gate") exitWith {ERROR_WITH_TITLE("Gate guard nil", "Passed gate guard from trigger is nil");};

private _gate = _guard getVariable ["GRAD_BorderCrossing_gate", nil];
if (isNil "_gate") exitWith {ERROR_WITH_TITLE("Gate nil", "Passed gate from gate guard is nil");};



private _movePosDoor = (getPos _vehicle) getPos [2.5, 270];
_guard doMove _movePosDoor;

[
   {((getPos (_this select 0)) isEqualTo (_this select 1))},{
      _this params ["_guard", "", "_vehicle", "_gate"];

      private _checkPlayer = [];
      private _crew = [];
      {
         if (isPlayer _x) then {
            _crew pushBackUnique _x;
            _x setVariable ["GRAD_BorderCrossing_playerCheck", nil, true];
            [{[] remoteExecCall ["grad_borderCrossing_fnc_handleDiaglog", _this, false];}, _x] call CBA_fnc_execNextFrame;
         };
      }forEach crew _vehicle;

      if (_crew isEqualTo []) then {
         //Handle AI only
         [{[] call grad_borderCrossing_fnc_openBarGate;},[],(random [10,20,30])] call CBA_fnc_waitAndExecute;
      }else{
         //Handle Player
         [
            {
               _this params ["", "", "", "_crew"];

               private _checkVar = 0;
               private _checkedPlayer = 0;
               {
                  if (isPlayer _x) then {
                     private _check = _x getVariable ["GRAD_BorderCrossing_playerCheck", nil];
                     _checkedPlayer = _checkedPlayer +1;
                     if (!(isNil (_check)) && _check) then {_checkVar = _checkVar +1;};
                  };
               }forEach _crew;
               (_checkVar == _checkedPlayer)
            },
            {
               params ["_guard", "_vehicle", "_gate", "_crew"];

               private _check = true;
               {
                  _check = _x getVariable ["GRAD_BorderCrossing_playerCheck", nil];
                  if (isNil "_check") then {_check = true;};
                  if !(_check) exitWith {};

                  private _passPortData = [_x] call grad-passport_fnc_getPassportData;
                  _passPortData pushBackUnique (side _guard);
                  _passPortData call grad_borderCrossing_fnc_checkPassport;
               }forEach _crew;

               if (_check) then {
                  [] call grad_borderCrossing_fnc_openBarGate;
               };
            },
            [_guard, _vehicle, _gate, _crew],
            10
         ] call CBA_fnc_waitUntilAndExecute;
      };
   },[_guard, _movePosDoor, _vehicle, _gate]] call CBA_fnc_waitUntilAndExecute;
