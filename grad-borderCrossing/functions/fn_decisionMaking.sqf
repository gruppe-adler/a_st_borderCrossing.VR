#include "script_component.hpp"
/*
 * Arguments:
 * 0: unit <OBJECT>
 * 1: state <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [this, "B_Story_SF_Captain_F", east] call GRAD_BorderCrossing_fnc_addBorderCrossing;
 *
 * Public: No
 */

params ["_unit", "_state"];

/*
	states:

	idle
	waving
	checking
	accepted
	denied
	combat

*/


switch (_state) do {
	case "idle" : {


	};

	case "waving" : {

	};

	case "checking" : {

	};


	case "accepted" : {

	};

	case "denied" : {

	};

	case "combat" : {

	};

	default {ERROR_WITH_TITLE("STATE not found","No value in state variable");};
};
