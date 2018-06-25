package gameCommon.view.control{   import com.greensock.TweenLite;   import com.greensock.TweenMax;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.ChatManager;   import ddt.manager.IMManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import ddt.view.chat.ChatFacePanel;   import flash.display.DisplayObject;   import flash.display.DisplayObjectContainer;   import flash.display.MovieClip;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.text.TextField;   import game.GameDecorateManager;   import game.GameManager;   import gameCommon.GameControl;   import gameCommon.model.LocalPlayer;   import gameCommon.view.prop.CustomPropBar;   import gameCommon.view.prop.SoulPropBar;   import gameStarling.view.GameViewBase3D;   import org.aswing.KeyStroke;   import org.aswing.KeyboardManager;      public class SoulState extends ControlState   {                   private var _psychicBar:PsychicBar;            private var _psychicBar3D:PsychicBar3D;            private var _propBar:SoulPropBar;            private var _customPropBar:CustomPropBar;            private var _tweenMax:TweenMax;            private var _msgShape:DisplayObject;            private var _fastChatBtn:SimpleBitmapButton;            private var _faceBtn:SimpleBitmapButton;            private var _fastMovie:MovieClip;            private var _facePanel:ChatFacePanel;            private var _facePanelPos:Point;            private var _gameViewBtn:BaseButton;            private var _freedomViewBtn:BaseButton;            private var _isREleaseFours:Boolean;            public function SoulState(self:LocalPlayer) { super(null); }
            override protected function configUI() : void { }
            private function setTip(btn:BaseButton, data:String) : void { }
            override protected function addEvent() : void { }
            protected function __noMessageHandler(event:Event) : void { }
            protected function __hasNewHandler(event:Event) : void { }
            protected function __onFaceSelect(event:Event) : void { }
            protected function __face(event:MouseEvent) : void { }
            protected function __outHandler(event:MouseEvent) : void { }
            protected function __overHandler(event:MouseEvent) : void { }
            protected function __fastChat(event:MouseEvent) : void { }
            private function __onFrame(evt:Event) : void { }
            override protected function removeEvent() : void { }
            private function __gameViewClickHandler(evt:MouseEvent) : void { }
            private function __freedomViewClickHandler(evt:MouseEvent) : void { }
            private function changeView(isStop:Boolean) : void { }
            override public function enter(container:DisplayObjectContainer) : void { }
            override public function leaving(onComplete:Function = null) : void { }
            override protected function tweenIn() : void { }
            override protected function enterComplete() : void { }
            protected function __mouseUpInStep1(event:MouseEvent) : void { }
            override public function dispose() : void { }
   }}