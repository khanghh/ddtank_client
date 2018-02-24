package catchInsect.componets
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class RoomMenuView extends Sprite implements Disposeable
   {
       
      
      private var _menuIsOpen:Boolean = true;
      
      private var _BG:Bitmap;
      
      private var _closeBtn:SimpleBitmapButton;
      
      private var _switchIMG:ScaleFrameImage;
      
      private var _returnBtn:SimpleBitmapButton;
      
      private var _backAlertFrame:BaseAlerFrame;
      
      public function RoomMenuView(){super();}
      
      private function initialize() : void{}
      
      private function setEvent() : void{}
      
      private function backRoomList(param1:MouseEvent) : void{}
      
      private function __frameResponse(param1:FrameEvent) : void{}
      
      private function switchMenu(param1:MouseEvent) : void{}
      
      private function menuShowOrHide(param1:Event) : void{}
      
      public function dispose() : void{}
   }
}
