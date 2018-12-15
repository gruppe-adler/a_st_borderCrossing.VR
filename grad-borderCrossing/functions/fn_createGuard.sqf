#include "script_component.hpp"
/*
 * Arguments:
 * 0: gate <OBJECT>
 * 1: guardClass <STRING>
 * 2: side <SIDE>
 * 3: dir <NUMBER>
 * 4: distance <NUMBER>
 * 5: watchPos <ARRAY> <OPTIONAL>
 *
 * Return Value:
 * 1: guard <OBJECT>
 *
 * Example:
 * _guard = [_gate, _guardClass, _side, 20, 180, _watchPos] call grad_borderCrossing_fnc_createGuard;
 *
 * Public: No
 */

params ["_guardClass", "_side", "_pos", "_dir", ["_watchPos", nil]];

private _guard = (createGroup _side) createUnit [_guardClass, _pos, [], 0, "CAN_COLLIDE"];

_guard setDir _dir;
_guard setPos _pos;
doStop _guard;

if !(isNil "_watchPos") then {
   _guard doWatch _watchPos;
   _guard commandWatch _watchPos;
   _guard lookAt _watchPos;
};

_guard
