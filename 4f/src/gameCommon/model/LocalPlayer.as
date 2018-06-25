package gameCommon.model{   import ddt.data.EquipType;   import ddt.data.PropInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.player.SelfInfo;   import ddt.events.LivingEvent;   import ddt.manager.ChatManager;   import ddt.manager.GameInSocketOut;   import ddt.manager.ItemManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.display.DisplayObject;   import flash.events.Event;   import flash.events.TimerEvent;   import flash.geom.Point;   import flash.utils.Timer;   import gameCommon.GameControl;   import road7th.data.DictionaryData;   import room.RoomManager;      [Event(name="energyChanged",type="ddt.events.LivingEvent")]   [Event(name="gunangleChanged",type="ddt.events.LivingEvent")]   [Event(name="forceChanged",type="ddt.events.LivingEvent")]   [Event(name="skip",type="ddt.events.LivingEvent")]   [Event(name="sendShootAction",type="ddt.events.LivingEvent")]   [Event(name="showMark",type="ddt.events.LivingEvent")]   public class LocalPlayer extends Player   {            public static const SET_ENABLE:String = "setEnable";                   public var _numObject:Object;            private var _isUsedItem:Boolean = false;            private var _isUsedPetSkillWithNoItem:Boolean = false;            public var shootType:int = 0;            private var _shootCount:int = 0;            public var shootTime:int;            private var _gunAngle:Number = 0;            private var _force:Number = 0;            private var _iscalcForce:Boolean = false;            private var _selfDieTimer:Timer;            public var isLast:Boolean = true;            private var _selfDieTimeDelayPassed:Boolean = false;            private var _flyCoolDown:int = 0;            private var _flyEnabled:Boolean = true;            private var _deputyWeaponEnabled:Boolean = true;            private var _deputyWeaponCount:int;            private var _blockDeputyWeapon:Boolean = false;            private var _deputyWeaponCoolDown:int;            public var twoKillEnabled:Boolean = true;            public var soulPropCount:int = 0;            private var _threeKillEnabled:Boolean = true;            private var _spellKillEnabled:Boolean = true;            private var _propEnabled:Boolean = true;            private var _petSkillEnabled:Boolean = true;            private var _totemEnabled:Boolean = true;            private var _dynamismBarDisable:Boolean = false;            private var _soulPropEnabled:Boolean = true;            private var _customPropEnabled:Boolean = true;            private var _lockRightProp:Boolean = false;            private var _rightPropEnabled:Boolean = true;            private var _lockDeputyWeapon:Boolean = false;            private var _lockFly:Boolean = false;            private var _lockSpellKill:Boolean = false;            private var _lockProp:Boolean;            public var NewHandEnemyBlood:int;            public var NewHandSelfBlood:int;            public var NewHandHurtSelfCounter:int;            public var NewHandHurtEnemyCounter:int;            public var NewHandBeEnemyHurtCounter:int;            public var NewHandBloodCounter:int;            public var NewHandEnemyIsFrozen:Boolean;            public var lastFireBombs:Array;            private var _flyCount:int;            private var _usePassBall:Boolean;            public function LocalPlayer(info:SelfInfo, id:int, team:int, maxBlood:int, templeId:int = 0) { super(null,null,null,null,null); }
            public function get isUsedPetSkillWithNoItem() : Boolean { return false; }
            public function set isUsedPetSkillWithNoItem(value:Boolean) : void { }
            public function get isUsedItem() : Boolean { return false; }
            public function set isUsedItem(value:Boolean) : void { }
            public function get selfInfo() : SelfInfo { return null; }
            public function showMark(mark:int) : void { }
            override public function set pos(value:Point) : void { }
            public function get shootCount() : int { return 0; }
            public function set shootCount(value:int) : void { }
            public function manuallySetGunAngle(value:Number) : Boolean { return false; }
            public function get gunAngle() : Number { return 0; }
            public function set gunAngle(value:Number) : void { }
            public function calcBombAngle() : Number { return 0; }
            public function get force() : Number { return 0; }
            public function set force(value:Number) : void { }
            override public function beginNewTurn() : void { }
            private function checkAngle() : void { }
            public function skip() : void { }
            public function set iscalcForce(value:Boolean) : void { }
            public function get iscalcForce() : Boolean { return false; }
            public function sendShootAction(force:Number) : void { }
            public function canUseProp(currentPlayer:TurnedLiving) : Boolean { return false; }
            override public function pick(box:Object) : void { }
            override protected function setWeaponInfo() : void { }
            override public function reset() : void { }
            override public function die(widthAction:Boolean = true) : void { }
            private function __onDieDelayPassed(event:TimerEvent) : void { }
            private function removeSelfDieTimer() : void { }
            public function get selfDieTimeDelayPassed() : Boolean { return false; }
            override public function dispose() : void { }
            override public function set isAttacking(value:Boolean) : void { }
            public function get flyCoolDown() : int { return 0; }
            public function useFly() : String { return null; }
            private function useFlyImp() : void { }
            public function get flyEnabled() : Boolean { return false; }
            public function set flyEnabled(val:Boolean) : void { }
            public function set deputyWeaponEnabled(val:Boolean) : void { }
            public function get deputyWeaponEnabled() : Boolean { return false; }
            public function get deputyWeaponCount() : int { return 0; }
            public function set deputyWeaponCount(val:int) : void { }
            public function blockDeputyWeapon() : void { }
            public function allowDeputyWeapon() : void { }
            private function useDeputyWeaponImp() : void { }
            public function get deputyWeaponCoolDown() : int { return 0; }
            public function useDeputyWeapon() : String { return null; }
            override public function setDeputyWeaponInfo() : void { }
            public function useProp(prop:PropInfo, type:int) : String { return null; }
            private function updateNums(propInfo:PropInfo) : void { }
            private function sendProp(type:int, propInfo:PropInfo) : void { }
            private function pushUseProp(type:int, propInfo:PropInfo) : Boolean { return false; }
            public function clearPropArr() : void { }
            override public function set dander(value:int) : void { }
            private function usePropAtSoul(prop:PropInfo, type:int) : String { return null; }
            private function usePropAtLive(prop:PropInfo, type:int) : String { return null; }
            override public function useItem(info:ItemTemplateInfo) : void { }
            public function get threeKillEnabled() : Boolean { return false; }
            public function set threeKillEnabled(val:Boolean) : void { }
            private function useThreeKillImp() : void { }
            private function checkArmShellSpring() : Boolean { return false; }
            public function useSpellKill() : String { return null; }
            private function useSpellKillImp() : void { }
            public function get spellKillEnabled() : Boolean { return false; }
            public function set spellKillEnabled(val:Boolean) : void { }
            public function set propEnabled(val:Boolean) : void { }
            public function get propEnabled() : Boolean { return false; }
            public function set petSkillEnabled(val:Boolean) : void { }
            public function get petSkillEnabled() : Boolean { return false; }
            public function get totemEnabled() : Boolean { return false; }
            public function set totemEnabled(value:Boolean) : void { }
            public function set dynamismBarDisable(val:Boolean) : void { }
            public function get dynamismBarDisable() : Boolean { return false; }
            public function set soulPropEnabled(val:Boolean) : void { }
            public function get soulPropEnabled() : Boolean { return false; }
            public function get customPropEnabled() : Boolean { return false; }
            public function set customPropEnabled(val:Boolean) : void { }
            public function set lockRightProp(val:Boolean) : void { }
            public function get lockRightProp() : Boolean { return false; }
            public function get rightPropEnabled() : Boolean { return false; }
            public function set rightPropEnabled(val:Boolean) : void { }
            public function get lockDeputyWeapon() : Boolean { return false; }
            public function set lockDeputyWeapon(val:Boolean) : void { }
            public function get lockFly() : Boolean { return false; }
            public function set lockFly(val:Boolean) : void { }
            public function get lockSpellKill() : Boolean { return false; }
            public function set lockSpellKill(val:Boolean) : void { }
            public function set lockProp(val:Boolean) : void { }
            public function get lockProp() : Boolean { return false; }
            public function get shootEnabled() : Boolean { return false; }
            public function setCenter(px:Number, py:Number, isTween:Boolean) : void { }
            public function get flyCount() : int { return 0; }
            public function set flyCount(value:int) : void { }
            public function get usePassBall() : Boolean { return false; }
            public function set usePassBall(value:Boolean) : void { }
   }}