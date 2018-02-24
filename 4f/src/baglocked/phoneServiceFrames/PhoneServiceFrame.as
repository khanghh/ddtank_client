package baglocked.phoneServiceFrames
{
   import baglocked.BagLockedController;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class PhoneServiceFrame extends Frame
   {
      
      public static const TYPE_SERVICE:int = 0;
      
      public static const TYPE_CHANGE:int = 1;
      
      public static const TYPE_DELETE:int = 2;
       
      
      private var _bagLockedController:BagLockedController;
      
      private var _BG:ScaleBitmapImage;
      
      private var _checkBtn1:SelectedCheckButton;
      
      private var _checkBtn2:SelectedCheckButton;
      
      private var _nextBtn:TextButton;
      
      private var _cancelBtn:TextButton;
      
      private var _selectedGroup:SelectedButtonGroup;
      
      private var type:int;
      
      public function PhoneServiceFrame(){super();}
      
      public function init2(param1:int) : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      public function set bagLockedController(param1:BagLockedController) : void{}
      
      public function show() : void{}
      
      protected function __nextBtnClick(param1:MouseEvent) : void{}
      
      protected function __itemClick(param1:Event) : void{}
      
      protected function __cancelBtnClick(param1:MouseEvent) : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
