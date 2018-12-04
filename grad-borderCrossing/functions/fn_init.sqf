#include "script_component.hpp"
/*
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call grad_borderCrossing_fnc_init;
 *
 * Public: No
 */

if (!isServer) exitWith {};

["grad_borderCrossing_alert", {
   params ["_station1"];
   _thisArgs params ["_station"];

   private _check = false;
   {
      if (_station == _x) exitWith {_check = true;};
   }forEach (missionNamespace getVariable ["grad_borderCrossing_gates", []]);

   if !(_check) exitWith {};



}, [1]] call CBA_fnc_addEventHandlerArgs;

/*
["GRAD_passport_showingPassport", {
    params ["_target", "_passportOwner", "_state"];

    private _nationality = _passportOwner getVariable ["grad_passport_nationality", "unknown"];
    hint "Prüfe Papiere...";

    _target setVariable ["GRAD_BorderCrossing_status", "checking", true];

    switch (_nationality) do {
        case "BRD" : {
            [{
                params ["_target"];
                _target setVariable ["GRAD_BorderCrossing_status", "accepted", true];
                hint "Einreise erlaubt, fahren Sie weiter!";
                 _target setRandomLip true;
                 _target playactionnow "gestureNod";

                [{
                    params ["_target"];
                    (_target getVariable ["GRAD_BorderCrossing_guard_gate", objNull]) animate ["Door_1_rot", 1];
                     _target setRandomLip false;
                }, [_target], 2] call CBA_fnc_waitAndExecute;

                [{
                    params ["_target"];
                    _target setVariable ["GRAD_BorderCrossing_status", "unknown", true];
                }, [_target], 10] call CBA_fnc_waitAndExecute;
            }, [_target], 10] call CBA_fnc_waitAndExecute;


        };
        case "DDR" : {
            [{
                params ["_target"];
                _target setVariable ["GRAD_BorderCrossing_status", "denied", true];
                hint "Einreise nicht gestattet. Drehen Sie um und fahren Sie zurück.";
                _target setRandomLip true;
                _target playactionnow "gestureNo";

                [{
                    params ["_target"];
                     _target setRandomLip false;
                }, [_target], 2] call CBA_fnc_waitAndExecute;

                [{
                    params ["_target"];
                    _target setVariable ["GRAD_BorderCrossing_status", "unknown", true];
                }, [_target], 10] call CBA_fnc_waitAndExecute;
            }, [_target], 10] call CBA_fnc_waitAndExecute;

        };
        default {   };
    };

}] call CBA_fnc_addEventHandler;


["GRAD_BorderCrossing_gateDown", {

        params ["_gate", "_killer"];

        private _guards = _gate getVariable ["GRAD_BorderCrossing_ssignedGuards", []];

        {
            _x reveal _killer;
            _x doTarget _killer;
            _x setVariable ["GRAD_BorderCrossing_larmRaised", true];
            _x enableAI "ANIM";
        } forEach _guards;

}] call CBA_fnc_addEventHandler;
*/
