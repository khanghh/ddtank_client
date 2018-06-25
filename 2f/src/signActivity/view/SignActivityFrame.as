package signActivity.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.utils.Dictionary;   import signActivity.SignActivityMgr;   import wonderfulActivity.WonderfulActivityManager;   import wonderfulActivity.data.GmActivityInfo;      public class SignActivityFrame extends Frame   {                   private var _bg:Bitmap;            private var _day:int;            private var _giftbagArray:Array;            private var _activeTimeTxt:FilterFrameText;            private var _helpTxt:FilterFrameText;            private var _itemList:Vector.<SignActivityItem>;            private var actId:String;            private var _xmlData:GmActivityInfo;            private var _giftInfoDic:Dictionary;            private var _statusArr:Array;            public function SignActivityFrame($day:int) { super(); }
            private function initView() : void { }
            private function initData() : void { }
            private function initGoods() : void { }
            public function refresh() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __responseHandler(evt:FrameEvent) : void { }
            override public function dispose() : void { }
   }}