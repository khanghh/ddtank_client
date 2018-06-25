package condiscount.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import condiscount.CondiscountManager;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import ddt.utils.HelpFrameUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import wonderfulActivity.WonderfulActivityManager;   import wonderfulActivity.data.GiftBagInfo;   import wonderfulActivity.event.WonderfulActivityEvent;      public class CondiscountFrame extends Frame   {                   private var _timeTxt:FilterFrameText;            private var _2dis:Bitmap;            private var _3dis:Bitmap;            private var _4dis:Bitmap;            private var _5dis:Bitmap;            private var itemList:Array;            private var box:Sprite;            private var _helpBtn:BaseButton;            public function CondiscountFrame() { super(); }
            private function initView() : void { }
            private function setItemData() : void { }
            private function removeEvent() : void { }
            private function addEvent() : void { }
            private function refreshActivity(event:WonderfulActivityEvent = null) : void { }
            protected function _responseHandle(event:FrameEvent) : void { }
            override public function dispose() : void { }
   }}