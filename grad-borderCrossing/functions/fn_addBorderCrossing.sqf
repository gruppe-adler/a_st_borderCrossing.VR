
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
 * [this, "B_Story_SF_Captain_F", east] call GRAD_BorderCrossing_fnc_addBorderCrossing;
 *
 * Public: No
 */

params ["_gate", "_gateGuardClass", "_side", ["_guardClass", ""], ["_speedSignClass", "CUP_sign_speed20"]];
GRAD_BorderCrossing_debug = true;
diag_log format ["SETUP: %1, %2, %3, %4, %5", _gate, _gateGuardClass, _side, _guardClass, _speedSign];

missionNamespace setVariable ["GRAD_BorderCrossing_gates", ((missionNamespace getVariable ["GRAD_BorderCrossing_gates", []]) pushBackUnique _gate)];
test_gate = _gate;
[_gate] call GRAD_BorderCrossing_fnc_gateDestroyedEH;

if (_guardClass == "") then {
	_guardClass = _gateGuardClass;
};

private _gatePos = _gate modelToWorld [0,0,0];
private _gateDir180 = (getDir _gate) + 180;
private _watchPos = _gatePos getPos [30, _gateDir180];
private _gateGuard = [_gateGuardClass, _side, (_gatePos getPos [8, (getDir _gate) + 255]), _gateDir180, _watchPos] call GRAD_BorderCrossing_fnc_createGuard;
private _guard = [_guardClass, _side, (_gatePos getPos [20, (getDir _gate) + 160]), _gateDir180, _watchPos] call GRAD_BorderCrossing_fnc_createGuard;

_gateGuard setVariable ["GRAD_BorderCrossing_guard_busy", false];
_gateGuard setVariable ["GRAD_BorderCrossing_gate", _gate];
_gateGuard setVariable ["GRAD_BorderCrossing_standingPos", getPos _gateGuard];
test_guard = _gateGuard;

//add the guards to the GVAR
private _guards = _gate getVariable ["GRAD_BorderCrossing_assignedGuards", []];
_guards pushBackUnique _gateGuard;
_guards pushBackUnique _guard;
_gate setVariable ["GRAD_BorderCrossing_assignedGuards", _guards, true];

//create speed sign
private _speedSignPos = _gatePos getPos [55, (getDir _gate) + 174];
_speedSignPos set [2,-1];
private _speedSign = _speedSignClass createVehicle _speedSignPos;
_speedSign setDir (getDir _gate);
_speedSign setPos _speedSignPos;

//speedbumps
{
	private _pos = _gatePos getPos [_x, _gateDir180];
	private _bumper = "Obstacle_saddle" createVehicle _pos;
	_bumper setDir (getDir _gate + 90);
	_bumper setPos _pos;
}forEach [10, 21.5, 32.5, 43.5];

//Creating waitingzones and checkzone
private _areaPosCheck = _gatePos getPos [5, _gateDir180];
private _areaPosWaitZone1 = _gatePos getPos [16, _gateDir180];
private _areaPosWaitZone2 = _gatePos getPos [27, _gateDir180];
private _areaPosWaitZone3 = _gatePos getPos [38, _gateDir180];
private _areaPosAddToLine = _gatePos getPos [64, _gateDir180];
private _waitZones = [_areaPosWaitZone1, _areaPosWaitZone2, _areaPosWaitZone3];

_gate setVariable ["GRAD_BorderCrossing_zones", ["areaCheck", "areaWaitZone1", "areaWaitZone2", "areaWaitZone3", "areaAddToLine"]];

private _areaDistance = 5;
private _areaWidth = 5;

[_gate, _gateGuard, _guard, _areaPosCheck, _waitZones, _areaPosAddToLine, _areaDistance, _areaWidth] call GRAD_BorderCrossing_fnc_handleQueuePFH;

