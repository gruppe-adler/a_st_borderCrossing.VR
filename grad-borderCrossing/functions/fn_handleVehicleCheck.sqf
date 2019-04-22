params ["_driver", "_gate", "_gateGuard"];

private _vehicle = vehicle _driver;

[
    {!(isEngineOn (_this select 0))},
    {
        _this call GRAD_BorderCrossing_fnc_walkingAnimation;
    },
    [_vehicle, _gate, _gateGuard]
] call CBA_fnc_waitUntilAndExecute;
