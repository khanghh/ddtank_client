package church.view.weddingRoomList.frame
{
   import bagAndInfo.cell.BaseCell;
   import church.controller.ChurchRoomListController;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.ChurchRoomInfo;
   import ddt.manager.BossBoxManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class HighClassWeddingFrame extends BaseAlerFrame
   {
       
      
      private var _controller:ChurchRoomListController;
      
      private var _alertInfo:AlertInfo;
      
      private var _flower:Bitmap;
      
      private var _bgLeftTop:ScaleBitmapImage;
      
      private var _bgLeftBottom:ScaleBitmapImage;
      
      private var _roomCreateRoomNameTitle:Bitmap;
      
      private var _churchKeepsake:Bitmap;
      
      private var _txtCreateRoomName:FilterFrameText;
      
      private var _bg1:ScaleBitmapImage;
      
      private var _chkCreateRoomPassword:SelectedIconButton;
      
      private var _chkCreateRoomIsGuest:SelectedIconButton;
      
      private var _selectedIconButtonTxt1:FilterFrameText;
      
      private var _selectedIconButtonTxt2:FilterFrameText;
      
      private var _txtCreateRoomPassword:TextInput;
      
      private var _bgRight:Bitmap;
      
      private var _weddingBigBtn:SelectedButton;
      
      private var _weddingMidBtn:SelectedButton;
      
      private var _weddingSmallBtn:SelectedButton;
      
      private var _descTxt:FilterFrameText;
      
      private var _hbox:HBox;
      
      private var _sizeSelectGroup:SelectedButtonGroup;
      
      private var _cellHBox:HBox;
      
      private var _cells:Array;
      
      private var _isSaleWedding:Boolean;
      
      private var _WeddingMoney:String;
      
      private var _WdddingMoneyArr:Array;
      
      private var _weddingSmalllMoneyTxt:FilterFrameText;
      
      private var _weddingMidMoneyTxt:FilterFrameText;
      
      private var _weddingBigMoneyTxt:FilterFrameText;
      
      public function HighClassWeddingFrame(){super();}
      
      public function setController(param1:ChurchRoomListController) : void{}
      
      public function initView() : void{}
      
      public function get isSaleWedding() : Boolean{return false;}
      
      public function set isSaleWedding(param1:Boolean) : void{}
      
      private function addEvents() : void{}
      
      private function onIsGuest1(param1:MouseEvent) : void{}
      
      private function onIsGuest2(param1:MouseEvent) : void{}
      
      private function onIsGuest3(param1:MouseEvent) : void{}
      
      protected function __changeHandler(param1:Event) : void{}
      
      private function updateReward() : void{}
      
      private function onIsGuest(param1:MouseEvent) : void{}
      
      private function onRoomPasswordCheck(param1:MouseEvent) : void{}
      
      private function onFrameResponse(param1:FrameEvent) : void{}
      
      private function createRoomConfirm() : void{}
      
      private function checkRoom() : Boolean{return false;}
      
      private function removeEvents() : void{}
      
      override public function dispose() : void{}
      
      public function get WeddingMoney() : String{return null;}
      
      public function set WeddingMoney(param1:String) : void{}
   }
}
