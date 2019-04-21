Todo:
- Decision making
- Path walk
- Manage AI
  - Handle Drive Path
  (https://community.bistudio.com/wiki/BIS_fnc_UnitCapture)
  (https://community.bistudio.com/wiki/BIS_fnc_UnitPlay)
  or
  (https://community.bistudio.com/wiki/setDriveOnPath)
- Handle threats
- changing von switchMove to ace_common_fnc_doanimation

Anims:

Acts_listeningToRadio_in
Acts_listeningToRadio_loop
Acts_listeningToRadio_out
Acts_millerCamp_A
Acts_AidlPercMstpSloWWrflDnon_warmup_1_loop
Acts_AidlPercMstpSloWWrflDnon_warmup_2_loop
Acts_AidlPercMstpSloWWrflDnon_warmup_3_loop
Acts_AidlPercMstpSloWWrflDnon_warmup_4_loop
Acts_AidlPercMstpSloWWrflDnon_warmup_4_loop
Acts_AidlPercMstpSloWWrflDnon_warmup01
Acts_AidlPercMstpSloWWrflDnon_warmup02
Acts_AidlPercMstpSloWWrflDnon_warmup03
Acts_AidlPercMstpSloWWrflDnon_warmup04
Acts_AidlPercMstpSloWWrflDnon_warmup05
Acts_CivilHiding_1
Acts_CivilHiding_2
Acts_CivilIdle_1
Acts_CivilIdle_2
Acts_WalkingChecking
Acts_SignalToCheck
Acts_TerminalOpen
Acts_TreatingWounded_In
Acts_TreatingWounded_loop
Acts_TreatingWounded_Out
Acts_TreatingWounded01
Acts_TreatingWounded02
Acts_TreatingWounded03
Acts_TreatingWounded04
Acts_TreatingWounded05
Acts_TreatingWounded06
Acts_startPistol_loop
Acts_SittingWounded_loop
Acts_SittingWounded_out
Acts_SittingWounded_in
Acts_SittingWounded_breath
Acts_SittingJumpingSaluting_loop1
Acts_SittingJumpingSaluting_loop2
Acts_SittingJumpingSaluting_loop3
Acts_SittingJumpingSaluting_out
Acts_SittingJumpingSaluting_in
Acts_ShowingTheRightWay_in
Acts_ShowingTheRightWay_loop
Acts_ShowingTheRightWay_out
Acts_ShieldFromSun_in
Acts_ShieldFromSun_loop
Acts_ShieldFromSun_out
Acts_PercMstpSlowWrflDnon_handup1
Acts_PercMstpSlowWrflDnon_handup1b
Acts_PercMstpSlowWrflDnon_handup1c
Acts_PercMstpSlowWrflDnon_handup2
Acts_PercMstpSlowWrflDnon_handup2b
Acts_PercMstpSlowWrflDnon_handup2c
Acts_NavigatingChopper_In
Acts_NavigatingChopper_Loop
Acts_NavigatingChopper_Out
acts_millerChooper_in
acts_millerChopper_loop
acts_millerChopper_out
acts_miller_knockout
Acts_LyingWounded_loop
Acts_LyingWounded_loop1
Acts_LyingWounded_loop2
Acts_LyingWounded_loop3
Acts_listeningToRadio_In
Acts_listeningToRadio_Loop
Acts_listeningToRadio_Out
Acts_Kore_TalkingOverRadio_in
Acts_Kore_TalkingOverRadio_loop
Acts_Kore_TalkingOverRadio_out
Acts_Kore_PointingForward
Acts_Kore_IdleNoWeapon_in
Acts_Kore_IdleNoWeapon_loop
Acts_Kore_IdleNoWeapon_out
Acts_AidlPercMstpSloWWpstDnon_warmup_1_loop
Acts_AidlPercMstpSlowWrflDnon_pissing
Acts_AidlPercMstpSnonWnonDnon_warmup_8_loop
Acts_AidlPercMstpSnonWnonDnon_warmup_8_out
Acts_AidlPsitMstpSsurWnonDnon01
Acts_AidlPsitMstpSsurWnonDnon02
Acts_AidlPsitMstpSsurWnonDnon03
Acts_AidlPsitMstpSsurWnonDnon04
Acts_AidlPsitMstpSsurWnonDnon05
Acts_AidlPsitMstpSsurWnonDnon_loop
Acts_AidlPsitMstpSsurWnonDnon_out
Acts_carFixingWheel
Acts_CivilInjuredArms_1
Acts_CivilInjuredChest_1
Acts_CivilInjuredGeneral_1
Acts_CivilInjuredHead_1
Acts_CivilInjuredLegs_1
Acts_CivilListening_1
Acts_CivilListening_2
Acts_CivilShocked_1
Acts_CivilShocked_2
Acts_CivilTalking_1
Acts_CivilTalking_2
Acts_InjuredAngryRifle01
Acts_InjuredCoughRifle02
Acts_InjuredLookingRifle01
Acts_InjuredLookingRifle02
Acts_InjuredLookingRifle03
Acts_InjuredLookingRifle04
Acts_InjuredLookingRifle05
Acts_InjuredLyingRifle01
Acts_InjuredLyingRifle02
Acts_InjuredLyingRifle02_180
Acts_InjuredSpeakingRifle01

cts_AidlPercMstpSlowWrflDnon_pissing
Acts_AidlPercMstpSlowWrflDnon_warmup01-05
Acts_AidlPsitMstpSsurWnonDnon01 - 05 - _loop - _out
Acts_B_M03_briefing - 01 - 06
Acts_carFixingWheel
Acts_ComingInSpeakingWalkingOut_1 - 9

Acts_InjuredAngryRifle01
Acts_InjuredCoughRifle02
Acts_InjuredLookingRifle 01-05

Acts_listeningToRadio_In
Acts_listeningToRadio_Loop
Acts_listeningToRadio_Out

Acts_LyingWounded_loop - 1-3

Acts_PercMwlkSlowWrflDf

Acts_ShieldFromSun_in _loop _out

Acts_ShowingTheRightWay_in _loop _out

Acts_SittingWounded_loop _out _wave

Acts_StandingSpeakingUnarmed

Acts_TreatingWounded 01-06

Acts_WalkingChecking


Old Code
params ["_areaArray", "_guard", "_vehicle", "_gate"];

_guard playMoveNow "Acts_PercMstpSlowWrflDnon_handup2c";

_guard setVariable ["GRAD_BorderCrossing_guard_vehicle", _vehicle];
_guard setVariable ["GRAD_BorderCrossing_guard_gate", _gate];


_guard addEventHandler ["AnimDone", {
	params ["_unit", "_anim"];

	private _status = _unit getVariable ["GRAD_BorderCrossing_status", "unknown"];

	if (_status isEqualTo "combat") exitWith {

	};

	if (_status isEqualTo "denied") exitWith {
		switch (_anim) do {
			case "Acts_listeningToRadio_Loop": {
				_unit playmovenow "Acts_listeningToRadio_Out";
			};
			case "Acts_listeningToRadio_Out": {
				_unit playActionNow "ace_gestures_point";
			};
			default {
			};
		};
	};

	if (_status isEqualTo "accepted") exitWith {
		switch (_anim) do {
			case "Acts_listeningToRadio_Loop": {
				_unit playmovenow "Acts_listeningToRadio_Out";
			};
			case "Acts_ShowingTheRightWay_in" : {
				_unit playMoveNow "Acts_ShowingTheRightWay_loop";
			};
			case "Acts_ShowingTheRightWay_loop" : {
				_unit playMoveNow "Acts_ShowingTheRightWay_out";
			};
			default {
				_unit playMoveNow "Acts_ShowingTheRightWay_in";
			};
		};
		// AmovPercMstpSlowWrflDnon_gear
		// AmovPercMstpSlowWrflDnon_diary
	};

	if (_status isEqualTo "checking") exitWith {
		switch (_anim) do {
			case "Acts_listeningToRadio_In": {
				_unit playMoveNow "Acts_listeningToRadio_Loop";
			};
			case "Acts_listeningToRadio_Loop": {
				_unit playMoveNow "Acts_listeningToRadio_Loop";
			};
			default {
				_unit playMoveNow "Acts_listeningToRadio_In";
			};
		};
	};

	switch (_anim) do {
		case "Acts_PercMstpSlowWrflDnon_handup2c": {
			_unit playMoveNow "Acts_PercMstpSlowWrflDnon_handup2c";
		};


		case "Acts_listeningToRadio_In" : {
			_unit playMoveNow "Acts_listeningToRadio_Loop";
		};
		case "Acts_listeningToRadio_Loop" : {
			_unit playMoveNow "Acts_listeningToRadio_Out";
		};
		case "Acts_listeningToRadio_Out": {
			// return to default
		};


		case "Acts_JetsMarshallingSlow_in" : {
			_unit playMoveNow "Acts_JetsMarshallingSlow_Loop";
		};
		case "Acts_JetsMarshallingSlow_Loop" : {
			_unit playMoveNow "Acts_JetsMarshallingSlow_Out";
		};


		default { };
	};
}];



[{
	params ["_areaArray", "_guard", "_vehicle", "_gate"];
	count ([_vehicle] inAreaArray _areaArray) == 0
},
{
	params ["_areaArray", "_guard", "_vehicle", "_gate"];
	_guard removeAllEventHandlers "AnimDone";
	_guard playMoveNow "Acts_ShowingTheRightWay_out";
	_guard setVariable ["GRAD_BorderCrossing_guard_busy", false];
	_gate animate ["Door_1_rot", 0];
	_guard setRandomLip false;

}, [_areaArray, _guard, _vehicle, _gate]] call CBA_fnc_waitUntilAndExecute;


/*
["Acts_ShieldFromSun_in",1.166]
["Acts_ShieldFromSun_loop",5]
["Acts_ShieldFromSun_out",1.82]

["Acts_ShowingTheRightWay_in",1.799]
["Acts_ShowingTheRightWay_loop",1.832]
["Acts_ShowingTheRightWay_out",1.9]

["Acts_WalkingChecking", 26.178]
*/

/*
[{
	params ["_args", "_handle"];
	 _args params ["_areaArray", "_gateGuard", "_gatePos", "_gate", "_guard"];

    // if alarm runs, dont do anything
    if (_gateGuard getVariable ["GRAD_BorderCrossing_alarmRaised", false]) exitWith {};

	// only accept cars
    private _vehiclesWaiting = (
    	(_gatePos nearEntities [["Man"], 200]) inAreaArray _areaArray
    ) select {
    	side _x != west && {(driver (vehicle _x)) isEqualTo _x} && {alive _x}
    };

    systemChat str _vehiclesWaiting;

	 if (count _vehiclesWaiting > 0 && !(_gateGuard getVariable ["GRAD_BorderCrossing_guard_busy", true])) then {
	 	systemChat "guard active";
	 	_gateGuard setVariable ["GRAD_BorderCrossing_guard_busy", true];


		private _vehicle = [_vehiclesWaiting, _gate] call GRAD_BorderCrossing_fnc_getBorderCrossingVehicle;
		if (!isNull _vehicle) then {
			[_areaArray, _vehicle, _gateGuard, _gate] call GRAD_BorderCrossing_fnc_directVehicle;
		};
	};

	// todo add condition to end loop
	if !([_gate, _gateGuard, _guard] call CBA_fnc_isAlive) then {
		[_handle] call CBA_fnc_removePerFrameHandler;
	};

},1,[_areaArray, _gateGuard, _gatePos, _gate, _guard]] call CBA_fnc_addPerFrameHandler;
*/

"AmovPercMstpSrasWrflDnon_AinvPknlMstpSlayWrflDnon" - Put weapon down, Short Length
"AmovPercMstpSrasWrflDnon_AmovPercMevaSrasWrflDb" - Hands behind back - Static
"AmovPercMstpSrasWrflDnon_AmovPercMstpSnonWnonDnon" - put rifle on back - short Length
"AmovPercMstpSrasWrflDnon_AmovPercMstpSrasWpstDnon_end"- Pull out handgun (Pretty cool) - Short
"AmovPercMstpSrasWrflDnon_AmovPknlMstpSlowWrflDnon" - Move to kneel - Short
"AmovPercMstpSrasWrflDnon_AmovPpneMstpSrasWrflDnon" - Move to Prone - Short
"AmovPercMstpSrasWrflDnon_diary" - Hand out looking (Good for mission briefs) Static
"AmovPercMstpSrasWrflDnon_gear_AmovPercMstpSrasWrflDnon" - Put things in pockets Short
"AmovPercMstpSrasWrflDnon_Salute" Salute - Static
"amovpercmstpsraswlnrdnon" Rocket launcher ready - Static
"AmovPknlMstpSlowWpstDnon_AmovPknlMrunSrasWpstDf" kneel - Handgun out run slowmotion
"AmovPknlMstpSlowWrflDnon_AmovPknlMrunSlowWrflDf" kneel - Rifle out slow motion run
"AmovPknlMstpSrasWrflDnon_AadjPpneMstpSrasWrflDleft" - Fall left whilst aiming with rifle
"AmovPknlMstpSrasWrflDnon_AadjPpneMstpSrasWrflDright" Fall right whilst aiming with rifle
"AmovPknlMstpSrasWrflDnon_AinvPknlMstpSrasWrflDnon_Putdown" Put something down whilst aiming rifle
"AmovPpneMstpSrasWrflDnon_AmovPercMsprSlowWrflDf_2" - SLOW MOTION From prone to running - Med
"AmovPpneMstpSrasWrflDnon_injuredHealed" - keeping head down injured - Rifle
"AmovPpneMstpSrasWpstDnon_healed" - Keeping head down injured - pistol

No Weapon

"AmovPercMstpSnonWnonDnon_AcrgPknlMstpSnonWnonDnon_getInSDV" Get on high surface and peek over - short
"AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon" Hands trans to head - Short
"AmovPercMstpSnonWnonDnon_Ease" - At ease hands behind back - static (Good ONE!)
"AmovPercMstpSnonWnonDnon_Scared" Looking at rifle on floor scared - Med
"AmovPercMstpSsurWnonDnon" - surrender - Static
"AmovPercMstpSrasWlnrDnon_AwopPercMstpSoptWbinDnon" - Dance move? lol short
"amovpercmstpsraswlnrdnon_amovpercmstpsraswrfldnon" - another dance one lol
"AmovPercMstpSoptWbinDnon" - Binoculars out
"AmovPknlMstpSnonWnonDnon_AmovPercMsprSnonWnonDf_2" - Sprint from Kneeling - Short
"AmovPknlMstpSnonWnonDnon_AmovPknlMstpSrasWrflDnon" - Pull out handgun from Kneeling - Short
"AmovPknlMstpSnonWnonDnon_explo" - Look around whilst kneeling short

""

WATER

"AbdvPercMwlkSnonWrflDb" swimming backwards with rifle - med
"AbdvPercMwlkSnonWrflDl" Aiming sidewards whlist swimming - med
"AbdvPercMwlkSnonWnonDb" swimming backwards - no weapon - med
"AbdvPercMstpSnonWnonDnon_goup" Go up from water
"AbswPercMstpSnonWnonDnon_relax" Relaxing in water facing down - staticish

Injured

"AcinPercMstpSnonWnonDnon_agony" Get put down in agony - Med
"AcinPercMstpSnonWnonDnon" carrying on shoulders - static
"AcinPercMrunSnonWnonDf" - running with injured on shoulders - med
"AcinPercMrunSnonWnonDf_AmovPercMstpSnonWnonDnon" - pick up / put down injured
"AcinPercMrunSnonWnonDf_death" Death - shakespear style!
"AcinPercMrunSnonWnonDr" running sideways with injured on shoulder
"AcinPknlMstpSnonWnonDnon" - Drag person along floor
"AcinPknlMstpSnonWnonDnon_AcinPercMrunSnonWnonDnon" - pick up and put on shoulders
"AcinPknlMstpSnonWnonDnon_AmovPknlMstpSnonWnonDnon" put down and aim rifle
"AcinPknlMstpSnonWnonDnon_AmovPpneMstpSnonWnonDnon" put down and lay down and aim rifle
"acts_InjuredAngryRifle01" - INcapacitated on floor next to rifle
"acts_InjuredCoughRifle02" INcapacitated Coughing on floor next to rifle
"Acts_TreatingWounded01" treat Wounded on floor pumping chest
"Acts_TreatingWounded02" epi pinning wounded on floor
"Acts_TreatingWounded03" Putting tournaky (Cant remember how to spell it)
"Acts_TreatingWounded04" - just lol, looks like a happy ending. just ? ? ?
"Acts_TreatingWounded_loop" Assessing injured

Cargo -

"AcrgPknlMstpSnonWnonDnon_AmovPercMstpSnonWnonDnon_getOutHighHemtt" Jump off high place onto ground
"AcrgPknlMstpSnonWnonDnon_AmovPercMstpSrasWrflDnon_getOutLow" - jump foot downwards
"Acts_BoatAttacked05" Hold side of boat
"Acts_BoatAttacked01" Holding boat pointing at top left

BRIEFING

"Acts_A_M01_briefing" Officer Giving briefing long
"Acts_A_M02_briefing" officer giving briefing long
"Acts_A_M03_briefing" officer giving briefing long
"Acts_A_M04_briefing" officer giving briefing long
"Acts_A_M05_briefing" officer giving briefing from table long
"Acts_A_OUT_briefing" put weapon down on table briefing med
"Acts_AidlPercMstpSlowWrflDnon_pissing" scratch balls - med
"Acts_B_briefings" - pointing at map briefing

AMBIENT

"Acts_carFixingWheel" Fixing wheel on car
"Acts_listeningToRadio_Loop" - Listening to radio in ear LOOPed
"Acts_NavigatingChopper_Loop" - Chopper traffic controller - looped
"Acts_PercMstpSlowWrflDnon_handup1" hand up with rifle
"Acts_PercMstpSlowWrflDnon_handup1b" hand up with rifle to vehicle
"Acts_PercMstpSlowWrflDnon_handup2" Hands waving like SOS
"Acts_PercMstpSlowWrflDnon_handup2c" vehicle Hold
"acts_PointingLeftUnarmed" Pointing left no Weapon
"Acts_ShieldFromSun_loop" - Hand above eyes shielding sun
"Acts_ShowingTheRightWay_loop" Hand gesture to move traffic/people to the right
"Acts_SignalToCheck" Signal to check
"acts_StandingSpeakingUnarmed" Speaking with no weapons
"Acts_WalkingChecking" - Checking under vehicle and around it (recommended)
"AinvPercMstpSnonWnonDnon_G01" checking pockets

Infantry

"Acts_CrouchGetLowGesture" GET LOW gesture
"acts_CrouchingFiringLeftRifle01" Lean left around corner
"acts_CrouchingFiringLeftRifle02" Quick Lean left around corner
"acts_CrouchingFiringLeftRifle03" Fire Quick left and retreat head back
"acts_CrouchingReloadingRifle01" Reloading rifle crouching
"AovrPercMrunSrasWrflDf" dayz jump over fence
"AwopPercMstpSgthWrflDnon_End1" Throw a grenade
