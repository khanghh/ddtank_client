package gameCommon.model
{
   import ddt.data.EquipType;
   import ddt.data.PropInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.LivingEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import gameCommon.GameControl;
   import road7th.data.DictionaryData;
   import room.RoomManager;
   
   [Event(name="energyChanged",type="ddt.events.LivingEvent")]
   [Event(name="gunangleChanged",type="ddt.events.LivingEvent")]
   [Event(name="forceChanged",type="ddt.events.LivingEvent")]
   [Event(name="skip",type="ddt.events.LivingEvent")]
   [Event(name="sendShootAction",type="ddt.events.LivingEvent")]
   [Event(name="showMark",type="ddt.events.LivingEvent")]
   public class LocalPlayer extends Player
   {
      
      public static const SET_ENABLE:String = "setEnable";
       
      
      public var _numObject:Object;
      
      private var _isUsedItem:Boolean = false;
      
      private var _isUsedPetSkillWithNoItem:Boolean = false;
      
      public var shootType:int = 0;
      
      private var _shootCount:int = 0;
      
      public var shootTime:int;
      
      private var _gunAngle:Number = 0;
      
      private var _force:Number = 0;
      
      private var _iscalcForce:Boolean = false;
      
      private var _selfDieTimer:Timer;
      
      public var isLast:Boolean = true;
      
      private var _selfDieTimeDelayPassed:Boolean = false;
      
      private var _flyCoolDown:int = 0;
      
      private var _flyEnabled:Boolean = true;
      
      private var _deputyWeaponEnabled:Boolean = true;
      
      private var _deputyWeaponCount:int;
      
      private var _blockDeputyWeapon:Boolean = false;
      
      private var _deputyWeaponCoolDown:int;
      
      public var twoKillEnabled:Boolean = true;
      
      public var soulPropCount:int = 0;
      
      private var _threeKillEnabled:Boolean = true;
      
      private var _spellKillEnabled:Boolean = true;
      
      private var _propEnabled:Boolean = true;
      
      private var _petSkillEnabled:Boolean = true;
      
      private var _totemEnabled:Boolean = true;
      
      private var _dynamismBarDisable:Boolean = false;
      
      private var _soulPropEnabled:Boolean = true;
      
      private var _customPropEnabled:Boolean = true;
      
      private var _lockRightProp:Boolean = false;
      
      private var _rightPropEnabled:Boolean = true;
      
      private var _lockDeputyWeapon:Boolean = false;
      
      private var _lockFly:Boolean = false;
      
      private var _lockSpellKill:Boolean = false;
      
      private var _lockProp:Boolean;
      
      public var NewHandEnemyBlood:int;
      
      public var NewHandSelfBlood:int;
      
      public var NewHandHurtSelfCounter:int;
      
      public var NewHandHurtEnemyCounter:int;
      
      public var NewHandBeEnemyHurtCounter:int;
      
      public var NewHandBloodCounter:int;
      
      public var NewHandEnemyIsFrozen:Boolean;
      
      public var lastFireBombs:Array;
      
      private var _flyCount:int;
      
      private var _usePassBall:Boolean;
      
      public function LocalPlayer(param1:SelfInfo, param2:int, param3:int, param4:int, param5:int = 0)
      {
         super(param1,param2,param3,param4,param5);
         if(param1.DeputyWeaponID > 0)
         {
            deputyWeaponCount = param1.DeputyWeapon.StrengthenLevel + 1;
         }
         _numObject = {};
      }
      
      public function get isUsedPetSkillWithNoItem() : Boolean
      {
         return _isUsedPetSkillWithNoItem;
      }
      
      public function set isUsedPetSkillWithNoItem(param1:Boolean) : void
      {
         _isUsedPetSkillWithNoItem = param1;
      }
      
      public function get isUsedItem() : Boolean
      {
         return _isUsedItem;
      }
      
      public function set isUsedItem(param1:Boolean) : void
      {
         _isUsedItem = param1;
      }
      
      public function get selfInfo() : SelfInfo
      {
         return playerInfo as SelfInfo;
      }
      
      public function showMark(param1:int) : void
      {
         dispatchEvent(new LivingEvent("showMark",0,0,param1 - 1));
      }
      
      override public function set pos(param1:Point) : void
      {
         if(param1.equals(_pos) == false)
         {
            if(isLiving && onChange == true)
            {
               energy = energy - Math.abs(param1.x - _pos.x) * powerRatio;
            }
            .super.pos = param1;
         }
      }
      
      public function get shootCount() : int
      {
         return _shootCount;
      }
      
      public function set shootCount(param1:int) : void
      {
         _shootCount = param1;
      }
      
      public function manuallySetGunAngle(param1:Number) : Boolean
      {
         var _loc3_:int = gunAngle;
         gunAngle = param1;
         var _loc2_:* = _loc3_ != gunAngle;
         return _loc2_;
      }
      
      public function get gunAngle() : Number
      {
         return _gunAngle;
      }
      
      public function set gunAngle(param1:Number) : void
      {
         if(param1 == _gunAngle)
         {
            return;
         }
         if((currentBomb == 3 || currentBomb == 110 || currentBomb == 117 || currentBomb == 11196 || RoomManager.Instance.current && RoomManager.Instance.current.type == 29) && (param1 < 0 || param1 > 90))
         {
            return;
         }
         if(RoomManager.Instance.current)
         {
            if(currentBomb != 3 && currentBomb != 110 && currentBomb != 117 && currentBomb != 11196 && RoomManager.Instance.current.type != 29 && param1 < currentWeapInfo.armMinAngle)
            {
               _gunAngle = currentWeapInfo.armMinAngle;
               return;
            }
            if(currentBomb != 3 && currentBomb != 110 && currentBomb != 117 && currentBomb != 11196 && RoomManager.Instance.current.type != 29 && param1 > currentWeapInfo.armMaxAngle)
            {
               _gunAngle = currentWeapInfo.armMaxAngle;
               return;
            }
         }
         else
         {
            if(currentBomb != 3 && currentBomb != 110 && currentBomb != 117 && currentBomb != 11196 && param1 < currentWeapInfo.armMinAngle)
            {
               _gunAngle = currentWeapInfo.armMinAngle;
               return;
            }
            if(currentBomb != 3 && currentBomb != 110 && currentBomb != 117 && currentBomb != 11196 && param1 > currentWeapInfo.armMaxAngle)
            {
               _gunAngle = currentWeapInfo.armMaxAngle;
               return;
            }
         }
         _gunAngle = param1;
         dispatchEvent(new LivingEvent("gunangleChanged"));
      }
      
      public function calcBombAngle() : Number
      {
         return direction > 0?playerAngle - _gunAngle:Number(playerAngle + _gunAngle - 180);
      }
      
      public function get force() : Number
      {
         return _force;
      }
      
      public function set force(param1:Number) : void
      {
         _force = Math.min(param1,2000);
         dispatchEvent(new LivingEvent("forceChanged"));
      }
      
      override public function beginNewTurn() : void
      {
         super.beginNewTurn();
         checkAngle();
         dispatchEvent(new LivingEvent("gunangleChanged"));
         shootType = 0;
         _isUsedPetSkillWithNoItem = false;
         _isUsedItem = false;
      }
      
      private function checkAngle() : void
      {
         if(RoomManager.Instance.current.type == 29)
         {
            return;
         }
         if(_gunAngle < currentWeapInfo.armMinAngle)
         {
            gunAngle = currentWeapInfo.armMinAngle;
            return;
         }
         if(_gunAngle > currentWeapInfo.armMaxAngle)
         {
            gunAngle = currentWeapInfo.armMaxAngle;
            return;
         }
      }
      
      public function skip() : void
      {
         if(isAttacking)
         {
            stopAttacking();
            dispatchEvent(new LivingEvent("skip"));
         }
      }
      
      public function set iscalcForce(param1:Boolean) : void
      {
         if(_iscalcForce == param1)
         {
            return;
         }
         _iscalcForce = param1;
         dispatchEvent(new LivingEvent("isCalcForceChange"));
      }
      
      public function get iscalcForce() : Boolean
      {
         return _iscalcForce;
      }
      
      public function sendShootAction(param1:Number) : void
      {
         dispatchEvent(new LivingEvent("sendShootAction",0,0,param1));
      }
      
      public function canUseProp(param1:TurnedLiving) : Boolean
      {
         return this == param1 && !LockState || !isLiving && team == param1.team;
      }
      
      override public function pick(param1:Object) : void
      {
         super.pick(param1);
         if(param1.isGhost)
         {
            psychic = psychic + param1.psychic;
         }
         SocketManager.Instance.out.sendGamePick(param1.Id);
      }
      
      override protected function setWeaponInfo() : void
      {
         super.setWeaponInfo();
         gunAngle = currentWeapInfo.armMinAngle;
      }
      
      override public function reset() : void
      {
         super.reset();
         lockSpellKill = false;
         lockFly = false;
         lockDeputyWeapon = false;
         customPropEnabled = true;
         rightPropEnabled = true;
         deputyWeaponEnabled = true;
         flyEnabled = true;
         threeKillEnabled = true;
         soulPropEnabled = true;
         _deputyWeaponCoolDown = 0;
         _flyCoolDown = 0;
         if(currentWeapInfo)
         {
            gunAngle = currentWeapInfo.armMinAngle;
         }
         if(playerInfo.DeputyWeaponID > 0 && playerInfo.DeputyWeapon)
         {
            deputyWeaponCount = playerInfo.DeputyWeapon.StrengthenLevel + 1;
         }
      }
      
      override public function die(param1:Boolean = true) : void
      {
         var _loc2_:DictionaryData = GameControl.Instance.Current.findTeam(this.team);
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            if(!_loc3_.isSelf && _loc3_.isLiving)
            {
               isLast = false;
               break;
            }
         }
         super.die(param1);
         _selfDieTimer = new Timer(500,1);
         _selfDieTimer.start();
         _selfDieTimer.addEventListener("timer",__onDieDelayPassed);
         deputyWeaponEnabled = false;
         flyEnabled = false;
         spellKillEnabled = false;
         rightPropEnabled = false;
         if(isSelf)
         {
            ChatManager.Instance.view.output.ghostState = param1;
         }
      }
      
      private function __onDieDelayPassed(param1:TimerEvent) : void
      {
         removeSelfDieTimer();
         _selfDieTimeDelayPassed = true;
      }
      
      private function removeSelfDieTimer() : void
      {
         if(_selfDieTimer == null)
         {
            return;
         }
         _selfDieTimer.stop();
         _selfDieTimer.removeEventListener("timer",__onDieDelayPassed);
         _selfDieTimer = null;
      }
      
      public function get selfDieTimeDelayPassed() : Boolean
      {
         return _selfDieTimeDelayPassed;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeSelfDieTimer();
      }
      
      override public function set isAttacking(param1:Boolean) : void
      {
         if(param1)
         {
            _flyCoolDown = Number(_flyCoolDown) - 1;
            _deputyWeaponCoolDown = Number(_deputyWeaponCoolDown) - 1;
         }
         if(_flyCoolDown <= 0 && energy >= 150 && !_lockFly)
         {
            flyEnabled = true;
         }
         if(hasDeputyWeapon() && _deputyWeaponCoolDown <= 0 && energy >= currentDeputyWeaponInfo.energy && !_lockDeputyWeapon && _isLiving)
         {
            deputyWeaponEnabled = true;
         }
         totemEnabled = true;
         threeKillEnabled = true;
         spellKillEnabled = true;
         propEnabled = true;
         soulPropEnabled = true;
         .super.isAttacking = param1;
      }
      
      public function get flyCoolDown() : int
      {
         return _flyCoolDown;
      }
      
      public function useFly() : String
      {
         if(flyEnabled && _isAttacking)
         {
            useFlyImp();
         }
         else
         {
            if(!_isAttacking)
            {
               return "NotAttacking";
            }
            if((_lockFly || _lockState) && _lockType != 0)
            {
               if(_lockType == 4)
               {
                  return "LockFly";
               }
               return "LockState";
            }
            if(_isLiving && PlayerManager.Instance.Self.IsWeakGuildFinish(11))
            {
               if(_flyCoolDown > 0)
               {
                  return "2";
               }
               if(_energy < 150)
               {
                  return "EmptyEnergy";
               }
            }
         }
         return "0";
      }
      
      private function useFlyImp() : void
      {
         if(_currentMap && !_currentMap.disableFlyCD || _currentMap3D && !_currentMap3D.disableFlyCD)
         {
            _flyCoolDown = 2;
         }
         SocketManager.Instance.out.sendAirPlane();
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         var _loc1_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(10016);
         _loc2_.TemplateID = _loc1_.TemplateID;
         _loc2_.Pic = "2";
         _loc2_.Property4 = _loc1_.Property4;
         var _loc3_:PropInfo = new PropInfo(_loc2_);
         useItem(_loc3_.Template);
         currentBomb = 3;
         flyEnabled = false;
         rightPropEnabled = false;
         if(hasDeputyWeapon() && EquipType.isAngel(currentDeputyWeaponInfo.Template))
         {
            deputyWeaponEnabled = false;
         }
         spellKillEnabled = false;
      }
      
      public function get flyEnabled() : Boolean
      {
         return _isLiving && !_lockFly && _flyEnabled && _flyCoolDown <= 0 && _energy >= 150;
      }
      
      public function set flyEnabled(param1:Boolean) : void
      {
         if(_flyEnabled != param1)
         {
            _flyEnabled = param1;
            dispatchEvent(new LivingEvent("flyChanged"));
         }
      }
      
      public function set deputyWeaponEnabled(param1:Boolean) : void
      {
         if(_deputyWeaponEnabled != param1)
         {
            _deputyWeaponEnabled = param1;
            dispatchEvent(new LivingEvent("deputyweapin_Changed"));
         }
      }
      
      public function get deputyWeaponEnabled() : Boolean
      {
         if(hasDeputyWeapon())
         {
            return _isLiving && !_lockDeputyWeapon && !_blockDeputyWeapon && _deputyWeaponEnabled && _deputyWeaponCount > 0 && _deputyWeaponCoolDown <= 0 && _energy >= currentDeputyWeaponInfo.energy;
         }
         return false;
      }
      
      public function get deputyWeaponCount() : int
      {
         return _deputyWeaponCount;
      }
      
      public function set deputyWeaponCount(param1:int) : void
      {
         if(_deputyWeaponCount != param1)
         {
            _deputyWeaponCount = param1;
            dispatchEvent(new LivingEvent("deputyweapin_Changed"));
         }
      }
      
      public function blockDeputyWeapon() : void
      {
         _blockDeputyWeapon = true;
         _deputyWeaponCoolDown = 100000;
         deputyWeaponEnabled = false;
      }
      
      public function allowDeputyWeapon() : void
      {
         _blockDeputyWeapon = false;
         deputyWeaponEnabled = true;
      }
      
      private function useDeputyWeaponImp() : void
      {
         var _loc1_:* = null;
         _deputyWeaponCoolDown = currentDeputyWeaponInfo.coolDown;
         SocketManager.Instance.out.useDeputyWeapon();
         if(!GameControl.Instance.is3DGame)
         {
            _loc1_ = currentDeputyWeaponInfo.getDeputyWeaponIcon();
            _loc1_.x = _loc1_.x + 7;
            useItemByIcon(_loc1_);
         }
         else
         {
            useItemByIcon3D(currentDeputyWeaponInfo.getDeputyWeaponIcon3D());
         }
         energy = energy - currentDeputyWeaponInfo.energy;
         if(hasDeputyWeapon() && currentDeputyWeaponInfo.ballId > 0)
         {
            currentBomb = currentDeputyWeaponInfo.ballId;
         }
         deputyWeaponEnabled = false;
         if(EquipType.isAngel(currentDeputyWeaponInfo.Template))
         {
            spellKillEnabled = false;
            flyEnabled = false;
            rightPropEnabled = false;
         }
      }
      
      public function get deputyWeaponCoolDown() : int
      {
         return _deputyWeaponCoolDown;
      }
      
      public function useDeputyWeapon() : String
      {
         if(PlayerManager.Instance.Self.IsWeakGuildFinish(11))
         {
            SoundManager.instance.play("008");
         }
         var _loc1_:Number = currentDeputyWeaponInfo.energy;
         if(deputyWeaponEnabled && _isAttacking)
         {
            useDeputyWeaponImp();
         }
         else if(hasDeputyWeapon())
         {
            if(!_isAttacking)
            {
               return "NotAttacking";
            }
            if((_lockDeputyWeapon || _lockState) && _lockType != 0)
            {
               return "LockState";
            }
            if(_deputyWeaponCount <= 0)
            {
               return "5";
            }
            if(_deputyWeaponCoolDown > 0)
            {
               return "4";
            }
            if(_energy < _loc1_)
            {
               return "EmptyEnergy";
            }
         }
         return "0";
      }
      
      override public function setDeputyWeaponInfo() : void
      {
         super.setDeputyWeaponInfo();
         if(hasDeputyWeapon())
         {
            deputyWeaponCount = playerInfo.DeputyWeapon.StrengthenLevel + 1;
         }
      }
      
      public function useProp(param1:PropInfo, param2:int) : String
      {
         if(_isLiving)
         {
            return usePropAtLive(param1,param2);
         }
         return usePropAtSoul(param1,param2);
      }
      
      private function updateNums(param1:PropInfo) : void
      {
         var _loc2_:int = 0;
         if(_numObject.hasOwnProperty(param1.TemplateID))
         {
            _loc2_ = _numObject[param1.TemplateID] as int;
         }
         _loc2_++;
         _numObject[param1.TemplateID] = _loc2_;
      }
      
      private function sendProp(param1:int, param2:PropInfo) : void
      {
         useItem(param2.Template);
         GameInSocketOut.sendUseProp(param1,param2.Place,param2.Template.TemplateID);
         dispatchEvent(new Event("setEnable"));
         twoKillEnabled = false;
      }
      
      private function pushUseProp(param1:int, param2:PropInfo) : Boolean
      {
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:Boolean = false;
         if(param2.TemplateID == 10001 || param2.TemplateID == 10002)
         {
            _loc4_ = _numObject[param2.TemplateID] as int;
            if(_loc4_ == 2)
            {
               sendProp(param1,param2);
               _loc3_ = true;
            }
            else if(_loc4_ > 2)
            {
               _loc3_ = true;
            }
         }
         if(param2.TemplateID == 10001 || param2.TemplateID == 10002 || param2.TemplateID == 10003)
         {
            _loc7_ = _numObject[10001] as int;
            _loc5_ = _numObject[10003] as int;
            _loc6_ = _numObject[10002] as int;
            if(_loc7_ >= 1 && _loc5_ >= 1)
            {
               sendProp(param1,param2);
               _loc3_ = true;
            }
            else if(_loc5_ >= 1 && _loc6_ >= 1)
            {
               sendProp(param1,param2);
               _loc3_ = true;
            }
            else if(_loc7_ >= 1 && _loc6_ >= 1)
            {
               sendProp(param1,param2);
               _loc3_ = true;
            }
         }
         return _loc3_;
      }
      
      public function clearPropArr() : void
      {
         _numObject = {};
         twoKillEnabled = true;
      }
      
      override public function set dander(param1:int) : void
      {
         .super.dander = param1;
      }
      
      private function usePropAtSoul(param1:PropInfo, param2:int) : String
      {
         if(_soulPropEnabled)
         {
            if(soulPropCount >= 2)
            {
               return "SoulPropOverFlow";
            }
            if(param2 == 2)
            {
               useItem(param1.Template);
               GameInSocketOut.sendUseProp(param2,param1.Place,param1.Template.TemplateID);
               soulPropCount = Number(soulPropCount) + 1;
            }
            else
            {
               if(psychic < param1.needPsychic)
               {
                  return "EmptyPsychic";
               }
               useItem(param1.Template);
               GameInSocketOut.sendUseProp(param2,param1.Place,param1.Template.TemplateID);
               psychic = psychic - param1.needPsychic;
               soulPropCount = Number(soulPropCount) + 1;
            }
         }
         return "0";
      }
      
      private function usePropAtLive(param1:PropInfo, param2:int) : String
      {
         if(!_isLiving && param2 == 1)
         {
            return "NotLiving";
         }
         if(!_isAttacking)
         {
            return "NotAttacking";
         }
         if(_lockState)
         {
            if(_lockType != 0)
            {
               return "LockState";
            }
         }
         else
         {
            if(_energy < param1.needEnergy)
            {
               return "EmptyEnergy";
            }
            updateNums(param1);
            if(param1.TemplateID == 10001 || param1.TemplateID == 10002 || param1.TemplateID == 10003)
            {
               if(!twoKillEnabled)
               {
                  GameInSocketOut.sendUseProp(param2,param1.Place,param1.Template.TemplateID);
                  return "-1";
               }
               if(pushUseProp(param2,param1))
               {
                  return "-1";
               }
            }
            if(param1.TemplateID == 10003)
            {
               if(threeKillEnabled)
               {
                  useItem(param1.Template);
                  GameInSocketOut.sendUseProp(param2,param1.Place,param1.Template.TemplateID);
                  return "-1";
               }
            }
            else
            {
               useItem(param1.Template);
               GameInSocketOut.sendUseProp(param2,param1.Place,param1.Template.TemplateID);
               return "-1";
            }
         }
         return "0";
      }
      
      override public function useItem(param1:ItemTemplateInfo) : void
      {
         if(param1.TemplateID == 10003)
         {
            useThreeKillImp();
         }
         super.useItem(param1);
      }
      
      public function get threeKillEnabled() : Boolean
      {
         return _threeKillEnabled && _propEnabled && _rightPropEnabled && checkArmShellSpring();
      }
      
      public function set threeKillEnabled(param1:Boolean) : void
      {
         if(_threeKillEnabled != param1)
         {
            _threeKillEnabled = param1;
            dispatchEvent(new LivingEvent("threekillChanged"));
         }
      }
      
      private function useThreeKillImp() : void
      {
         threeKillEnabled = false;
         spellKillEnabled = false;
         if(hasDeputyWeapon() && EquipType.isAngel(currentDeputyWeaponInfo.Template))
         {
            deputyWeaponEnabled = false;
         }
      }
      
      private function checkArmShellSpring() : Boolean
      {
         if(GameControl.Instance.Current.roomType != 120)
         {
            return true;
         }
         var _loc1_:InventoryItemInfo = PlayerManager.Instance.Self.Bag.getItemAt(20);
         if(_loc1_ && EquipType.isArmShellSpring(_loc1_))
         {
            return false;
         }
         return true;
      }
      
      public function useSpellKill() : String
      {
         if(spellKillEnabled && _isAttacking)
         {
            useSpellKillImp();
            return "-1";
         }
         return "0";
      }
      
      private function useSpellKillImp() : void
      {
         totemEnabled = false;
         threeKillEnabled = false;
         flyEnabled = false;
         spellKillEnabled = false;
         if(hasDeputyWeapon() && EquipType.isAngel(currentDeputyWeaponInfo.Template))
         {
            deputyWeaponEnabled = false;
         }
         skill = 0;
         isSpecialSkill = true;
         dander = 0;
         GameInSocketOut.sendGameCMDStunt();
      }
      
      public function get spellKillEnabled() : Boolean
      {
         return _spellKillEnabled && _dander >= 200 && !_lockSpellKill && _isLiving;
      }
      
      public function set spellKillEnabled(param1:Boolean) : void
      {
         if(_spellKillEnabled != param1)
         {
            _spellKillEnabled = param1;
            dispatchEvent(new LivingEvent("spellkillChanged"));
         }
      }
      
      public function set propEnabled(param1:Boolean) : void
      {
         if(_propEnabled != param1)
         {
            _propEnabled = param1;
            dispatchEvent(new LivingEvent("propenabledChanged"));
         }
      }
      
      public function get propEnabled() : Boolean
      {
         return _propEnabled && !_lockProp;
      }
      
      public function set petSkillEnabled(param1:Boolean) : void
      {
         if(_petSkillEnabled != param1)
         {
            _petSkillEnabled = param1;
            dispatchEvent(new LivingEvent("propenabledChanged"));
         }
      }
      
      public function get petSkillEnabled() : Boolean
      {
         return _petSkillEnabled;
      }
      
      public function get totemEnabled() : Boolean
      {
         var _loc1_:* = null;
         if(GameControl.Instance.Current && (GameControl.Instance.Current.roomType == 120 || GameControl.Instance.Current.roomType == 1 && GameControl.Instance.Current.gameMode == 120))
         {
            _loc1_ = PlayerManager.Instance.Self.Bag.getItemAt(20);
            if(_loc1_ && EquipType.isArmShellTotem(_loc1_))
            {
               return _totemEnabled;
            }
         }
         return true;
      }
      
      public function set totemEnabled(param1:Boolean) : void
      {
         _totemEnabled = param1;
      }
      
      public function set dynamismBarDisable(param1:Boolean) : void
      {
         if(_petSkillEnabled != param1)
         {
            _dynamismBarDisable = param1;
            dispatchEvent(new LivingEvent("DisturbStateChanged"));
         }
      }
      
      public function get dynamismBarDisable() : Boolean
      {
         return _dynamismBarDisable;
      }
      
      public function set soulPropEnabled(param1:Boolean) : void
      {
         if(_soulPropEnabled != param1)
         {
            _soulPropEnabled = param1;
            dispatchEvent(new LivingEvent("soulPropEnableChanged"));
         }
      }
      
      public function get soulPropEnabled() : Boolean
      {
         return _soulPropEnabled && !_lockProp;
      }
      
      public function get customPropEnabled() : Boolean
      {
         return _customPropEnabled && _propEnabled;
      }
      
      public function set customPropEnabled(param1:Boolean) : void
      {
         if(_customPropEnabled != param1)
         {
            _customPropEnabled = param1;
            dispatchEvent(new LivingEvent("customenabledChanged"));
         }
      }
      
      public function set lockRightProp(param1:Boolean) : void
      {
         if(_lockRightProp != param1)
         {
            _lockRightProp = param1;
            dispatchEvent(new LivingEvent("rightenabledChanged"));
         }
      }
      
      public function get lockRightProp() : Boolean
      {
         return _lockRightProp;
      }
      
      public function get rightPropEnabled() : Boolean
      {
         return _rightPropEnabled && _propEnabled && _isLiving && !_lockRightProp;
      }
      
      public function set rightPropEnabled(param1:Boolean) : void
      {
         if(_rightPropEnabled != param1)
         {
            _rightPropEnabled = param1;
            dispatchEvent(new LivingEvent("rightenabledChanged"));
         }
      }
      
      public function get lockDeputyWeapon() : Boolean
      {
         return _lockDeputyWeapon;
      }
      
      public function set lockDeputyWeapon(param1:Boolean) : void
      {
         if(_lockDeputyWeapon != param1)
         {
            _lockDeputyWeapon = param1;
            dispatchEvent(new LivingEvent("deputyweapin_Changed"));
         }
      }
      
      public function get lockFly() : Boolean
      {
         return _lockFly;
      }
      
      public function set lockFly(param1:Boolean) : void
      {
         if(_lockFly != param1)
         {
            _lockFly = param1;
            dispatchEvent(new LivingEvent("flyChanged"));
         }
      }
      
      public function get lockSpellKill() : Boolean
      {
         return _lockSpellKill;
      }
      
      public function set lockSpellKill(param1:Boolean) : void
      {
         if(_lockSpellKill != param1)
         {
            _lockSpellKill = param1;
            dispatchEvent(new LivingEvent("spellkillChanged"));
         }
      }
      
      public function set lockProp(param1:Boolean) : void
      {
         if(_lockProp != param1)
         {
            _lockProp = param1;
            dispatchEvent(new LivingEvent("propenabledChanged"));
         }
      }
      
      public function get lockProp() : Boolean
      {
         return _lockProp;
      }
      
      public function get shootEnabled() : Boolean
      {
         return _isAttacking && _isLiving;
      }
      
      public function setCenter(param1:Number, param2:Number, param3:Boolean) : void
      {
         dispatchEvent(new LivingEvent("setCenter",0,0,param1,param2,param3));
      }
      
      public function get flyCount() : int
      {
         return _flyCount;
      }
      
      public function set flyCount(param1:int) : void
      {
         _flyCount = param1;
         dispatchEvent(new LivingEvent("flyChanged"));
      }
      
      public function get usePassBall() : Boolean
      {
         return _usePassBall;
      }
      
      public function set usePassBall(param1:Boolean) : void
      {
         _usePassBall = param1;
      }
   }
}
