package church.view.weddingRoomList.frame
{
   import church.controller.ChurchRoomListController;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.data.ChurchRoomInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class WeddingRoomEnterConfirmView extends BaseAlerFrame
   {
       
      
      private var _controller:ChurchRoomListController;
      
      private var _churchRoomInfo:ChurchRoomInfo;
      
      private var _bg:Scale9CornerImage;
      
      private var _bmpRoomName:FilterFrameText;
      
      private var _bmpGroom:FilterFrameText;
      
      private var _bmpBride:FilterFrameText;
      
      private var _bmpCount:FilterFrameText;
      
      private var _flower:Bitmap;
      
      private var _bmpSpareTime:FilterFrameText;
      
      private var _bmpLineBox:ScaleBitmapImage;
      
      private var _bmpDescription:FilterFrameText;
      
      private var _bmpLine1:Bitmap;
      
      private var _imgLine:MutipleImage;
      
      private var _imgLine3:Image;
      
      private var _imgLine4:Image;
      
      private var _imgLine5:Image;
      
      private var _roomNameText:FilterFrameText;
      
      private var _groomText:FilterFrameText;
      
      private var _grideText:FilterFrameText;
      
      private var _countText:FilterFrameText;
      
      private var _spareTime:FilterFrameText;
      
      private var _alertInfo:AlertInfo;
      
      private var _txtDescription:TextArea;
      
      private var _textDescriptionBg:Sprite;
      
      private var _weddingRoomEnterInputPasswordView:WeddingRoomEnterInputPasswordView;
      
      private var _titleTxt:FilterFrameText;
      
      public function WeddingRoomEnterConfirmView(){super();}
      
      protected function initialize() : void{}
      
      public function set controller(param1:ChurchRoomListController) : void{}
      
      public function set churchRoomInfo(param1:ChurchRoomInfo) : void{}
      
      private function setView() : void{}
      
      private function setEvent() : void{}
      
      private function onFrameResponse(param1:FrameEvent) : void{}
      
      private function enterRoomConfirm() : void{}
      
      public function show() : void{}
      
      private function removeEvent() : void{}
      
      private function removeView() : void{}
      
      override public function dispose() : void{}
   }
}
