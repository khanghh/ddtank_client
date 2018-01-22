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
      
      public function HorseGameSkillBar(param1:LocalPlayer)
      {
         super();
         _self = param1;
         initView();
         initEvent();
         skillInfoInit(null);
      }
      
      private function initView() : void
      {
         _cellList = new Vector.<HorseGameSkillCell>();
         var _loc3_:DictionaryData = curUseSkillList;
         var _loc1_:HorseGameSkillCell = new HorseGameSkillCell(!!_loc3_.hasKey("1")?_loc3_["1"]:-1,"z",_self);
         var _loc2_:HorseGameSkillCell = new HorseGameSkillCell(!!_loc3_.hasKey("2")?_loc3_["2"]:-1,"x",_self);
         var _loc4_:HorseGameSkillCell = new HorseGameSkillCell(!!_loc3_.hasKey("3")?_loc3_["3"]:-1,"c",_self);
         PositionUtils.setPos(_loc1_,"CustomPropCellPosz");
         PositionUtils.setPos(_loc2_,"CustomPropCellPosx");
         PositionUtils.setPos(_loc4_,"CustomPropCellPosc");
         addChild(_loc1_);
         addChild(_loc2_);
         addChild(_loc4_);
         _cellList.push(_loc1_);
         _cellList.push(_loc2_);
         _cellList.push(_loc4_);
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
         var _loc1_:int = 0;
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
         _loc1_ = 0;
         while(_loc1_ <= _cellList.length - 1)
         {
            _cellList[_loc1_].addEventListener("cell_clicked",__horseGameSkillCellClicked);
            _loc1_++;
         }
         _horseSkillLockStatus = true;
      }
      
      protected function __horseGameSkillCellClicked(param1:Event) : void
      {
         _turnEnabled = false;
         enabled = false;
      }
      
      private function __keyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:int = -1;
         var _loc3_:* = param1.keyCode;
         if(KeyStroke.VK_Z.getCode() !== _loc3_)
         {
            if(KeyStroke.VK_X.getCode() !== _loc3_)
            {
               if(KeyStroke.VK_C.getCode() === _loc3_)
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
         if(_loc2_ >= 0)
         {
            _cellList[_loc2_].useSkill();
         }
      }
      
      public function set lockState(param1:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:* = param1;
         if(true !== _loc4_)
         {
            if(false === _loc4_)
            {
               _horseSkillLockStatus = false;
               KeyboardManager.getInstance().removeEventListener("keyDown",__keyDown);
               _loc2_ = 0;
               while(_loc2_ <= _cellList.length - 1)
               {
                  _cellList[_loc2_].removeEventListener("cell_clicked",__horseGameSkillCellClicked);
                  _loc2_++;
               }
            }
         }
         else if(_horseSkillLockStatus == false)
         {
            _horseSkillLockStatus = true;
            KeyboardManager.getInstance().addEventListener("keyDown",__keyDown);
            _loc3_ = 0;
            while(_loc3_ <= _cellList.length - 1)
            {
               _cellList[_loc3_].addEventListener("cell_clicked",__horseGameSkillCellClicked);
               _loc3_++;
            }
         }
      }
      
      protected function __onRoundOneEnd(param1:CrazyTankSocketEvent) : void
      {
         _turnEnabled = true;
         enabled = _turnEnabled && _self.propEnabled && _self.customPropEnabled;
         var _loc4_:int = 0;
         var _loc3_:* = _cellList;
         for each(var _loc2_ in _cellList)
         {
            _loc2_.roundOneEndHandler();
         }
      }
      
      private function onAttackingChange(param1:LivingEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _cellList;
         for each(var _loc2_ in _cellList)
         {
            _loc2_.attackChangeHandler(_self.isAttacking);
         }
      }
      
      private function useSkillHandler(param1:LivingEvent) : void
      {
         var _loc2_:Array = param1.paras;
         var _loc5_:int = 0;
         var _loc4_:* = _cellList;
         for each(var _loc3_ in _cellList)
         {
            if(_loc3_.skillId == _loc2_[0])
            {
               _loc3_.useCompleteHandler(_loc2_[1],_loc2_[2]);
               break;
            }
         }
      }
      
      public function get enabled() : Boolean
      {
         return _enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         if(_enabled != param1 && !_self.notHasFairBattleSkill)
         {
            changeEnabled(param1);
         }
      }
      
      private function changeEnabled(param1:Boolean) : void
      {
         _enabled = param1;
         var _loc4_:int = 0;
         var _loc3_:* = _cellList;
         for each(var _loc2_ in _cellList)
         {
            _loc2_.enabled = _enabled;
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
      
      private function __energyChange(param1:LivingEvent) : void
      {
         if(_enabled)
         {
            updatePropByEnergy();
         }
      }
      
      private function updatePropByEnergy() : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _cellList;
         for each(var _loc1_ in _cellList)
         {
            if(_loc1_.skillInfo)
            {
               _loc2_ = _loc1_.skillInfo;
               if(_loc2_)
               {
                  if(_self.energy < _loc2_.CostEnergy)
                  {
                     _loc1_.enabled = false;
                  }
                  else
                  {
                     _loc1_.enabled = true;
                  }
               }
            }
         }
      }
      
      private function __notUseBattleSkill(param1:LivingEvent) : void
      {
         lockState = !_self.notHasFairBattleSkill;
         enabled = !_self.notHasFairBattleSkill;
      }
      
      private function __enabledChanged(param1:LivingEvent) : void
      {
         enabled = _turnEnabled && _self.propEnabled && _self.customPropEnabled;
      }
      
      private function __customEnabledChanged(param1:LivingEvent) : void
      {
         enabled = _turnEnabled && _self.customPropEnabled;
      }
      
      private function __usingSpecialKill(param1:LivingEvent) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = _cellList;
         for each(var _loc2_ in _cellList)
         {
            _loc3_ = _loc2_.skillInfo;
            if(_loc3_ && _loc3_.BallType == 1)
            {
               _loc2_.isCanUse2 = false;
            }
         }
      }
      
      private function __onUseItem(param1:LivingEvent) : void
      {
         __usingSpecialKill(null);
      }
      
      private function skillInfoInit(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc2_:Array = GameControl.Instance.horseSkillList;
         if(_loc2_)
         {
            _loc4_ = _loc2_.length;
            while(_loc6_ < _loc4_)
            {
               var _loc8_:int = 0;
               var _loc7_:* = _cellList;
               for each(var _loc3_ in _cellList)
               {
                  _loc5_ = _loc3_.skillInfo;
                  if(_loc5_ && _loc5_.ID == _loc2_[_loc6_].id)
                  {
                     _loc3_.setColdCount(_loc2_[_loc6_].cd,_loc2_[_loc6_].count);
                     break;
                  }
               }
               _loc6_++;
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
         var _loc1_:int = 0;
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
         _loc1_ = 0;
         while(_loc1_ <= _cellList.length - 1)
         {
            _cellList[_loc1_].removeEventListener("cell_clicked",__horseGameSkillCellClicked);
            _loc1_++;
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
