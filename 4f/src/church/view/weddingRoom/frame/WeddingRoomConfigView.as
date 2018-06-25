package church.view.weddingRoom.frame{   import church.ChurchManager;   import church.controller.ChurchRoomController;   import church.model.ChurchRoomModel;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.SelectedIconButton;   import com.pickgliss.ui.controls.TextInput;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.text.TextArea;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import com.pickgliss.utils.StringUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SoundManager;   import ddt.utils.FilterWordManager;   import flash.display.Bitmap;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;      public class WeddingRoomConfigView extends BaseAlerFrame   {                   private var _controller:ChurchRoomController;            private var _model:ChurchRoomModel;            private var _alertInfo:AlertInfo;            private var _configRoomFrameTopBg:ScaleBitmapImage;            private var _configRoomFrameBottomBg:Scale9CornerImage;            private var _roomNameTitle:Bitmap;            private var _roomIntroTitle:Bitmap;            private var _txtConfigRoomName:FilterFrameText;            private var _chkConfigRoomPassword:SelectedIconButton;            private var _txtConfigRoomPassword:TextInput;            private var _txtConfigRoomIntro:TextArea;            private var _configIntroMaxChBg:Bitmap;            private var _roomConfigIntroMaxChLabel:FilterFrameText;            private var _bg1:ScaleBitmapImage;            private var _selectedIconButtonTxt:FilterFrameText;            public function WeddingRoomConfigView() { super(); }
            public function get controller() : ChurchRoomController { return null; }
            public function set controller(value:ChurchRoomController) : void { }
            protected function initialize() : void { }
            private function setView() : void { }
            private function setEvent() : void { }
            private function getRoomInfo() : void { }
            private function onFrameResponse(evt:FrameEvent) : void { }
            private function confirmSubmit() : void { }
            private function checkRoom() : Boolean { return false; }
            private function onRoomPasswordCheck(evt:MouseEvent) : void { }
            private function onRemarkChange(e:Event = null) : void { }
            public function show() : void { }
            private function removeView() : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}