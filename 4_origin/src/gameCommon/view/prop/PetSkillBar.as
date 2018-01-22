package gameCommon.view.prop
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.LivingEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import gameCommon.GameControl;
   import gameCommon.model.LocalPlayer;
   import gameCommon.view.tool.PetEnergyStrip;
   import org.aswing.KeyStroke;
   import org.aswing.KeyboardManager;
   import pet.data.PetSkill;
   import petsBag.PetsBagManager;
   import road7th.comm.PackageIn;
   import room.RoomManager;
   
   public class PetSkillBar extends FightPropBar
   {
       
      
      private var _skillCells:Vector.<PetSkillCell>;
      
      private var _usedItem:Boolean = false;
      
      private var _usedSpecialSkill:Boolean = false;
      
      private var _usedPetSkill:Boolean = false;
      
      private var _bg:Bitmap;
      
      private var _petEnergyStrip:PetEnergyStrip;
      
      private var _petSkillLockStatus:Boolean;
      
      private var letters:Array;
      
      public function PetSkillBar(param1:LocalPlayer)
      {
         letters = ["Q","E","T","Y","U"];
         _bg = ComponentFactory.Instance.creatBitmap("asset.game.petSkillBar.back");
         PositionUtils.setPos(_bg,"game.petSikllBar.BGPos");
         addChild(_bg);
         _skillCells = new Vector.<PetSkillCell>();
         super(param1);
         updateCellEnable();
         if(GameControl.Instance.Current.selfGamePlayer.currentPet)
         {
            _petEnergyStrip = new PetEnergyStrip(GameControl.Instance.Current.selfGamePlayer.currentPet);
            PositionUtils.setPos(_petEnergyStrip,"asset.game.mpStripPos");
            addChild(_petEnergyStrip);
         }
         skillInfoInit(null);
      }
      
      override public function enter() : void
      {
         addEvent();
      }
      
      override protected function addEvent() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _skillCells;
         for each(var _loc1_ in _skillCells)
         {
            if(_loc1_.isEnabled)
            {
               _loc1_.addEventListener("click",onCellClick);
            }
         }
         _self.currentPet.addEventListener("petEnergyChange",__onChange);
         _self.currentPet.addEventListener("usePetSkill",__onUsePetSkill);
         _self.addEventListener("attackingChanged",__onAttackingChange);
         _self.addEventListener("usingSpecialSkill",__usingSpecialKill);
         _self.addEventListener("usingItem",__onUseItem);
         _self.addEventListener("isCalcForceChange",__onChange);
         _self.addEventListener("petSkillenabledChanged",__onChange);
         SocketManager.Instance.addEventListener("petSkillCD",__petSkillCD);
         KeyboardManager.getInstance().addEventListener("keyDown",__keyDown);
         _petSkillLockStatus = true;
         GameControl.Instance.addEventListener("petSkillUsedFail",__onPetSkillUsedFail);
         SocketManager.Instance.addEventListener("roundOneEnd",__onRoundOneEnd);
         GameControl.Instance.addEventListener("skillInfoInitGame",skillInfoInit);
      }
      
      public function set lockState(param1:Boolean) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = param1;
         if(true !== _loc4_)
         {
            if(false === _loc4_)
            {
               _petSkillLockStatus = false;
               KeyboardManager.getInstance().removeEventListener("keyDown",__keyDown);
               var _loc6_:int = 0;
               var _loc5_:* = _skillCells;
               for each(_loc2_ in _skillCells)
               {
                  if(_loc2_.isEnabled)
                  {
                     _loc2_.removeEventListener("click",onCellClick);
                  }
               }
            }
         }
         else if(_petSkillLockStatus == false)
         {
            _petSkillLockStatus = true;
            KeyboardManager.getInstance().addEventListener("keyDown",__keyDown);
            _loc4_ = 0;
            var _loc3_:* = _skillCells;
            for each(_loc2_ in _skillCells)
            {
               if(_loc2_.isEnabled)
               {
                  _loc2_.addEventListener("click",onCellClick);
               }
            }
         }
      }
      
      override protected function removeEvent() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _skillCells;
         for each(var _loc1_ in _skillCells)
         {
            if(_loc1_.isEnabled)
            {
               _loc1_.removeEventListener("click",onCellClick);
            }
         }
         KeyboardManager.getInstance().removeEventListener("keyDown",__keyDown);
         _petSkillLockStatus = false;
         _self.currentPet.removeEventListener("petEnergyChange",__onChange);
         _self.currentPet.removeEventListener("usePetSkill",__onUsePetSkill);
         _self.removeEventListener("attackingChanged",__onAttackingChange);
         _self.removeEventListener("usingSpecialSkill",__usingSpecialKill);
         _self.removeEventListener("usingItem",__onUseItem);
         _self.removeEventListener("isCalcForceChange",__onChange);
         _self.removeEventListener("petSkillenabledChanged",__onChange);
         SocketManager.Instance.removeEventListener("petSkillCD",__petSkillCD);
         GameControl.Instance.removeEventListener("petSkillUsedFail",__onPetSkillUsedFail);
         SocketManager.Instance.removeEventListener("roundOneEnd",__onRoundOneEnd);
         GameControl.Instance.removeEventListener("skillInfoInitGame",skillInfoInit);
      }
      
      override protected function __keyDown(param1:KeyboardEvent) : void
      {
         if(GameControl.Instance.Current.missionInfo && GameControl.Instance.Current.missionInfo.isWorldCupI)
         {
            return;
         }
         if(_self && _self.isLocked)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.campBattle.onlyFly"));
            return;
         }
         var _loc2_:int = -1;
         var _loc5_:* = param1.keyCode;
         if(KeyStroke.VK_Q.getCode() !== _loc5_)
         {
            if(KeyStroke.VK_E.getCode() !== _loc5_)
            {
               if(KeyStroke.VK_T.getCode() !== _loc5_)
               {
                  if(KeyStroke.VK_Y.getCode() !== _loc5_)
                  {
                     if(KeyStroke.VK_U.getCode() === _loc5_)
                     {
                        _loc2_ = 4;
                     }
                  }
                  else
                  {
                     _loc2_ = 3;
                  }
               }
               else
               {
                  _loc2_ = 2;
               }
            }
            else
            {
               _loc2_ = 1;
            }
         }
         else
         {
            _loc2_ = 0;
         }
         var _loc4_:String = letters[_loc2_];
         var _loc7_:int = 0;
         var _loc6_:* = _skillCells;
         for each(var _loc3_ in _skillCells)
         {
            if(_loc3_.shortcutKey == _loc4_ && _loc3_.skillInfo && _loc3_.skillInfo.isActiveSkill && _loc3_.isEnabled && _loc3_.enabled)
            {
               _loc3_.useProp();
               break;
            }
         }
      }
      
      private function __onPetSkillUsedFail(param1:LivingEvent) : void
      {
         _usedPetSkill = false;
         _self.deputyWeaponEnabled = true;
         _self.isUsedPetSkillWithNoItem = false;
      }
      
      private function __onChange(param1:LivingEvent) : void
      {
         updateCellEnable();
      }
      
      private function skillInfoInit(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:Array = GameControl.Instance.petSkillList;
         if(_loc2_)
         {
            _loc4_ = _loc2_.length;
            while(_loc5_ < _loc4_)
            {
               var _loc7_:int = 0;
               var _loc6_:* = _skillCells;
               for each(var _loc3_ in _skillCells)
               {
                  if(_loc3_.skillInfo && _loc3_.skillInfo.ID == _loc2_[_loc5_].id)
                  {
                     _loc3_.turnNum = _loc3_.skillInfo.ColdDown + 1 - _loc2_[_loc5_].cd;
                     break;
                  }
               }
               _loc5_++;
            }
            GameControl.Instance.petSkillList = null;
         }
      }
      
      private function __petSkillCD(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = _loc4_.readInt();
         var _loc5_:int = _loc4_.readInt();
         var _loc7_:int = 0;
         var _loc6_:* = _skillCells;
         for each(var _loc3_ in _skillCells)
         {
            if(_loc3_.skillInfo.ID == _loc2_)
            {
               _loc3_.turnNum = _loc3_.skillInfo.ColdDown + 1 - _loc5_;
            }
         }
         updateCellEnable();
      }
      
      private function __usingSpecialKill(param1:LivingEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _skillCells;
         for each(var _loc2_ in _skillCells)
         {
            _loc2_.enabled = false;
         }
         _usedSpecialSkill = true;
      }
      
      private function __onUseItem(param1:LivingEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _skillCells;
         for each(var _loc2_ in _skillCells)
         {
            if(_loc2_.skillInfo)
            {
               if(_loc2_.skillInfo.BallType == 1 || _loc2_.skillInfo.BallType == 2)
               {
                  _loc2_.enabled = false;
               }
            }
         }
         _usedItem = true;
      }
      
      private function __onUsePetSkill(param1:LivingEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _skillCells;
         for each(var _loc2_ in _skillCells)
         {
            if(_loc2_.skillInfo)
            {
               if(_loc2_.skillInfo.ID == param1.value)
               {
                  _loc2_.turnNum = 0;
                  break;
               }
            }
         }
         updateCellEnable();
      }
      
      protected function __onRoundOneEnd(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _skillCells;
         for each(var _loc2_ in _skillCells)
         {
            _loc2_.turnNum = Number(_loc2_.turnNum) + 1;
         }
         _usedItem = false;
         _usedSpecialSkill = false;
         _usedPetSkill = false;
         _self.isUsedPetSkillWithNoItem = false;
         updateCellEnable();
      }
      
      private function __onAttackingChange(param1:LivingEvent) : void
      {
         updateCellEnable();
      }
      
      private function updateCellEnable() : void
      {
         var _loc1_:Boolean = _self.petSkillEnabled;
         var _loc4_:int = 0;
         var _loc3_:* = _skillCells;
         for each(var _loc2_ in _skillCells)
         {
            if(_loc2_.skillInfo)
            {
               switch(int(_loc2_.skillInfo.BallType))
               {
                  case 0:
                     _loc2_.enabled = _loc1_ && _self.isAttacking && !_usedPetSkill && !_usedSpecialSkill && _loc2_.skillInfo.CostMP <= _self.currentPet.MP && _loc2_.turnNum > _loc2_.skillInfo.ColdDown;
                     break;
                  case 1:
                     _loc2_.enabled = _loc1_ && _self.isAttacking && !_usedPetSkill && !_usedItem && !_usedSpecialSkill && _loc2_.skillInfo.CostMP <= _self.currentPet.MP && _loc2_.turnNum > _loc2_.skillInfo.ColdDown;
                     break;
                  case 2:
                     _loc2_.enabled = _loc1_ && _self.isAttacking && !_usedPetSkill && !_usedItem && !_usedSpecialSkill && !_self.iscalcForce && _loc2_.skillInfo.CostMP <= _self.currentPet.MP && _loc2_.turnNum > _loc2_.skillInfo.ColdDown;
                     break;
                  case 3:
                     _loc2_.enabled = _loc1_ && _self.isAttacking && !_usedPetSkill && !_usedSpecialSkill && _loc2_.skillInfo.CostMP <= _self.currentPet.MP && _loc2_.turnNum > _loc2_.skillInfo.ColdDown;
               }
            }
            if(PetsBagManager.instance().petModel.petGuildeOptionOnOff[118] > 0 && _loc2_.enabled)
            {
               PetsBagManager.instance().showPetFarmGuildArrow(118,0,"farmTrainer.petSkillUseArrowPos","asset.farmTrainer.clickHere","farmTrainer.petSkillUseTipPos",this);
            }
         }
      }
      
      private function onCellClick(param1:MouseEvent) : void
      {
         if(_self.isLocked)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.campBattle.onlyFly"));
            return;
         }
         var _loc2_:PetSkillCell = param1.currentTarget as PetSkillCell;
         if(_loc2_.enabled && _self.isAttacking)
         {
            SoundManager.instance.play("008");
            if(_loc2_.skillInfo.BallType == 1 || _loc2_.skillInfo.BallType == 2)
            {
               if(_self.isUsedItem)
               {
                  return;
               }
               _self.customPropEnabled = false;
               _self.deputyWeaponEnabled = false;
               _self.isUsedPetSkillWithNoItem = true;
            }
            SocketManager.Instance.out.sendPetSkill(_loc2_.skillInfo.ID);
            _usedPetSkill = true;
            if(PetsBagManager.instance().petModel.petGuildeOptionOnOff[118] > 0)
            {
               PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(118);
               PetsBagManager.instance().petModel.petGuildeOptionOnOff[118] = 0;
            }
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         var _loc3_:int = 0;
         var _loc2_:* = _skillCells;
         for each(var _loc1_ in _skillCells)
         {
            _loc1_.dispose();
         }
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         _skillCells = null;
         if(_petEnergyStrip)
         {
            ObjectUtils.disposeObject(_petEnergyStrip);
         }
         _petEnergyStrip = null;
         super.dispose();
      }
      
      override protected function drawCells() : void
      {
         var _loc6_:* = null;
         var _loc1_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(_self.currentPet)
         {
            _loc6_ = ComponentFactory.Instance.creatCustomObject("CustomPetPropCellPos");
            _loc5_ = 0;
            while(_loc5_ < letters.length)
            {
               _loc4_ = new PetSkillCell(letters[_loc5_],1,false,33,33);
               _loc3_ = _self.currentPet.equipedSkillIDs[_loc5_];
               if(RoomManager.Instance.current.type == 24)
               {
                  _loc4_.creteSkillCell(null,true);
               }
               else if(_loc3_ > 0)
               {
                  _loc2_ = new PetSkill(_loc3_);
                  if(_self.currentMap.info.ID == 70001)
                  {
                     _loc4_.creteSkillCell(null,true);
                  }
                  else
                  {
                     _loc4_.creteSkillCell(_loc2_,true);
                  }
                  _skillCells.push(_loc4_);
               }
               else if(_loc3_ == 0)
               {
                  _loc4_.creteSkillCell(null);
               }
               else
               {
                  _loc4_.creteSkillCell(null,true);
               }
               _loc4_.setPossiton(_loc6_.x + _loc5_ * 35,_loc6_.y);
               addChild(_loc4_);
               _loc5_++;
            }
            drawLayer();
         }
      }
   }
}
