package church.view.weddingRoom.frame
{
   import church.ChurchManager;
   import church.controller.ChurchRoomController;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class WeddingRoomContinuationView extends BaseAlerFrame
   {
      
      private static var _roomMoney:Array = ServerConfigManager.instance.findInfoByName("MarryRoomCreateMoney").Value.split(",");
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _controller:ChurchRoomController;
      
      private var _alertInfo:AlertInfo;
      
      private var _roomContinuationTime1SelectedBtn:SelectedButton;
      
      private var _roomContinuationTime2SelectedBtn:SelectedButton;
      
      private var _roomContinuationTime3SelectedBtn:SelectedButton;
      
      private var _roomContinuationTimeGroup:SelectedButtonGroup;
      
      private var _alert:BaseAlerFrame;
      
      public function WeddingRoomContinuationView()
      {
         super();
         initialize();
      }
      
      public function get controller() : ChurchRoomController
      {
         return _controller;
      }
      
      public function set controller(value:ChurchRoomController) : void
      {
         _controller = value;
      }
      
      protected function initialize() : void
      {
         setView();
         setEvent();
      }
      
      private function setView() : void
      {
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         _alertInfo = new AlertInfo("",LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
         _alertInfo.moveEnable = false;
         _alertInfo.title = LanguageMgr.GetTranslation("church.room.WeddingRoomContinuationView.title");
         info = _alertInfo;
         this.escEnable = true;
         _bg = ComponentFactory.Instance.creatComponentByStylename("church.room.continuationRoomFrameBgAsset");
         addToContent(_bg);
         _roomContinuationTime1SelectedBtn = ComponentFactory.Instance.creat("asset.church.roomContinuationTime1SelectedBtn");
         addToContent(_roomContinuationTime1SelectedBtn);
         _roomContinuationTime2SelectedBtn = ComponentFactory.Instance.creat("asset.church.roomContinuationTime2SelectedBtn");
         addToContent(_roomContinuationTime2SelectedBtn);
         _roomContinuationTime3SelectedBtn = ComponentFactory.Instance.creat("asset.church.roomContinuationTime3SelectedBtn");
         addToContent(_roomContinuationTime3SelectedBtn);
         _roomContinuationTimeGroup = new SelectedButtonGroup(false);
         _roomContinuationTimeGroup.addSelectItem(_roomContinuationTime1SelectedBtn);
         _roomContinuationTimeGroup.addSelectItem(_roomContinuationTime2SelectedBtn);
         _roomContinuationTimeGroup.addSelectItem(_roomContinuationTime3SelectedBtn);
         _roomContinuationTimeGroup.selectIndex = 0;
      }
      
      private function setEvent() : void
      {
         addEventListener("response",onFrameResponse);
         _roomContinuationTime1SelectedBtn.addEventListener("click",onBtnClick);
         _roomContinuationTime2SelectedBtn.addEventListener("click",onBtnClick);
         _roomContinuationTime3SelectedBtn.addEventListener("click",onBtnClick);
      }
      
      private function onBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function onFrameResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
            case 3:
            case 4:
               confirmSubmit();
         }
      }
      
      private function confirmSubmit() : void
      {
         if(checkMoney() && ChurchManager.instance.currentRoom)
         {
            _controller.roomContinuation(_roomContinuationTimeGroup.selectIndex + 2);
         }
         dispose();
      }
      
      private function checkMoney() : Boolean
      {
         var temp:Array = _roomMoney;
         if(PlayerManager.Instance.Self.Money < temp[_roomContinuationTimeGroup.selectIndex])
         {
            LeavePageManager.showFillFrame();
            dispose();
            return false;
         }
         return true;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      private function removeView() : void
      {
         _alertInfo = null;
         if(_alert)
         {
            if(_alert.parent)
            {
               _alert.parent.removeChild(_alert);
            }
            _alert.dispose();
         }
         _alert = null;
         if(_bg)
         {
            if(_bg.parent)
            {
               _bg.parent.removeChild(_bg);
            }
         }
         _bg = null;
         if(_roomContinuationTime1SelectedBtn)
         {
            if(_roomContinuationTime1SelectedBtn.parent)
            {
               _roomContinuationTime1SelectedBtn.parent.removeChild(_roomContinuationTime1SelectedBtn);
            }
            _roomContinuationTime1SelectedBtn.dispose();
         }
         _roomContinuationTime1SelectedBtn = null;
         if(_roomContinuationTime2SelectedBtn)
         {
            if(_roomContinuationTime2SelectedBtn.parent)
            {
               _roomContinuationTime2SelectedBtn.parent.removeChild(_roomContinuationTime2SelectedBtn);
            }
            _roomContinuationTime2SelectedBtn.dispose();
         }
         _roomContinuationTime2SelectedBtn = null;
         if(_roomContinuationTime3SelectedBtn)
         {
            if(_roomContinuationTime3SelectedBtn.parent)
            {
               _roomContinuationTime3SelectedBtn.parent.removeChild(_roomContinuationTime3SelectedBtn);
            }
            _roomContinuationTime3SelectedBtn.dispose();
         }
         _roomContinuationTime3SelectedBtn = null;
         if(_roomContinuationTimeGroup)
         {
            _roomContinuationTimeGroup.dispose();
         }
         _roomContinuationTimeGroup = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         dispatchEvent(new Event("close"));
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",onFrameResponse);
         if(_roomContinuationTime1SelectedBtn)
         {
            _roomContinuationTime1SelectedBtn.removeEventListener("click",onBtnClick);
         }
         if(_roomContinuationTime2SelectedBtn)
         {
            _roomContinuationTime2SelectedBtn.removeEventListener("click",onBtnClick);
         }
         if(_roomContinuationTime3SelectedBtn)
         {
            _roomContinuationTime3SelectedBtn.removeEventListener("click",onBtnClick);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         removeView();
      }
   }
}
