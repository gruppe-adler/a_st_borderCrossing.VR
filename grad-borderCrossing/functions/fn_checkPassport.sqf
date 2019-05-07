/*
 * Arguments:
 * A lot!
 *
 * Return Value:
 * None
 *
 * Example:
 * _passPortData call GRAD_BorderCrossing_fnc_checkPassport;
 *
 * Public: No
 */

params ["_unit", "_side"];

private _passPortData = [_unit] call grad_passport_fnc_getPassportData;
_passPortData params ["_firstName", "_lastName", "_dateOfBirth", "_placeOfBirth", "_address", "_expires", "_serial", "_height", "_eyeColor", "_nationality", "_misc1", "_misc2"];

if (GRAD_BorderCrossing_debug) then {
   diag_log format ["First: %1, Last: %2, DateBirth: %3, PlaceBirth: %4, Adress: %5, Expires: %6, Serial: %7, Height: %8, EyeColor: %9, Nationality: %10, Misc1: %11, Misc2: %12, Side: %13", _firstName,_lastName,_dateOfBirth,_placeOfBirth,_address,_expires,_serial,_height,_eyeColor,_nationality,_misc1,_misc2, _side];
};

private _return = switch (_side) do {
   case "WEST" : {
       true
   };
   case "EAST" : {
       true
   };
   case "GUER" : {
       true
   };
   case "CIV" : {true};
   default {diag_log "BorderControl: Given side for passport control not found!";};
};

_return
