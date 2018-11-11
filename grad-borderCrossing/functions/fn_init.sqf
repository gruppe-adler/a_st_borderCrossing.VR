if (!isServer) exitWith {};

["GRAD_passport_showingPassport", {
    params ["_target", "_passportOwner", "_state"];

    private _nationality = _passportOwner getVariable ["grad_passport_nationality", "unknown"];
    hint "Prüfe Papiere...";

    _target setVariable ["grad_borderCrossing_status", "checking", true];

    switch (_nationality) do { 
        case "BRD" : {
            [{
                params ["_target"];
                _target setVariable ["grad_borderCrossing_status", "accepted", true];
                hint "Einreise erlaubt, fahren Sie weiter!";
                 _target setRandomLip true;
                 _target playactionnow "gestureNod";

                [{
                    params ["_target"];
                    (_target getVariable ["grad_borderCrossing_guard_gate", objNull]) animate ["Door_1_rot", 1];
                     _target setRandomLip false;
                }, [_target], 2] call CBA_fnc_waitAndExecute;

                [{
                    params ["_target"];
                    _target setVariable ["grad_borderCrossing_status", "unknown", true];
                }, [_target], 10] call CBA_fnc_waitAndExecute;
            }, [_target], 10] call CBA_fnc_waitAndExecute;

            
        }; 
        case "DDR" : {
            [{
                params ["_target"];
                _target setVariable ["grad_borderCrossing_status", "denied", true];
                hint "Einreise nicht gestattet. Drehen Sie um und fahren Sie zurück.";
                _target setRandomLip true;
                _target playactionnow "gestureNo";

                [{
                    params ["_target"];
                     _target setRandomLip false;
                }, [_target], 2] call CBA_fnc_waitAndExecute;

                [{  
                    params ["_target"];
                    _target setVariable ["grad_borderCrossing_status", "unknown", true];
                }, [_target], 10] call CBA_fnc_waitAndExecute;
            }, [_target], 10] call CBA_fnc_waitAndExecute;
            
        }; 
        default {   }; 
    };

}] call CBA_fnc_addEventHandler;