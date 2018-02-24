package catchInsect.view
{
   import catchInsect.CatchInsectControl;
   import catchInsect.CatchInsectManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class CatchInsectChooseFrame extends Frame
   {
       
      
      private var _roomBgImg:ScaleBitmapImage;
      
      private var _entranceImg:Bitmap;
      
      private var _activeTimeTxt:FilterFrameText;
      
      private var _chooseRoomText:FilterFrameText;
      
      private var _gotoForestBtn:BaseButton;
      
      private var _checkGeinBtn:BaseButton;
      
      private var _helpBtn:BaseButton;
      
      private var _bottomBg:ScaleBitmapImage;
      
      private var _clickDate:Number = 0;
      
      public function CatchInsectChooseFrame(){super();}
      
      private function initView() : void{}
      
      private function initText() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __gotoForestBtnClick(param1:MouseEvent) : void{}
      
      private function __checkGeinBtnClick(param1:MouseEvent) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
