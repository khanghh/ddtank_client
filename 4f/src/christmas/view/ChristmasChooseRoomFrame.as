package christmas.view
{
   import christmas.ChristmasCoreController;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import store.HelpFrame;
   
   public class ChristmasChooseRoomFrame extends Frame
   {
       
      
      private var _titleImg:Bitmap;
      
      private var _roomBgImg:ScaleBitmapImage;
      
      private var _entranceImg:Bitmap;
      
      private var _activityTimeImg:Bitmap;
      
      private var _activeTimeTxt:FilterFrameText;
      
      private var _chooseRoomText:FilterFrameText;
      
      private var _enterBtn:BaseButton;
      
      private var _enterHeapBtn:BaseButton;
      
      private var _help:BaseButton;
      
      private var _clickDate:Number = 0;
      
      public function ChristmasChooseRoomFrame(){super();}
      
      private function initView() : void{}
      
      private function initText() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __onClickEnterHandler(param1:MouseEvent) : void{}
      
      private function __onClickEnterHeapHandler(param1:MouseEvent) : void{}
      
      private function __onClickHelpHandler(param1:MouseEvent) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
