params ["_vehicle", "_gate", "_gateGuard"];

private _checkPlayer = [];
private _crew = [];

{
   if (isPlayer _x) then {
      _crew pushBackUnique _x;
      _x setVariable ["GRAD_BorderCrossing_playerCheck", nil, true];
      [{[] remoteExecCall ["GRAD_BorderCrossing_fnc_handleDiaglog", _this, false];}, _x] call CBA_fnc_execNextFrame;
   };
}forEach crew _vehicle;

if (_crew isEqualTo []) then {
   //Handle AI only
   [{[] call GRAD_BorderCrossing_fnc_openBarGate;},[],(random [10,20,30])] call CBA_fnc_waitAndExecute;
}else{
   //Handle Player
   [
      {
         _this params ["", "", "", "_crew"];

         private _checkVar = 0;
         private _checkedPlayer = 0;
         {
            if (isPlayer _x) then {
               private _check = _x getVariable ["GRAD_BorderCrossing_playerCheck", false];
               _checkedPlayer = _checkedPlayer +1;
               if (_check) then {_checkVar = _checkVar +1;};
            };
         }forEach _crew;

         (_checkVar == _checkedPlayer)
      },
      {
         params ["_gateGuard", "_vehicle", "_gate", "_crew"];

         private _check = true;
         {
            _check = _x getVariable ["GRAD_BorderCrossing_playerCheck", false];
            if !(_check) exitWith {[_x, _gate, _gateGuard] call GRAD_BorderCrossing_fnc_handleIllegale;};

            private _passPortData = [_x] call grad-passport_fnc_getPassportData;
            _passPortData pushBackUnique (side _gateGuard);
            _check = _passPortData call GRAD_BorderCrossing_fnc_checkPassport;

            if !(_check) exitWith {[_x, _gate, _gateGuard] call GRAD_BorderCrossing_fnc_handleIllegale;};
         }forEach _crew;

         if (_check) then {
            [_vehicle, _gate, _gateGuard] call GRAD_BorderCrossing_fnc_openBarGate;
         };
      },
      [_gateGuard, _vehicle, _gate, _crew],
      30
   ] call CBA_fnc_waitUntilAndExecute;
