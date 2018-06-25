package church.view.weddingRoomList.frame{   import baglocked.BaglockedManager;   import church.controller.ChurchRoomListController;   import church.view.ChurchPresentFrame;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.command.QuickBuyFrame;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.FilterWordManager;   import flash.display.Bitmap;   import flash.events.MouseEvent;      public class WeddingUnmarryView extends BaseAlerFrame   {                   private var _controller:ChurchRoomListController;            private var _alertInfo:AlertInfo;            private var _text1:FilterFrameText;            private var _text2:FilterFrameText;            private var _text3:FilterFrameText;            private var _bg:Bitmap;            private var _titleBg:Bitmap;            private var _needMoney:int;            private var _textBG:ScaleBitmapImage;            private var _textI:FilterFrameText;            private var _textII:FilterFrameText;            private var _otherPayBtn:TextButton;            private var _friendInfo:Object;            private var giveFriendOpenFrame:ChurchPresentFrame;            public function WeddingUnmarryView() { super(); }
            public function set controller(value:ChurchRoomListController) : void { }
            protected function initialize() : void { }
            private function setView() : void { }
            public function setText(str1:String = "", str2:String = "", haveDivorce:Boolean = false) : void { }
            private function removeView() : void { }
            private function setEvent() : void { }
            private function mouseClickHander(e:MouseEvent) : void { }
            private function responseHandler2(event:FrameEvent) : void { }
            private function removeEvent() : void { }
            private function presentBtnClick(event:MouseEvent) : void { }
            private function onFrameResponse(evt:FrameEvent) : void { }
            private function confirmSubmit() : void { }
            private function _responseV(evt:FrameEvent) : void { }
            public function show(needMoney:int) : void { }
            override public function dispose() : void { }
   }}