package church.view.weddingRoom.frame{   import church.ChurchManager;   import church.controller.ChurchRoomController;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.vo.AlertInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SoundManager;   import flash.events.Event;   import flash.events.MouseEvent;      public class WeddingRoomContinuationView extends BaseAlerFrame   {            private static var _roomMoney:Array = ServerConfigManager.instance.findInfoByName("MarryRoomCreateMoney").Value.split(",");                   private var _bg:ScaleBitmapImage;            private var _controller:ChurchRoomController;            private var _alertInfo:AlertInfo;            private var _roomContinuationTime1SelectedBtn:SelectedButton;            private var _roomContinuationTime2SelectedBtn:SelectedButton;            private var _roomContinuationTime3SelectedBtn:SelectedButton;            private var _roomContinuationTimeGroup:SelectedButtonGroup;            private var _alert:BaseAlerFrame;            public function WeddingRoomContinuationView() { super(); }
            public function get controller() : ChurchRoomController { return null; }
            public function set controller(value:ChurchRoomController) : void { }
            protected function initialize() : void { }
            private function setView() : void { }
            private function setEvent() : void { }
            private function onBtnClick(event:MouseEvent) : void { }
            private function onFrameResponse(evt:FrameEvent) : void { }
            private function confirmSubmit() : void { }
            private function checkMoney() : Boolean { return false; }
            public function show() : void { }
            private function removeView() : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}