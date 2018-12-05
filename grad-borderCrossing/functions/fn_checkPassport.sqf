#include "script_component.hpp"
/*
 * Arguments:
 * A lot!
 *
 * Return Value:
 * None
 *
 * Example:
 * _passPortData call grad_borderCrossing_fnc_checkPassport;
 *
 * Public: No
 */

params ["_firstName", "_lastName", "_dateOfBirth", "_placeOfBirth", "_address", "_expires", "_serial", "_height", "_eyeColor", "_nationality", "_misc1", "_misc2", "_side"];

if (true) then {
   diag_log format ["Player Passport: %1", _this];
};

private _return = switch (str (_side)) do {
   case "WEST" : {

   };
   case "EAST" : {

   };
   case "GUER" : {

   };
   case "CIV" : {true};
   default {ERROR_WITH_TITLE("Error Side", "Given side for passport control not found!");};
};
