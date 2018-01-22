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
      
      public function HorseGameSkillBar(param1:LocalPlayer){super();}
      
      private function initView() : void{}
      
      private function get curUseSkillList() : DictionaryData{return null;}
      
      private function initEvent() : void{}
      
      protected function __horseGameSkillCellClicked(param1:Event) : void{}
      
      private function __keyDown(param1:KeyboardEvent) : void{}
      
      public function set lockState(param1:Boolean) : void{}
      
      protected function __onRoundOneEnd(param1:CrazyTankSocketEvent) : void{}
      
      private function onAttackingChange(param1:LivingEvent) : void{}
      
      private function useSkillHandler(param1:LivingEvent) : void{}
      
      public function get enabled() : Boolean{return false;}
      
      public function set enabled(param1:Boolean) : void{}
      
      private function changeEnabled(param1:Boolean) : void{}
      
      private function __energyChange(param1:LivingEvent) : void{}
      
      private function updatePropByEnergy() : void{}
      
      private function __notUseBattleSkill(param1:LivingEvent) : void{}
      
      private function __enabledChanged(param1:LivingEvent) : void{}
      
      private function __customEnabledChanged(param1:LivingEvent) : void{}
      
      private function __usingSpecialKill(param1:LivingEvent) : void{}
      
      private function __onUseItem(param1:LivingEvent) : void{}
      
      private function skillInfoInit(param1:Event) : void{}
      
      public function enter() : void{}
      
      public function leaving() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
