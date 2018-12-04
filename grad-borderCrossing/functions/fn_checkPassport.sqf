#include "script_component.hpp"
/*
 * Arguments:
 * 0: gate <OBJECT>
 * 1: gateGuardClass <STRING>
 * 2: side <SIDE>
 * 3: guardClass <STRING> <OPTIONAL>
 * 4: speedSign <STRING> <OPTIONAL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [this, "B_Story_SF_Captain_F", east] call grad_borderCrossing_fnc_addBorderCrossing;
 *
 * Public: No
 */

params ["_firstName", "_lastName", "_dateOfBirth", "_placeOfBirth", "_address", "_expires", "_serial", "_height", "_eyeColor", "_nationality", "_misc1", "_misc2", "_side"];

if (Debug) then {
   diag_log format ["Player Passport: ", _firstName, _lastName, _dateOfBirth, _placeOfBirth, _address, _expires, _serial, _height, _eyeColor, _nationality, _misc1, _misc2];
};

Switch (side) do {
   case "WEST" : {

   };
   case "EAST" : {

   };
   case "GUER" : {

   };
   case "CIV" : {

   };
   default {ERROR_WITH_TITLE("Error Side", "Given side for passport control not found!");};
};
