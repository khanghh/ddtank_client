package church.view.weddingRoom.frame
{
   import church.ChurchManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   
   public class WeddingRoomGiftFrameView extends BaseAlerFrame
   {
      
      private static const LEAST_GIFT_MONEY:int = 200;
       
      
      private var _bg:Bitmap;
      
      private var _alertInfo:AlertInfo;
      
      private var _txtMoney:FilterFrameText;
      
      private var _contentText:FilterFrameText;
      
      private var _noticeText:FilterFrameText;
      
      public function WeddingRoomGiftFrameView(){super();}
      
      protected function initialize() : void{}
      
      private function setView() : void{}
      
      public function set txtMoney(param1:String) : void{}
      
      private function setEvent() : void{}
      
      private function checkMoney() : void{}
      
      private function onFrameResponse(param1:FrameEvent) : void{}
      
      public function show() : void{}
      
      private function removeView() : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
