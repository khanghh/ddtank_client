package littleGame{   import com.pickgliss.manager.CacheSysManager;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.ChatManager;   import ddt.manager.KeyboardShortcutsManager;   import ddt.manager.PlayerManager;   import ddt.manager.SharedManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.states.BaseStateView;   import ddt.view.chat.ChatView;   import flash.display.DisplayObject;   import flash.events.Event;   import flash.events.MouseEvent;   import invite.InviteManager;   import littleGame.events.LittleGameSocketEvent;   import littleGame.menu.LittleMenuBar;   import littleGame.model.LittleLiving;   import littleGame.model.Scenario;   import littleGame.view.GameScene;   import littleGame.view.LittleScoreBar;   import littleGame.view.LittleSoundButton;      public class LittleGame extends BaseStateView   {                   private var _scene:GameScene;            private var _game:Scenario;            private var _chatField:ChatView;            private var _menu:LittleMenuBar;            private var _scoreBar:LittleScoreBar;            private var _soundButton:LittleSoundButton;            private var _inhaleNote:DisplayObject;            public function LittleGame() { super(); }
            private function configUI() : void { }
            private function addEvent() : void { }
            private function __kickPlaye(event:LittleGameSocketEvent) : void { }
            private function __invokeObject(event:LittleGameSocketEvent) : void { }
            private function __soundClick(event:MouseEvent) : void { }
            private function __inhaledChanged(event:Event) : void { }
            private function __netDelay(event:LittleGameSocketEvent) : void { }
            private function __pong(event:LittleGameSocketEvent) : void { }
            private function __setClock(event:LittleGameSocketEvent) : void { }
            private function __selfGetScore(event:LittleGameSocketEvent) : void { }
            private function __doAction(event:LittleGameSocketEvent) : void { }
            private function __doMovie(event:LittleGameSocketEvent) : void { }
            private function __removeObject(event:LittleGameSocketEvent) : void { }
            private function __addObject(event:LittleGameSocketEvent) : void { }
            private function __updateLivingProperty(event:LittleGameSocketEvent) : void { }
            private function __updatePos(event:LittleGameSocketEvent) : void { }
            private function __livingMove(event:LittleGameSocketEvent) : void { }
            private function __addSprite(event:LittleGameSocketEvent) : void { }
            private function __removeSprite(event:LittleGameSocketEvent) : void { }
            private function removeEvent() : void { }
            override public function enter(prev:BaseStateView, data:Object = null) : void { }
            override public function getType() : String { return null; }
            override public function leaving(next:BaseStateView) : void { }
   }}