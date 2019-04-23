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
 * [_areaArray, _vehicle, _guard, _gate] call GRAD_BorderCrossing_fnc_openBarGate;
 *
 * Public: No
 */

params ["_vehicle", "_gate", "_gateGuard"];

_gateGuard setVariable ["GRAD_BorderCrossing_guard_busy", true];

private _destinationPos = (getPos _vehicle) getPos [1.6, 275];
_gateGuard lookAt _destinationPos;
_gateGuard doWatch _destinationPos;
_gateGuard setDir (_gateGuard getDir _destinationPos);

[{
    params ["_vehicle", "_gate", "_gateGuard", "_destinationPos"];

    _gateGuard disableAI "MOVE";
    _gateGuard disableAI "TARGET";
    _gateGuard disableAI "WEAPONAIM";
    _gateGuard disableAI "CHECKVISIBLE";

    if (GRAD_BorderCrossing_debug) then {
        private _debugObject = createSimpleObject ["Sign_Sphere10cm_F", _destinationPos];
        _debugObject setPos _destinationPos;
    };

    private _distance = ((getPos _gateGuard) distance _destinationPos) / 4.32756;
    private _itterations = floor _distance;
    private _remainingDistance = _distance - _itterations;

    private _time = 0;
    for "_i" from 1 to _itterations do {
        [{
            [_this, "AmovPercMwlkSlowWrflDf_v1", 1] call ace_common_fnc_doAnimation;
        }, _gateGuard, _time] call CBA_fnc_waitAndExecute;

        _time = _time + 5;
    };

    if (_remainingDistance > 0.2) then {
        private _remainingItterationTime = (_remainingDistance / (4.32756/5)) *2;

        [{
            [_this, "AmovPercMwlkSlowWrflDf_v1", 1] call ace_common_fnc_doAnimation;
        }, _gateGuard, _time] call CBA_fnc_waitAndExecute;

        _time = _time + _remainingItterationTime + 1;

        [{
            [_this, "AmovPercMstpSlowWrflDnon", 1] call ace_common_fnc_doAnimation;
        }, _gateGuard, _time] call CBA_fnc_waitAndExecute;
    };

    [{
        params ["_vehicle", "_gate", "_gateGuard"];
           _gateGuard enableAI "MOVE";
           _gateGuard enableAI "TARGET";
           _gateGuard enableAI "WEAPONAIM";
           _gateGuard enableAI "CHECKVISIBLE";

           _this call GRAD_BorderCrossing_fnc_checkCrew;
    },[_vehicle, _gate, _gateGuard], _time] call CBA_fnc_waitAndExecute;

}, [_vehicle, _gate, _gateGuard, _destinationPos], 1.5] call CBA_fnc_waitAndExecute;
