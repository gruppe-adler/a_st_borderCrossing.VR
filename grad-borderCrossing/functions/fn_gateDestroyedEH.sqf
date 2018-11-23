params ["_gate"];

_gate addEventHandler ["HandleDamage", {
	params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];

	if (_damage > 0.9) then {
        private _actualKiller = effectiveCommander vehicle _source;
        if (side _actualKiller != east) then {
            _actualKiller setCaptive false;
            ["GRAD_borderCrossing_gateDown", [_gate, _actualKiller]] call CBA_fnc_globalEvent;
        };
    };
}];