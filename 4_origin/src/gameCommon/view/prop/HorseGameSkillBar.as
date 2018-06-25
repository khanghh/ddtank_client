package gameCommon.view.prop
{
   import battleSkill.BattleSkillManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.LivingEvent;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.filters.ColorMatrixFilter;
   import gameCommon.GameControl;
   import gameCommon.model.LocalPlayer;
   import horse.HorseManager;
   import horse.data.HorseSkillVo;
   import org.aswing.KeyStroke;
   import org.aswing.KeyboardManager;
   import road7th.data.DictionaryData;
   
   public class HorseGameSkillBar extends Sprite implements Disposeable
   {
       
      
      private var _cellList:Vector.<HorseGameSkillCell>;
      
      private var _self:LocalPlayer;
      
      private var _enabled:Boolean = true;
      
      private var _turnEnabled:Boolean = true;
      
      private var _horseSkillLockStatus:Boolean;
      
      public function HorseGameSkillBar(self:LocalPlayer)
      {
         super();
         _self = self;
         initView();
         initEvent();
         skillInfoInit(null);
      }
      
      private function initView() : void
      {
         _cellList = new Vector.<HorseGameSkillCell>();
         var tmpUseSkillList:DictionaryData = curUseSkillList;
         var tmpZ:HorseGameSkillCell = new HorseGameSkillCell(!!tmpUseSkillList.hasKey("1")?tmpUseSkillList["1"]:-1,"z",_self);
         var tmpX:HorseGameSkillCell = new HorseGameSkillCell(!!tmpUseSkillList.hasKey("2")?tmpUseSkillList["2"]:-1,"x",_self);
         var tmpC:HorseGameSkillCell = new HorseGameSkillCell(!!tmpUseSkillList.hasKey("3")?tmpUseSkillList["3"]:-1,"c",_self);
         PositionUtils.setPos(tmpZ,"CustomPropCellPosz");
         PositionUtils.setPos(tmpX,"CustomPropCellPosx");
         PositionUtils.setPos(tmpC,"CustomPropCellPosc");
         addChild(tmpZ);
         addChild(tmpX);
         addChild(tmpC);
         _cellList.push(tmpZ);
         _cellList.push(tmpX);
         _cellList.push(tmpC);
      }
      
      private function get curUseSkillList() : DictionaryData
      {
         if(GameControl.Instance.Current.roomType == 120 || GameControl.Instance.Current.roomType == 123 || GameControl.Instance.Current.gameMode == 120)
         {
            return BattleSkillManager.instance.curUseSkillList;
         }
         return HorseManager.instance.curUseSkillList;
      }
      
      private function initEvent() : void
      {
         var i:int = 0;
         _self.addEventListener("horseSkillUse",useSkillHandler);
         _self.addEventListener("attackingChanged",onAttackingChange);
         SocketManager.Instance.addEventListener("roundOneEnd",__onRoundOneEnd);
         _self.addEventListener("customenabledChanged",__customEnabledChanged);
         _self.addEventListener("energyChanged",__energyChange);
         _self.addEventListener("propenabledChanged",__enabledChanged);
         _self.addEventListener("usingSpecialSkill",__usingSpecialKill);
         _self.addEventListener("usingItem",__onUseItem);
         _self.addEventListener("notUseBattleSkill",__notUseBattleSkill);
         GameControl.Instance.addEventListener("skillInfoInitGame",skillInfoInit);
         KeyboardManager.getInstance().addEventListener("keyDown",__keyDown);
         for(i = 0; i <= _cellList.length - 1; )
         {
            _cellList[i].addEventListener("cell_clicked",__horseGameSkillCellClicked);
            i++;
         }
         _horseSkillLockStatus = true;
      }
      
      protected function __horseGameSkillCellClicked(event:Event) : void
      {
         _turnEnabled = false;
         enabled = false;
      }
      
      private function __keyDown(event:KeyboardEvent) : void
      {
         var key:int = -1;
         var _loc3_:* = event.keyCode;
         if(KeyStroke.VK_Z.getCode() !== _loc3_)
         {
            if(KeyStroke.VK_X.getCode() !== _loc3_)
            {
               if(KeyStroke.VK_C.getCode() === _loc3_)
               {
                  key = 2;
               }
            }
            else
            {
               key = 1;
            }
         }
         else
         {
            key = 0;
         }
         if(key >= 0)
         {
            _cellList[key].useSkill();
         }
      }
      
      public function set lockState(value:Boolean) : void
      {
         var i:int = 0;
         var j:int = 0;
         var _loc4_:* = value;
         if(true !== _loc4_)
         {
            if(false === _loc4_)
            {
               _horseSkillLockStatus = false;
               KeyboardManager.getInstance().removeEventListener("keyDown",__keyDown);
               for(j = 0; j <= _cellList.length - 1; )
               {
                  _cellList[j].removeEventListener("cell_clicked",__horseGameSkillCellClicked);
                  j++;
               }
            }
         }
         else if(_horseSkillLockStatus == false)
         {
            _horseSkillLockStatus = true;
            KeyboardManager.getInstance().addEventListener("keyDown",__keyDown);
            for(i = 0; i <= _cellList.length - 1; )
            {
               _cellList[i].addEventListener("cell_clicked",__horseGameSkillCellClicked);
               i++;
            }
         }
      }
      
      protected function __onRoundOneEnd(event:CrazyTankSocketEvent) : void
      {
         _turnEnabled = true;
         enabled = _turnEnabled && _self.propEnabled && _self.customPropEnabled;
         var _loc4_:int = 0;
         var _loc3_:* = _cellList;
         for each(var tmp in _cellList)
         {
            tmp.roundOneEndHandler();
         }
      }
      
      private function onAttackingChange(event:LivingEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _cellList;
         for each(var tmp in _cellList)
         {
            tmp.attackChangeHandler(_self.isAttacking);
         }
      }
      
      private function useSkillHandler(event:LivingEvent) : void
      {
         var args:Array = event.paras;
         var _loc5_:int = 0;
         var _loc4_:* = _cellList;
         for each(var tmp in _cellList)
         {
            if(tmp.skillId == args[0])
            {
               tmp.useCompleteHandler(args[1],args[2]);
               break;
            }
         }
      }
      
      public function get enabled() : Boolean
      {
         return _enabled;
      }
      
      public function set enabled(val:Boolean) : void
      {
         if(_enabled != val && !_self.notHasFairBattleSkill)
         {
            changeEnabled(val);
         }
      }
      
      private function changeEnabled(val:Boolean) : void
      {
         _enabled = val;
         var _loc4_:int = 0;
         var _loc3_:* = _cellList;
         for each(var cell in _cellList)
         {
            cell.enabled = _enabled;
         }
         if(_enabled)
         {
            filters = null;
            updatePropByEnergy();
         }
         else
         {
            filters = [new ColorMatrixFilter([0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0])];
         }
      }
      
      private function __energyChange(event:LivingEvent) : void
      {
         if(_enabled)
         {
            updatePropByEnergy();
         }
      }
      
      private function updatePropByEnergy() : void
      {
         var info:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _cellList;
         for each(var cell in _cellList)
         {
            if(cell.skillInfo)
            {
               info = cell.skillInfo;
               if(info)
               {
                  if(_self.energy < info.CostEnergy)
                  {
                     cell.enabled = false;
                  }
                  else
                  {
                     cell.enabled = true;
                  }
               }
            }
         }
      }
      
      private function __notUseBattleSkill(evtent:LivingEvent) : void
      {
         lockState = !_self.notHasFairBattleSkill;
         enabled = !_self.notHasFairBattleSkill;
      }
      
      private function __enabledChanged(event:LivingEvent) : void
      {
         enabled = _turnEnabled && _self.propEnabled && _self.customPropEnabled;
      }
      
      private function __customEnabledChanged(evt:LivingEvent) : void
      {
         enabled = _turnEnabled && _self.customPropEnabled;
      }
      
      private function __usingSpecialKill(event:LivingEvent) : void
      {
         var info:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = _cellList;
         for each(var cell in _cellList)
         {
            info = cell.skillInfo;
            if(info && info.BallType == 1)
            {
               cell.isCanUse2 = false;
            }
         }
      }
      
      private function __onUseItem(event:LivingEvent) : void
      {
         __usingSpecialKill(null);
      }
      
      private function skillInfoInit(event:Event) : void
      {
         var len:int = 0;
         var i:int = 0;
         var info:* = null;
         var infoList:Array = GameControl.Instance.horseSkillList;
         if(infoList)
         {
            len = infoList.length;
            while(i < len)
            {
               var _loc8_:int = 0;
               var _loc7_:* = _cellList;
               for each(var cell in _cellList)
               {
                  info = cell.skillInfo;
                  if(info && info.ID == infoList[i].id)
                  {
                     cell.setColdCount(infoList[i].cd,infoList[i].count);
                     break;
                  }
               }
               i++;
            }
            GameControl.Instance.horseSkillList = null;
         }
      }
      
      public function enter() : void
      {
         enabled = _turnEnabled && _self.propEnabled && _self.customPropEnabled;
      }
      
      public function leaving() : void
      {
      }
      
      private function removeEvent() : void
      {
         var i:int = 0;
         _self.removeEventListener("horseSkillUse",useSkillHandler);
         _self.removeEventListener("attackingChanged",onAttackingChange);
         SocketManager.Instance.removeEventListener("roundOneEnd",__onRoundOneEnd);
         _self.removeEventListener("customenabledChanged",__customEnabledChanged);
         _self.removeEventListener("energyChanged",__energyChange);
         _self.removeEventListener("propenabledChanged",__enabledChanged);
         _self.removeEventListener("usingSpecialSkill",__usingSpecialKill);
         _self.removeEventListener("usingItem",__onUseItem);
         GameControl.Instance.removeEventListener("skillInfoInitGame",skillInfoInit);
         KeyboardManager.getInstance().removeEventListener("keyDown",__keyDown);
         for(i = 0; i <= _cellList.length - 1; )
         {
            _cellList[i].removeEventListener("cell_clicked",__horseGameSkillCellClicked);
            i++;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _cellList = null;
         _self = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
