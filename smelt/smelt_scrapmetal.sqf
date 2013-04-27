// Script: smelt_scrapmetal.sqf
// Author: piggd
// Revision: 2.0
// Date: 04222013
//  Smelting is based on the boil code in standard dayz.  Modified by piggd to smelt cans into scrap metal.

private["_hasboiledbottleitem","_hasbottleitem","_cansremoved","_hastinitem","_bottletext","_tin1text","_parttext","_tin2text","_tintext","_metalqty","_tincanqty","_sodaemptyqty","_cansreq","_dis","_sfx"];
player removeAction s_player_smelt;
s_player_smelt = -1;


_hasbottleitem = "ItemWaterbottle" in magazines player;
_hasboiledbottleitem = "ItemWaterbottleBoiled" in magazines player;
_hastinitem = false;
_sodaemptyqty = {_x == "ItemSodaEmpty"} count magazines player;
_tincanqty = {_x == "TrashTinCan"} count magazines player;
_metalqty = _sodaemptyqty +_tincanqty;
// The required can quanity must be between 1 to 11 due to inventory constraints. 1 WB and 11 cans is max.
_cansreq = 6;
_cansremoved = 0;
if ( _hasboiledbottleitem ) then {
		_hasbottleitem = true;
};
 if (_metalqty >= _cansreq) then {
    _hastinitem = true;
 };

_bottletext = getText (configFile >> "CfgMagazines" >> "ItemWaterbottle" >> "displayName");
_tin1text = getText (configFile >> "CfgMagazines" >> "TrashTinCan" >> "displayName");
_tin2text = getText (configFile >> "CfgMagazines" >> "ItemSodaEmpty" >> "displayName");
_tintext = format["%1 of %2 %3 / %4 required",_metalqty,_cansreq,_tin1text,_tin2text];
_parttext = getText (configFile >> "CfgMagazines" >> "PartGeneric" >> "displayName");
if (!_hasbottleitem) exitWith {cutText [format[(localize "str_player_31"),_bottletext,"smelt"] , "PLAIN DOWN"]};
if (!_hastinitem) exitWith {cutText [format[(localize "str_player_31"),_tintext,"smelt"] , "PLAIN DOWN"]};

if (_hasbottleitem and _hastinitem) then {
        player playActionNow "Medic";
        sleep 1;
        _dis=10;
        _sfx = "cook";
        [player,_sfx,0,false,_dis] call dayz_zombieSpeak;
        [player,_dis,true,(getPosATL player)] spawn player_alertZombies;

        sleep 5;
		if ( _hasboiledbottleitem ) then {
			player removeMagazine "ItemWaterbottleBoiled";
		 } else {
			player removeMagazine "ItemWaterbottle";
		};
		for "_x" from 1 to _cansreq do {
      
			if (_x <= _tincanqty and _cansremoved < _cansreq) then {
				player removeMagazine "TrashTinCan";
				_cansremoved = _cansremoved + 1;
			};
		};	
		for "_x" from 1 to _cansreq do {
		
			if (_x <= _sodaemptyqty and _cansremoved < _cansreq) then {
				player removeMagazine "ItemSodaEmpty";
				_cansremoved = _cansremoved + 1;
			};	
		};	
		player addMagazine "ItemWaterbottleUnfilled";
        player addMagazine "PartGeneric";
        cutText [format[(localize  "str_build_01"),_parttext], "PLAIN DOWN"];
} else {
        cutText [format[(localize  "str_build_failed_01"),_parttext], "PLAIN DOWN"];
    };
};