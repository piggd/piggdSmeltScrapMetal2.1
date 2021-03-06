// Script: smelt_sandbag.sqf
// Author: piggd
// Revision: 2.1
// Date: 09102103
//  Smelting is based on the boil code in standard dayz.  Modified by piggd to smelt one item into another. The reason I included heat pack is so that there is a guaranteed invtory slot
// to put the sandbag into.
//
// Changed the structure to add additional ingredents used heat pack and sand bag code as base.
private["_hasboiledbottleitem","_hasbottleitem","_itemsremoved","_itemsremoved2","_hasitems","_hasitems2","_bottletext","_item1text","_item2text","_item3text","_item4text","_item5text","_item6text","_parttext","_itemtext","_item1text2","_itemqty","_item1qty2","_item1qty","_item2qty","_item3qty","_item4qty","_item5qty","_item6qty","_item7qty","_itemsreq","_items2req","_dis","_sfx"];
player removeAction s_player_smelt_sandbag;
s_player_smelt_sandbag = -1;


_hasbottleitem = "ItemWaterbottle" in magazines player;
_hasboiledbottleitem = "ItemWaterbottleBoiled" in magazines player;
_hasitems = false;
//_hasitems2 = false;
_item1qty2 = {_x == "ItemHeatPack"} count magazines player;
_item1qty = {_x == "ItemTrashToiletpaper"} count magazines player;
_item2qty = {_x == "ItemTape"} count magazines player;
_item3qty = {_x == "ItemTrashCards"} count magazines player;
_item4qty = {_x == "ItemMoney"} count magazines player;
_item5qty = {_x == "ItemBrick"} count magazines player;
_item6qty = {_x == "ItemHeatPack"} count magazines player;
_item7qty = {_x == "ItemBandage"} count magazines player;
_itemqty = _item1qty + _item2qty + _item3qty + _item4qty + _item5qty + _item6qty + _item7qty;
// The required can quanity must be between 1 to 11 due to inventory constraints. 1 WB and 11 cans is max.
_itemsreq = 6;
//_items2req = 1;
_itemsremoved = 0;
_itemsremoved2 = 0;

if ( _hasboiledbottleitem ) then {
		_hasbottleitem = true;
};
 if (_itemqty >= _itemsreq) then {
    _hasitems = true;
 };
// if (_item1qty2 >= _items2req) then {
//    _hasitems2 = true;
// };

_bottletext = getText (configFile >> "CfgMagazines" >> "ItemWaterbottle" >> "displayName");
//_item1text2 = getText (configFile >> "CfgMagazines" >> "ItemHeatPack" >> "displayName");
_item1text = getText (configFile >> "CfgMagazines" >> "ItemTrashToiletpaper" >> "displayName");
_item2text = getText (configFile >> "CfgMagazines" >> "ItemTape" >> "displayName");
_item3text = getText (configFile >> "CfgMagazines" >> "ItemTrashCards" >> "displayName");
_item4text = getText (configFile >> "CfgMagazines" >> "ItemMoney" >> "displayName");
_item5text = getText (configFile >> "CfgMagazines" >> "ItemBrick" >> "displayName");
_item6text = getText (configFile >> "CfgMagazines" >> "ItemBandage" >> "displayName");
_item7text = getText (configFile >> "CfgMagazines" >> "ItemHeatPack" >> "displayName");
// _itemtext = format["%9 of %10 %11 and %1 of %2 %3 / %4 / %5 / %6 / %7 / %8 required",_itemqty,_itemsreq,_item1text,_item2text,_item3text,_item4text,_item5text,_item6text,_item1qty2,_items2req,_item1text2];
_itemtext = format["%1 of %2 %3 / %4 / %5 / %6 / %7 / %8 / %9 required",_itemqty,_itemsreq,_item1text,_item2text,_item3text,_item4text,_item5text,_item6text,_item7text];
_parttext = getText (configFile >> "CfgMagazines" >> "ItemSandbag" >> "displayName");

if (!_hasbottleitem) exitWith {cutText [format[(localize "str_player_31"),_bottletext,"smelt"] , "PLAIN DOWN"]};
if (!_hasitems) exitWith {cutText [format[(localize "str_player_31"),_itemtext,"smelt"] , "PLAIN DOWN"]};
if (!_hasitems2) exitWith {cutText [format[(localize "str_player_31"),_itemtext,"smelt"] , "PLAIN DOWN"]};

if (_hasbottleitem and _hasitems) then {
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
		for "_x" from 1 to _itemsreq do {
		
			if (_x <= _item1qty and _itemsremoved < _itemsreq) then {
				player removeMagazine "ItemTrashToiletpaper";
				_itemsremoved = _itemsremoved + 1;
			};	
		};	
		for "_x" from 1 to _itemsreq do {
      
			if (_x <= _item2qty and _itemsremoved < _itemsreq) then {
				player removeMagazine "ItemTape";
				_itemsremoved = _itemsremoved + 1;
			};
		};	
		for "_x" from 1 to _itemsreq do {
      
			if (_x <= _item3qty and _itemsremoved < _itemsreq) then {
				player removeMagazine "ItemTrashCards";
				_itemsremoved = _itemsremoved + 1;
			};
		};	
		for "_x" from 1 to _itemsreq do {
      
			if (_x <= _item4qty and _itemsremoved < _itemsreq) then {
				player removeMagazine "ItemMoney";
				_itemsremoved = _itemsremoved + 1;
			};
		};	
		for "_x" from 1 to _itemsreq do {
      
			if (_x <= _item5qty and _itemsremoved < _itemsreq) then {
				player removeMagazine "ItemBrick";
				_itemsremoved = _itemsremoved + 1;
			};
		};	
		for "_x" from 1 to _itemsreq do {
      
			if (_x <= _item6qty and _itemsremoved < _itemsreq) then {
				player removeMagazine "ItemHeatPack";
				_itemsremoved = _itemsremoved + 1;
			};
		};	
		for "_x" from 1 to _itemsreq do {
		
			if (_x <= _item7qty and _itemsremoved < _itemsreq) then {
				player removeMagazine "ItemBandage";
				_itemsremoved = _itemsremoved + 1;
			};	
		};	
//		for "_x" from 1 to _items2req do {
//		
//			if (_x <= _item1qty2 and _itemsremoved2 < _items2req) then {
//				player removeMagazine "ItemHeatPack";
//				_itemsremoved2 = _itemsremoved2 + 1;
//			};	
//		};	
		player addMagazine "ItemWaterbottleUnfilled";
        player addMagazine "ItemSandbag";
        cutText [format[(localize  "str_build_01"),_parttext], "PLAIN DOWN"];
} else {
        cutText [format[(localize  "str_build_failed_01"),_parttext], "PLAIN DOWN"];
};