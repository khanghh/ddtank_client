package gameCommon.view.prop{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.BagInfo;   import ddt.data.EquipType;   import ddt.data.PropInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.player.SelfInfo;   import ddt.events.BagEvent;   import ddt.events.FightPropEevnt;   import ddt.events.LivingEvent;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import entertainmentMode.view.EntertainmentAlertFrame;   import flash.display.DisplayObject;   import flash.events.KeyboardEvent;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.utils.Dictionary;   import gameCommon.GameControl;   import gameCommon.model.LocalPlayer;   import gameCommon.view.control.SoulState;   import org.aswing.KeyStroke;   import org.aswing.KeyboardManager;   import room.RoomManager;      public class CustomPropBar extends FightPropBar   {                   private var _selfInfo:SelfInfo;            private var _type:int;            private var _backStyle:String;            private var _localVisible:Boolean = true;            private var _randomBtn:SimpleBitmapButton;            public function CustomPropBar(self:LocalPlayer, type:int) { super(null); }
            override protected function addEvent() : void { }
            private function __psychicChanged(event:LivingEvent) : void { }
            private function updatePropByPsychic() : void { }
            override protected function __enabledChanged(event:LivingEvent) : void { }
            private function __customEnabledChanged(evt:LivingEvent) : void { }
            private function __deleteProp(event:FightPropEevnt) : void { }
            private function __updateProp(event:BagEvent) : void { }
            private function __clickHandler(e:MouseEvent) : void { }
            private function __responseHandler(evt:FrameEvent) : void { }
            override protected function removeEvent() : void { }
            override protected function drawCells() : void { }
            override protected function __keyDown(event:KeyboardEvent) : void { }
            private function __useProp(event:FightPropEevnt) : void { }
            override public function enter() : void { }
            override public function set enabled(val:Boolean) : void { }
            public function set backStyle(val:String) : void { }
            public function setVisible(val:Boolean) : void { }
   }}