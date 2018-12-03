#include "script_component.hpp"
params ["_vehiclesWaiting", "_gate"];

private _nextVehicle = objNull;

TRACE_1("GRAD BorderCrossing Vehicles waiting: ", _vehiclesWaiting);

private _allVehicles = nearestObjects [_gate, ["Man"], 200];
private _closestVehicles = _allVehicles arrayIntersect _vehiclesWaiting;


if (count _closestVehicles > 0) then {
	_nextVehicle = _closestVehicles select 0;
} else {
	_nextVehicle = objNull;
};

_nextVehicle
