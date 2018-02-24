package church.view.weddingRoom.frame
{
   import church.controller.ChurchRoomController;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   
   public class WeddingRoomGiftFrameForGuest extends BaseAlerFrame
   {
      
      public static const RESTRICT:String = "0-9";
      
      public static const DEFAULT:String = "100";
      
      private static const LEAST_MONEY:int = 100;
       
      
      private var _controller:ChurchRoomController;
      
      private var _bg:Bitmap;
      
      private var _alertInfo:AlertInfo;
      
      private var _txtMoney:FilterFrameText;
      
      private var _alertConfirm:BaseAlerFrame;
      
      private var _contentText:FilterFrameText;
      
      private var _money:FilterFrameText;
      
      private var _noticeText:FilterFrameText;
      
      private var _inputBG:Scale9CornerImage;
      
      public function WeddingRoomGiftFrameForGuest(){super();}
      
      public function get controller() : ChurchRoomController{return null;}
      
      public function set controller(param1:ChurchRoomController) : void{}
      
      protected function initialize() : void{}
      
      private function setView() : void{}
      
      private function setEvent() : void{}
      
      private function __keyDown(param1:KeyboardEvent) : void{}
      
      private function __focusOut(param1:FocusEvent) : void{}
      
      private function checkMoney() : void{}
      
      private function onFrameResponse(param1:FrameEvent) : void{}
      
      private function confirmSubmit() : void{}
      
      private function confirm(param1:FrameEvent) : void{}
      
      public function show() : void{}
      
      private function removeView() : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
