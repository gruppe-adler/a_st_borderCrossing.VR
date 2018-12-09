#include "script_component.hpp"
/*
* Arguments:
* 0: vehicle <OBJECT>
* 1: gate <OBJECT>
* 2: guard <OBJECT>
* 3: gateGuard <OBJECT>
*
* Return Value:
* None
*
* Example:
* [(_nextVehicle select 0), _gate, _guard, _gateGuard] call grad_borderCrossing_fnc_addBorderCrossing;
*
* Public: No
*/

params ["_vehicle", "_gate", "_guard", "_gateGuard"];

_gateGuard setVariable ["GRAD_BorderCrossing_guard_busy", true];

systemChat format ["Checking Vehicle: %1", _vehicle];

[_gateGuard, "Acts_SignalToCheck", 0] call ace_common_fnc_doAnimation;
_gateGuard doMove (getPos _vehicle) getPos [2.5, 270];

[
   {((getPos (_this select 0)) isEqualTo (_this select 1))},{
      _this params ["_gateGuard", "", "_vehicle", "_gate"];

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
               params ["_gateGuard", "_vehicle", "_gate", "_crew"];

               private _check = true;
               {
                  _check = _x getVariable ["GRAD_BorderCrossing_playerCheck", nil];
                  if (isNil "_check") then {_check = true;};
                  if !(_check) exitWith {[_x, _gate, _gateGuard] call grad_borderCrossing_fnc_handleIllegale;};

                  private _passPortData = [_x] call grad-passport_fnc_getPassportData;
                  _passPortData pushBackUnique (side _gateGuard);
                  _check = _passPortData call grad_borderCrossing_fnc_checkPassport;

                  if !(_check) exitWith {[_x, _gate, _gateGuard] call grad_borderCrossing_fnc_handleIllegale;};
               }forEach _crew;

               if (_check) then {
                  [] call grad_borderCrossing_fnc_openBarGate;
               };
            },
            [_gateGuard, _vehicle, _gate, _crew],
            30
         ] call CBA_fnc_waitUntilAndExecute;
      };
   },[_gateGuard, _movePosDoor, _vehicle, _gate]] call CBA_fnc_waitUntilAndExecute;
