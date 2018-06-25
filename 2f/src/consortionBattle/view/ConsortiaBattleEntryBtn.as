package consortionBattle.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import consortionBattle.ConsortiaBattleManager;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddtBuried.BuriedManager;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;      public class ConsortiaBattleEntryBtn extends Sprite implements Disposeable   {                   private var _btn:MovieClip;            private var _isOpen:Boolean;            public function ConsortiaBattleEntryBtn() { super(); }
            public function setEnble(bool:Boolean) : void { }
            private function initThis() : void { }
            private function playAllMc($mc:MovieClip) : void { }
            private function stopAllMc($mc:MovieClip) : void { }
            private function clickhandler(event:MouseEvent) : void { }
            private function resLoadComplete(event:Event) : void { }
            private function closeHandler(event:Event) : void { }
            private function closeDispose() : void { }
            public function dispose() : void { }
   }}