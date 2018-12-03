#include "script_component.hpp"
/*
 * Arguments:
 * 0: gate <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [this] call grad_borderCrossing_fnc_gateDestroyedEH;
 *
 * Public: No
 */

params ["_gate"];

_gate addEventHandler ["HandleDamage", {
	params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];

	if (_damage > 0.9) then {
        private _actualKiller = effectiveCommander vehicle _source;
        if (side _actualKiller != east) then {
            _actualKiller setCaptive false;
            ["GRAD_BorderCrossing_gateDown", [_gate, _actualKiller]] call CBA_fnc_globalEvent;
        };
    };
}];
