package guardCore.view{   import baglocked.BaglockedManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ComponentSetting;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.utils.getTimer;   import guardCore.GuardCoreManager;   import guardCore.data.GuardCoreInfo;      public class GuardCoreItem extends Sprite implements Disposeable   {                   private var _icon:Bitmap;            private var _guardBtn:TextButton;            private var _info:GuardCoreInfo;            private var _type:int;            private var _tips:Component;            private var _frameFilter:Array;            private var _clickTime:int;            public function GuardCoreItem(type:int) { super(); }
            private function init() : void { }
            public function updateTipsData() : void { }
            private function updateView() : void { }
            private function __onGuardBtn(e:MouseEvent) : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}