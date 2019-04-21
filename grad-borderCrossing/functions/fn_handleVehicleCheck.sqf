params ["_driver"];

private _vehicle = vehicle _driver;

[
    {!(isEngineOn _this)},
    {
        systemChat "Engin Off";
        [_this] call GRAD_BorderCrossing_fnc_walkingAnimation;
    },
    _vehicle
] call CBA_fnc_waitUntilAndExecute;
