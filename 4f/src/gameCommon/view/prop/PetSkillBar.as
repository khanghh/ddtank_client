package gameCommon.view.prop{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.LivingEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.events.Event;   import flash.events.KeyboardEvent;   import flash.events.MouseEvent;   import flash.geom.Point;   import gameCommon.GameControl;   import gameCommon.model.LocalPlayer;   import gameCommon.view.tool.PetEnergyStrip;   import org.aswing.KeyStroke;   import org.aswing.KeyboardManager;   import pet.data.PetSkill;   import petsBag.PetsBagManager;   import road7th.comm.PackageIn;   import room.RoomManager;      public class PetSkillBar extends FightPropBar   {                   private var _skillCells:Vector.<PetSkillCell>;            private var _usedItem:Boolean = false;            private var _usedSpecialSkill:Boolean = false;            private var _usedPetSkill:Boolean = false;            private var _bg:Bitmap;            private var _petEnergyStrip:PetEnergyStrip;            private var _petSkillLockStatus:Boolean;            private var letters:Array;            public function PetSkillBar(self:LocalPlayer) { super(null); }
            override public function enter() : void { }
            override protected function addEvent() : void { }
            public function set lockState(value:Boolean) : void { }
            override protected function removeEvent() : void { }
            override protected function __keyDown(event:KeyboardEvent) : void { }
            private function __onPetSkillUsedFail(pEvent:LivingEvent) : void { }
            private function __onChange(event:LivingEvent) : void { }
            private function skillInfoInit(event:Event) : void { }
            private function __petSkillCD(event:CrazyTankSocketEvent) : void { }
            private function __usingSpecialKill(event:LivingEvent) : void { }
            private function __onUseItem(event:LivingEvent) : void { }
            private function __onUsePetSkill(event:LivingEvent) : void { }
            protected function __onRoundOneEnd(event:CrazyTankSocketEvent) : void { }
            private function __onAttackingChange(event:LivingEvent) : void { }
            private function updateCellEnable() : void { }
            private function onCellClick(event:MouseEvent) : void { }
            override public function dispose() : void { }
            override protected function drawCells() : void { }
   }}