//debug
if (GRAD_BorderCrossing_debug) then {
	private _markers = [];

	private _markerSize = [_areaWidth, _areaDistance];

	_markers pushBack (["GRAD_BorderCrossing_areaPosCheck", _areaPosCheck, "Rectangle", _markerSize, "COLOR:", "ColorRed"] call CBA_fnc_createMarker);
	_markers pushBack (["GRAD_BorderCrossing_areaPosWaitZone1", _areaPosWaitZone1, "Rectangle", _markerSize, "COLOR:", "ColorYellow"] call CBA_fnc_createMarker);
	_markers pushBack (["GRAD_BorderCrossing_areaPosWaitZone2", _areaPosWaitZone2, "Rectangle", _markerSize, "COLOR:", "ColorGreen"] call CBA_fnc_createMarker);
	_markers pushBack (["GRAD_BorderCrossing_areaPosWaitZone3", _areaPosWaitZone3, "Rectangle", _markerSize, "COLOR:", "ColorBlue"] call CBA_fnc_createMarker);
	_markers pushBack (["GRAD_BorderCrossing_areaPosAddToLine", _areaPosAddToLine, "Rectangle", [_areaWidth, 20], "COLOR:", "ColorBlue"] call CBA_fnc_createMarker);

	private _greenArrows = [];
	private _redArrows = [];

	{
	   private _pos = getMarkerPos _x;
	   _pos params ["_posX", "_posY"];
	   (getMarkerSize _x) params ["_sizeX", "_sizeY"];

	   private _aX = _posX - _sizeX;
	   private _aY = _posY - _sizeY;
	   private _bX = _posX + _sizeX;
	   private _bY = _posY + _sizeY;

	   private _posTopLeft = [_aX, _aY, 0];
	   private _posTopRight = [_aX, _bY, 0];
	   private _posBottomLeft = [_bX, _aY, 0];
	   private _posBottomRight = [_bX, _bY, 0];


	   private _topleftGreen = "Sign_Arrow_Green_F" createVehicleLocal _posTopLeft;
	   private _topRightGreen = "Sign_Arrow_Green_F" createVehicleLocal _posTopRight;
	   private _bottomLeftGreen = "Sign_Arrow_Green_F" createVehicleLocal _posBottomLeft;
	   private _bottomRightGreen = "Sign_Arrow_Green_F" createVehicleLocal _posBottomRight;

	   private _topleftRed = "Sign_Arrow_F" createVehicleLocal _posTopLeft;
	   private _topRightRed = "Sign_Arrow_F" createVehicleLocal _posTopRight;
	   private _bottomLeftRed = "Sign_Arrow_F" createVehicleLocal _posBottomLeft;
	   private _bottomRightRed = "Sign_Arrow_F" createVehicleLocal _posBottomRight;

	   _topleftGreen setPos _posTopLeft;
	   _topRightGreen setPos _posTopRight;
	   _bottomLeftGreen setPos _posBottomLeft;
	   _bottomRightGreen setPos _posBottomRight;

	   _topleftRed setPos _posTopLeft;
	   _topRightRed setPos _posTopRight;
	   _bottomLeftRed setPos _posBottomLeft;
	   _bottomRightRed setPos _posBottomRight;


	   _greenArrows pushBack [_topleftGreen, _topRightGreen, _bottomLeftGreen, _bottomRightGreen];
	   _redArrows pushBack [_topleftRed, _topRightRed, _bottomLeftRed, _bottomRightRed];
		{
			_x hideObjectGlobal true;
		} forEach [_topleftRed, _topRightRed, _bottomLeftRed, _bottomRightRed];
	} forEach _markers;

	[{
		params ["_args", "_handle"];
		_args params ["_markers", "_greenArrows", "_redArrows", "_gate"];
		{
			private _greenArrows = _greenArrows select _forEachIndex;
	        private _redArrows = _redArrows select _forEachIndex;
			private _id = format ["GRAD_BorderCrossing_%1", ((_gate getVariable ["GRAD_BorderCrossing_zones", []]) select _forEachIndex)];
	        private _isActive = _gate getVariable [_id + "_active", false];
	        private _vehicleInArea = !(isNull (_gate getVariable [_id + "_vehicleInMarker", objNull]));
			private _lastState = _gate getVariable [_id + "_lastState", []];

			if !(_lastState isEqualTo [_isActive, _vehicleInArea]) then {
				_gate setVariable [_id + "_lastState", [_isActive, _vehicleInArea]];

				if (_isActive && {_vehicleInArea}) then {
					{
						_x hideObjectGlobal false;
					} forEach _redArrows;

					{
						_x hideObjectGlobal true;
					} forEach _greenArrows;
				}else{
					{
						_x hideObjectGlobal true;
					} forEach _redArrows;

					{
						_x hideObjectGlobal false;
					} forEach _greenArrows;
				};
			};
		} forEach _markers;
	}, 1, [_markers, _greenArrows, _redArrows, _gate]] call CBA_fnc_addPerFramehandler;
};
