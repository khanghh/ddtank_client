package gameCommon.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.UICreatShortcut;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.GameEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SharedManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.text.TextField;   import gameCommon.GameControl;   import room.RoomManager;      public class GameTrusteeshipView extends Sprite implements Disposeable   {                   private var _trusteeshipBtn:SelectedButton;            private var _trusteeshipMovie:MovieClip;            private var _cancelText:TextField;            private var _trusteeshipState:Boolean;            public function GameTrusteeshipView() { super(); }
            private function init() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            protected function __die(event:Event) : void { }
            protected function __transparentChanged(event:Event) : void { }
            protected function __onTrusteeshipBtnClick(event:Event) : void { }
            public function set trusteeshipState(value:Boolean) : void { }
            public function get trusteeshipState() : Boolean { return false; }
            private function update() : void { }
            private function __trusteeshipChange(event:GameEvent) : void { }
            public function dispose() : void { }
   }}