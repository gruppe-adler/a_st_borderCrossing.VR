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
   diag_log format ["First: %1, Last: %2, DateBirth: %3, PlaceBirth: %4, Adress: %5, Expires: %6, Serial: %7, Height: %8, EyeColor: %9, Nationality: %10, Misc1: %11, Misc2: %12, Side: %13", _firstName,_lastName,_dateOfBirth,_placeOfBirth,_address,_expires,_serial,_height,_eyeColor,_nationality,_misc1,_misc2, _side];
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
