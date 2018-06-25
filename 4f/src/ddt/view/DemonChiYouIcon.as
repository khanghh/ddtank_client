package ddt.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import demonChiYou.DemonChiYouManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.utils.getTimer;      public class DemonChiYouIcon extends Sprite implements Disposeable   {                   private var _activityIcon:Bitmap;            private var _lastClickTime:int = 0;            public function DemonChiYouIcon() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            protected function enterBossSence(event:MouseEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}