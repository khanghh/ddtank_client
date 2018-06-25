package gameCommon.view.prop{   import battleSkill.BattleSkillManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.LivingEvent;   import ddt.manager.SocketManager;   import ddt.utils.PositionUtils;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.KeyboardEvent;   import flash.filters.ColorMatrixFilter;   import gameCommon.GameControl;   import gameCommon.model.LocalPlayer;   import horse.HorseManager;   import horse.data.HorseSkillVo;   import org.aswing.KeyStroke;   import org.aswing.KeyboardManager;   import road7th.data.DictionaryData;      public class HorseGameSkillBar extends Sprite implements Disposeable   {                   private var _cellList:Vector.<HorseGameSkillCell>;            private var _self:LocalPlayer;            private var _enabled:Boolean = true;            private var _turnEnabled:Boolean = true;            private var _horseSkillLockStatus:Boolean;            public function HorseGameSkillBar(self:LocalPlayer) { super(); }
            private function initView() : void { }
            private function get curUseSkillList() : DictionaryData { return null; }
            private function initEvent() : void { }
            protected function __horseGameSkillCellClicked(event:Event) : void { }
            private function __keyDown(event:KeyboardEvent) : void { }
            public function set lockState(value:Boolean) : void { }
            protected function __onRoundOneEnd(event:CrazyTankSocketEvent) : void { }
            private function onAttackingChange(event:LivingEvent) : void { }
            private function useSkillHandler(event:LivingEvent) : void { }
            public function get enabled() : Boolean { return false; }
            public function set enabled(val:Boolean) : void { }
            private function changeEnabled(val:Boolean) : void { }
            private function __energyChange(event:LivingEvent) : void { }
            private function updatePropByEnergy() : void { }
            private function __notUseBattleSkill(evtent:LivingEvent) : void { }
            private function __enabledChanged(event:LivingEvent) : void { }
            private function __customEnabledChanged(evt:LivingEvent) : void { }
            private function __usingSpecialKill(event:LivingEvent) : void { }
            private function __onUseItem(event:LivingEvent) : void { }
            private function skillInfoInit(event:Event) : void { }
            public function enter() : void { }
            public function leaving() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}