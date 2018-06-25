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
      
      public function PetSkillBar(self:LocalPlayer)
      {
         letters = ["Q","E","T","Y","U"];
         _bg = ComponentFactory.Instance.creatBitmap("asset.game.petSkillBar.back");
         PositionUtils.setPos(_bg,"game.petSikllBar.BGPos");
         addChild(_bg);
         _skillCells = new Vector.<PetSkillCell>();
         super(self);
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
         for each(var cell in _skillCells)
         {
            if(cell.isEnabled)
            {
               cell.addEventListener("click",onCellClick);
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
      
      public function set lockState(value:Boolean) : void
      {
         var cell:* = null;
         var _loc4_:* = value;
         if(true !== _loc4_)
         {
            if(false === _loc4_)
            {
               _petSkillLockStatus = false;
               KeyboardManager.getInstance().removeEventListener("keyDown",__keyDown);
               var _loc6_:int = 0;
               var _loc5_:* = _skillCells;
               for each(cell in _skillCells)
               {
                  if(cell.isEnabled)
                  {
                     cell.removeEventListener("click",onCellClick);
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
            for each(cell in _skillCells)
            {
               if(cell.isEnabled)
               {
                  cell.addEventListener("click",onCellClick);
               }
            }
         }
      }
      
      override protected function removeEvent() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _skillCells;
         for each(var cell in _skillCells)
         {
            if(cell.isEnabled)
            {
               cell.removeEventListener("click",onCellClick);
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
      
      override protected function __keyDown(event:KeyboardEvent) : void
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
         var index:int = -1;
         var _loc5_:* = event.keyCode;
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
                        index = 4;
                     }
                  }
                  else
                  {
                     index = 3;
                  }
               }
               else
               {
                  index = 2;
               }
            }
            else
            {
               index = 1;
            }
         }
         else
         {
            index = 0;
         }
         var key:String = letters[index];
         var _loc7_:int = 0;
         var _loc6_:* = _skillCells;
         for each(var skillCell in _skillCells)
         {
            if(skillCell.shortcutKey == key && skillCell.skillInfo && skillCell.skillInfo.isActiveSkill && skillCell.isEnabled && skillCell.enabled)
            {
               skillCell.useProp();
               break;
            }
         }
      }
      
      private function __onPetSkillUsedFail(pEvent:LivingEvent) : void
      {
         _usedPetSkill = false;
         _self.deputyWeaponEnabled = true;
         _self.isUsedPetSkillWithNoItem = false;
      }
      
      private function __onChange(event:LivingEvent) : void
      {
         updateCellEnable();
      }
      
      private function skillInfoInit(event:Event) : void
      {
         var len:int = 0;
         var i:int = 0;
         var infoList:Array = GameControl.Instance.petSkillList;
         if(infoList)
         {
            len = infoList.length;
            while(i < len)
            {
               var _loc7_:int = 0;
               var _loc6_:* = _skillCells;
               for each(var cell in _skillCells)
               {
                  if(cell.skillInfo && cell.skillInfo.ID == infoList[i].id)
                  {
                     cell.turnNum = cell.skillInfo.ColdDown + 1 - infoList[i].cd;
                     break;
                  }
               }
               i++;
            }
            GameControl.Instance.petSkillList = null;
         }
      }
      
      private function __petSkillCD(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var skillid:int = pkg.readInt();
         var cd:int = pkg.readInt();
         var _loc7_:int = 0;
         var _loc6_:* = _skillCells;
         for each(var cell in _skillCells)
         {
            if(cell.skillInfo.ID == skillid)
            {
               cell.turnNum = cell.skillInfo.ColdDown + 1 - cd;
            }
         }
         updateCellEnable();
      }
      
      private function __usingSpecialKill(event:LivingEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _skillCells;
         for each(var cell in _skillCells)
         {
            cell.enabled = false;
         }
         _usedSpecialSkill = true;
      }
      
      private function __onUseItem(event:LivingEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _skillCells;
         for each(var cell in _skillCells)
         {
            if(cell.skillInfo)
            {
               if(cell.skillInfo.BallType == 1 || cell.skillInfo.BallType == 2)
               {
                  cell.enabled = false;
               }
            }
         }
         _usedItem = true;
      }
      
      private function __onUsePetSkill(event:LivingEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _skillCells;
         for each(var cell in _skillCells)
         {
            if(cell.skillInfo)
            {
               if(cell.skillInfo.ID == event.value)
               {
                  cell.turnNum = 0;
                  break;
               }
            }
         }
         updateCellEnable();
      }
      
      protected function __onRoundOneEnd(event:CrazyTankSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _skillCells;
         for each(var cell in _skillCells)
         {
            cell.turnNum = Number(cell.turnNum) + 1;
         }
         _usedItem = false;
         _usedSpecialSkill = false;
         _usedPetSkill = false;
         _self.isUsedPetSkillWithNoItem = false;
         updateCellEnable();
      }
      
      private function __onAttackingChange(event:LivingEvent) : void
      {
         updateCellEnable();
      }
      
      private function updateCellEnable() : void
      {
         var e:Boolean = _self.petSkillEnabled;
         var _loc4_:int = 0;
         var _loc3_:* = _skillCells;
         for each(var cell in _skillCells)
         {
            if(cell.skillInfo)
            {
               switch(int(cell.skillInfo.BallType))
               {
                  case 0:
                     cell.enabled = e && _self.isAttacking && !_usedPetSkill && !_usedSpecialSkill && cell.skillInfo.CostMP <= _self.currentPet.MP && cell.turnNum > cell.skillInfo.ColdDown;
                     break;
                  case 1:
                     cell.enabled = e && _self.isAttacking && !_usedPetSkill && !_usedItem && !_usedSpecialSkill && cell.skillInfo.CostMP <= _self.currentPet.MP && cell.turnNum > cell.skillInfo.ColdDown;
                     break;
                  case 2:
                     cell.enabled = e && _self.isAttacking && !_usedPetSkill && !_usedItem && !_usedSpecialSkill && !_self.iscalcForce && cell.skillInfo.CostMP <= _self.currentPet.MP && cell.turnNum > cell.skillInfo.ColdDown;
                     break;
                  case 3:
                     cell.enabled = e && _self.isAttacking && !_usedPetSkill && !_usedSpecialSkill && cell.skillInfo.CostMP <= _self.currentPet.MP && cell.turnNum > cell.skillInfo.ColdDown;
               }
            }
            if(PetsBagManager.instance().petModel.petGuildeOptionOnOff[118] > 0 && cell.enabled)
            {
               PetsBagManager.instance().showPetFarmGuildArrow(118,0,"farmTrainer.petSkillUseArrowPos","asset.farmTrainer.clickHere","farmTrainer.petSkillUseTipPos",this);
            }
         }
      }
      
      private function onCellClick(event:MouseEvent) : void
      {
         if(_self.isLocked)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.campBattle.onlyFly"));
            return;
         }
         var tgt:PetSkillCell = event.currentTarget as PetSkillCell;
         if(tgt.enabled && _self.isAttacking)
         {
            SoundManager.instance.play("008");
            if(tgt.skillInfo.BallType == 1 || tgt.skillInfo.BallType == 2)
            {
               if(_self.isUsedItem)
               {
                  return;
               }
               _self.customPropEnabled = false;
               _self.deputyWeaponEnabled = false;
               _self.isUsedPetSkillWithNoItem = true;
            }
            SocketManager.Instance.out.sendPetSkill(tgt.skillInfo.ID);
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
         for each(var cell in _skillCells)
         {
            cell.dispose();
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
         var pos:* = null;
         var index:int = 0;
         var i:int = 0;
         var cellz:* = null;
         var skillid:int = 0;
         var skill:* = null;
         if(_self.currentPet)
         {
            pos = ComponentFactory.Instance.creatCustomObject("CustomPetPropCellPos");
            for(i = 0; i < letters.length; )
            {
               cellz = new PetSkillCell(letters[i],1,false,33,33);
               skillid = _self.currentPet.equipedSkillIDs[i];
               if(RoomManager.Instance.current.type == 24)
               {
                  cellz.creteSkillCell(null,true);
               }
               else if(skillid > 0)
               {
                  skill = new PetSkill(skillid);
                  if(_self.currentMap.info.ID == 70001)
                  {
                     cellz.creteSkillCell(null,true);
                  }
                  else
                  {
                     cellz.creteSkillCell(skill,true);
                  }
                  _skillCells.push(cellz);
               }
               else if(skillid == 0)
               {
                  cellz.creteSkillCell(null);
               }
               else
               {
                  cellz.creteSkillCell(null,true);
               }
               cellz.setPossiton(pos.x + i * 35,pos.y);
               addChild(cellz);
               i++;
            }
            drawLayer();
         }
      }
   }
}
