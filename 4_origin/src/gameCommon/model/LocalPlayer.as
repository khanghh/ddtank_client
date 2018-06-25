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
      
      public function LocalPlayer(info:SelfInfo, id:int, team:int, maxBlood:int, templeId:int = 0)
      {
         super(info,id,team,maxBlood,templeId);
         if(info.DeputyWeaponID > 0)
         {
            deputyWeaponCount = info.DeputyWeapon.StrengthenLevel + 1;
         }
         _numObject = {};
      }
      
      public function get isUsedPetSkillWithNoItem() : Boolean
      {
         return _isUsedPetSkillWithNoItem;
      }
      
      public function set isUsedPetSkillWithNoItem(value:Boolean) : void
      {
         _isUsedPetSkillWithNoItem = value;
      }
      
      public function get isUsedItem() : Boolean
      {
         return _isUsedItem;
      }
      
      public function set isUsedItem(value:Boolean) : void
      {
         _isUsedItem = value;
      }
      
      public function get selfInfo() : SelfInfo
      {
         return playerInfo as SelfInfo;
      }
      
      public function showMark(mark:int) : void
      {
         dispatchEvent(new LivingEvent("showMark",0,0,mark - 1));
      }
      
      override public function set pos(value:Point) : void
      {
         if(value.equals(_pos) == false)
         {
            if(isLiving && onChange == true)
            {
               energy = energy - Math.abs(value.x - _pos.x) * powerRatio;
            }
            .super.pos = value;
         }
      }
      
      public function get shootCount() : int
      {
         return _shootCount;
      }
      
      public function set shootCount(value:int) : void
      {
         _shootCount = value;
      }
      
      public function manuallySetGunAngle(value:Number) : Boolean
      {
         var oldGunAngle:int = gunAngle;
         gunAngle = value;
         var result:* = oldGunAngle != gunAngle;
         return result;
      }
      
      public function get gunAngle() : Number
      {
         return _gunAngle;
      }
      
      public function set gunAngle(value:Number) : void
      {
         if(value == _gunAngle)
         {
            return;
         }
         if((currentBomb == 3 || currentBomb == 110 || currentBomb == 117 || currentBomb == 11196 || RoomManager.Instance.current && RoomManager.Instance.current.type == 29) && (value < 0 || value > 90))
         {
            return;
         }
         if(RoomManager.Instance.current)
         {
            if(currentBomb != 3 && currentBomb != 110 && currentBomb != 117 && currentBomb != 11196 && RoomManager.Instance.current.type != 29 && value < currentWeapInfo.armMinAngle)
            {
               _gunAngle = currentWeapInfo.armMinAngle;
               return;
            }
            if(currentBomb != 3 && currentBomb != 110 && currentBomb != 117 && currentBomb != 11196 && RoomManager.Instance.current.type != 29 && value > currentWeapInfo.armMaxAngle)
            {
               _gunAngle = currentWeapInfo.armMaxAngle;
               return;
            }
         }
         else
         {
            if(currentBomb != 3 && currentBomb != 110 && currentBomb != 117 && currentBomb != 11196 && value < currentWeapInfo.armMinAngle)
            {
               _gunAngle = currentWeapInfo.armMinAngle;
               return;
            }
            if(currentBomb != 3 && currentBomb != 110 && currentBomb != 117 && currentBomb != 11196 && value > currentWeapInfo.armMaxAngle)
            {
               _gunAngle = currentWeapInfo.armMaxAngle;
               return;
            }
         }
         _gunAngle = value;
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
      
      public function set force(value:Number) : void
      {
         _force = Math.min(value,2000);
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
      
      public function set iscalcForce(value:Boolean) : void
      {
         if(_iscalcForce == value)
         {
            return;
         }
         _iscalcForce = value;
         dispatchEvent(new LivingEvent("isCalcForceChange"));
      }
      
      public function get iscalcForce() : Boolean
      {
         return _iscalcForce;
      }
      
      public function sendShootAction(force:Number) : void
      {
         dispatchEvent(new LivingEvent("sendShootAction",0,0,force));
      }
      
      public function canUseProp(currentPlayer:TurnedLiving) : Boolean
      {
         return this == currentPlayer && !LockState || !isLiving && team == currentPlayer.team;
      }
      
      override public function pick(box:Object) : void
      {
         super.pick(box);
         if(box.isGhost)
         {
            psychic = psychic + box.psychic;
         }
         SocketManager.Instance.out.sendGamePick(box.Id);
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
      
      override public function die(widthAction:Boolean = true) : void
      {
         var team:DictionaryData = GameControl.Instance.Current.findTeam(this.team);
         var _loc5_:int = 0;
         var _loc4_:* = team;
         for each(var living in team)
         {
            if(!living.isSelf && living.isLiving)
            {
               isLast = false;
               break;
            }
         }
         super.die(widthAction);
         _selfDieTimer = new Timer(500,1);
         _selfDieTimer.start();
         _selfDieTimer.addEventListener("timer",__onDieDelayPassed);
         deputyWeaponEnabled = false;
         flyEnabled = false;
         spellKillEnabled = false;
         rightPropEnabled = false;
         if(isSelf)
         {
            ChatManager.Instance.view.output.ghostState = widthAction;
         }
      }
      
      private function __onDieDelayPassed(event:TimerEvent) : void
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
      
      override public function set isAttacking(value:Boolean) : void
      {
         if(value)
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
         .super.isAttacking = value;
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
         var item:InventoryItemInfo = new InventoryItemInfo();
         var temInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(10016);
         item.TemplateID = temInfo.TemplateID;
         item.Pic = "2";
         item.Property4 = temInfo.Property4;
         var info:PropInfo = new PropInfo(item);
         useItem(info.Template);
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
      
      public function set flyEnabled(val:Boolean) : void
      {
         if(_flyEnabled != val)
         {
            _flyEnabled = val;
            dispatchEvent(new LivingEvent("flyChanged"));
         }
      }
      
      public function set deputyWeaponEnabled(val:Boolean) : void
      {
         if(_deputyWeaponEnabled != val)
         {
            _deputyWeaponEnabled = val;
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
      
      public function set deputyWeaponCount(val:int) : void
      {
         if(_deputyWeaponCount != val)
         {
            _deputyWeaponCount = val;
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
         var dis:* = null;
         _deputyWeaponCoolDown = currentDeputyWeaponInfo.coolDown;
         SocketManager.Instance.out.useDeputyWeapon();
         if(!GameControl.Instance.is3DGame)
         {
            dis = currentDeputyWeaponInfo.getDeputyWeaponIcon();
            dis.x = dis.x + 7;
            useItemByIcon(dis);
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
         var deputyEnergy:Number = currentDeputyWeaponInfo.energy;
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
            if(_energy < deputyEnergy)
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
      
      public function useProp(prop:PropInfo, type:int) : String
      {
         if(_isLiving)
         {
            return usePropAtLive(prop,type);
         }
         return usePropAtSoul(prop,type);
      }
      
      private function updateNums(propInfo:PropInfo) : void
      {
         var num:int = 0;
         if(_numObject.hasOwnProperty(propInfo.TemplateID))
         {
            num = _numObject[propInfo.TemplateID] as int;
         }
         num++;
         _numObject[propInfo.TemplateID] = num;
      }
      
      private function sendProp(type:int, propInfo:PropInfo) : void
      {
         useItem(propInfo.Template);
         GameInSocketOut.sendUseProp(type,propInfo.Place,propInfo.Template.TemplateID);
         dispatchEvent(new Event("setEnable"));
         twoKillEnabled = false;
      }
      
      private function pushUseProp(type:int, propInfo:PropInfo) : Boolean
      {
         var num:int = 0;
         var num1:int = 0;
         var num2:int = 0;
         var num3:int = 0;
         var ref:Boolean = false;
         if(propInfo.TemplateID == 10001 || propInfo.TemplateID == 10002)
         {
            num = _numObject[propInfo.TemplateID] as int;
            if(num == 2)
            {
               sendProp(type,propInfo);
               ref = true;
            }
            else if(num > 2)
            {
               ref = true;
            }
         }
         if(propInfo.TemplateID == 10001 || propInfo.TemplateID == 10002 || propInfo.TemplateID == 10003)
         {
            num1 = _numObject[10001] as int;
            num2 = _numObject[10003] as int;
            num3 = _numObject[10002] as int;
            if(num1 >= 1 && num2 >= 1)
            {
               sendProp(type,propInfo);
               ref = true;
            }
            else if(num2 >= 1 && num3 >= 1)
            {
               sendProp(type,propInfo);
               ref = true;
            }
            else if(num1 >= 1 && num3 >= 1)
            {
               sendProp(type,propInfo);
               ref = true;
            }
         }
         return ref;
      }
      
      public function clearPropArr() : void
      {
         _numObject = {};
         twoKillEnabled = true;
      }
      
      override public function set dander(value:int) : void
      {
         .super.dander = value;
      }
      
      private function usePropAtSoul(prop:PropInfo, type:int) : String
      {
         if(_soulPropEnabled)
         {
            if(soulPropCount >= 2)
            {
               return "SoulPropOverFlow";
            }
            if(type == 2)
            {
               useItem(prop.Template);
               GameInSocketOut.sendUseProp(type,prop.Place,prop.Template.TemplateID);
               soulPropCount = Number(soulPropCount) + 1;
            }
            else
            {
               if(psychic < prop.needPsychic)
               {
                  return "EmptyPsychic";
               }
               useItem(prop.Template);
               GameInSocketOut.sendUseProp(type,prop.Place,prop.Template.TemplateID);
               psychic = psychic - prop.needPsychic;
               soulPropCount = Number(soulPropCount) + 1;
            }
         }
         return "0";
      }
      
      private function usePropAtLive(prop:PropInfo, type:int) : String
      {
         if(!_isLiving && type == 1)
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
            if(_energy < prop.needEnergy)
            {
               return "EmptyEnergy";
            }
            updateNums(prop);
            if(prop.TemplateID == 10001 || prop.TemplateID == 10002 || prop.TemplateID == 10003)
            {
               if(!twoKillEnabled)
               {
                  GameInSocketOut.sendUseProp(type,prop.Place,prop.Template.TemplateID);
                  return "-1";
               }
               if(pushUseProp(type,prop))
               {
                  return "-1";
               }
            }
            if(prop.TemplateID == 10003)
            {
               if(threeKillEnabled)
               {
                  useItem(prop.Template);
                  GameInSocketOut.sendUseProp(type,prop.Place,prop.Template.TemplateID);
                  return "-1";
               }
            }
            else
            {
               useItem(prop.Template);
               GameInSocketOut.sendUseProp(type,prop.Place,prop.Template.TemplateID);
               return "-1";
            }
         }
         return "0";
      }
      
      override public function useItem(info:ItemTemplateInfo) : void
      {
         if(info.TemplateID == 10003)
         {
            useThreeKillImp();
         }
         super.useItem(info);
      }
      
      public function get threeKillEnabled() : Boolean
      {
         return _threeKillEnabled && _propEnabled && _rightPropEnabled && checkArmShellSpring();
      }
      
      public function set threeKillEnabled(val:Boolean) : void
      {
         if(_threeKillEnabled != val)
         {
            _threeKillEnabled = val;
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
         var armShellInfo:InventoryItemInfo = PlayerManager.Instance.Self.Bag.getItemAt(20);
         if(armShellInfo && EquipType.isArmShellSpring(armShellInfo))
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
      
      public function set spellKillEnabled(val:Boolean) : void
      {
         if(_spellKillEnabled != val)
         {
            _spellKillEnabled = val;
            dispatchEvent(new LivingEvent("spellkillChanged"));
         }
      }
      
      public function set propEnabled(val:Boolean) : void
      {
         if(_propEnabled != val)
         {
            _propEnabled = val;
            dispatchEvent(new LivingEvent("propenabledChanged"));
         }
      }
      
      public function get propEnabled() : Boolean
      {
         return _propEnabled && !_lockProp;
      }
      
      public function set petSkillEnabled(val:Boolean) : void
      {
         if(_petSkillEnabled != val)
         {
            _petSkillEnabled = val;
            dispatchEvent(new LivingEvent("propenabledChanged"));
         }
      }
      
      public function get petSkillEnabled() : Boolean
      {
         return _petSkillEnabled;
      }
      
      public function get totemEnabled() : Boolean
      {
         var armShellInfo:* = null;
         if(GameControl.Instance.Current && (GameControl.Instance.Current.roomType == 120 || GameControl.Instance.Current.roomType == 1 && GameControl.Instance.Current.gameMode == 120))
         {
            armShellInfo = PlayerManager.Instance.Self.Bag.getItemAt(20);
            if(armShellInfo && EquipType.isArmShellTotem(armShellInfo))
            {
               return _totemEnabled;
            }
         }
         return true;
      }
      
      public function set totemEnabled(value:Boolean) : void
      {
         _totemEnabled = value;
      }
      
      public function set dynamismBarDisable(val:Boolean) : void
      {
         if(_petSkillEnabled != val)
         {
            _dynamismBarDisable = val;
            dispatchEvent(new LivingEvent("DisturbStateChanged"));
         }
      }
      
      public function get dynamismBarDisable() : Boolean
      {
         return _dynamismBarDisable;
      }
      
      public function set soulPropEnabled(val:Boolean) : void
      {
         if(_soulPropEnabled != val)
         {
            _soulPropEnabled = val;
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
      
      public function set customPropEnabled(val:Boolean) : void
      {
         if(_customPropEnabled != val)
         {
            _customPropEnabled = val;
            dispatchEvent(new LivingEvent("customenabledChanged"));
         }
      }
      
      public function set lockRightProp(val:Boolean) : void
      {
         if(_lockRightProp != val)
         {
            _lockRightProp = val;
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
      
      public function set rightPropEnabled(val:Boolean) : void
      {
         if(_rightPropEnabled != val)
         {
            _rightPropEnabled = val;
            dispatchEvent(new LivingEvent("rightenabledChanged"));
         }
      }
      
      public function get lockDeputyWeapon() : Boolean
      {
         return _lockDeputyWeapon;
      }
      
      public function set lockDeputyWeapon(val:Boolean) : void
      {
         if(_lockDeputyWeapon != val)
         {
            _lockDeputyWeapon = val;
            dispatchEvent(new LivingEvent("deputyweapin_Changed"));
         }
      }
      
      public function get lockFly() : Boolean
      {
         return _lockFly;
      }
      
      public function set lockFly(val:Boolean) : void
      {
         if(_lockFly != val)
         {
            _lockFly = val;
            dispatchEvent(new LivingEvent("flyChanged"));
         }
      }
      
      public function get lockSpellKill() : Boolean
      {
         return _lockSpellKill;
      }
      
      public function set lockSpellKill(val:Boolean) : void
      {
         if(_lockSpellKill != val)
         {
            _lockSpellKill = val;
            dispatchEvent(new LivingEvent("spellkillChanged"));
         }
      }
      
      public function set lockProp(val:Boolean) : void
      {
         if(_lockProp != val)
         {
            _lockProp = val;
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
      
      public function setCenter(px:Number, py:Number, isTween:Boolean) : void
      {
         dispatchEvent(new LivingEvent("setCenter",0,0,px,py,isTween));
      }
      
      public function get flyCount() : int
      {
         return _flyCount;
      }
      
      public function set flyCount(value:int) : void
      {
         _flyCount = value;
         dispatchEvent(new LivingEvent("flyChanged"));
      }
      
      public function get usePassBall() : Boolean
      {
         return _usePassBall;
      }
      
      public function set usePassBall(value:Boolean) : void
      {
         _usePassBall = value;
      }
   }
}
