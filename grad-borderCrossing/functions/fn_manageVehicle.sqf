params ["_vehicle", "_nextSegmentID", "_marker"];

private _nextSegmentBlocked =  missionNamespace getVariable [_nextSegmentID, false];
private _nextPosition = getMarkerPos _marker;

systemChat ("next segment is Blocked:  " + str _nextSegmentBlocked);

if (_nextSegmentBlocked) exitWith {
    [{
        !(missionNamespace getVariable [_this select 1, false])
    }, {
        params ["_vehicle", "", "_nextPosition"];
        systemChat "next segment got free, moving on...";
        _vehicle setDriveOnPath [position _vehicle, _nextPosition];
    },
    [_vehicle, _nextSegmentID, _nextPosition]
    ] call CBA_fnc_waitUntilAndExecute;
};

_vehicle setDriveOnPath [position _vehicle, _nextPosition];
systemChat ("next segment instantly free, going strong: " + str _index);




///////
{
   private _marker = _x;
   private _nextMarker = _markers select (_forEachIndex -1 max 0);
   if (_marker != _nextMarker) then {
      private _id = _marker;
      private _isActive = missionNamespace getVariable [_id + "_active", false];
      private _trespassers = allUnits inAreaArray _marker;
      private _noVehicleInArea = isNull (missionNamespace getVariable [_id + "_vehicleInMarker", objNull]);

      if (!_isActive && {_noVehicleInArea}) then {
         private _vehicles = ((getMarkerPos _x) nearEntities [["Car", "Motorcycle", "Truck"], 50]) inAreaArray _marker;
         systemChat str (_vehicles);
         if (count _vehicles > 0) then {
            if (count _vehicles > 1) then {
               private _vehicle = _vehicles select 0;
               private _posMarker = getMarkerPos _marker;
               private _distance = _vehicle distance2D _posMarker;

               {
                  private _distanceNew = _vehicle distance2D _posMarker;
                  if (_distance < _distanceNew) then {
                     _distance = _distanceNew;
                     _vehicle = _x;
                  };
               }forEach _vehicles;

               _vehicles = [_vehicle];
            };

            missionNamespace setVariable [_id + "active", true];
            missionNamespace setVariable [_id + "vehicleInMarker", _vehicles select 0];

            [(_vehicles select 0), (format ["GRAD_BorderCrossing_vehicleline_%1", _nextMarker]), _nextMarker] call GRAD_BorderCrossing_fnc_manageVehicle;

            [
            {
                (count ((_this select 1) inAreaArray (_this select 0)) == 0)
                },
                {
                    missionNamespace getVariable [_this select 3 + "vehicleInMarker", objNull];
                    systemChat format ["Marker: %1, free.", _this select 0];
                },
                [_marker, _vehicles, _id]
            ] call CBA_fnc_waitUntilAndExecute;

            [
            {(count ((_this select 1) inAreaArray (_this select 0)) == 0)},
            {


            },
            [_marker, _vehicles]] call CBA_fnc_waitUntilAndExecute;
         };
      };

      missionNamespace setVariable [_id + "active", false];
      missionNamespace setVariable [_id + "vehicleInMarker", objNull];
