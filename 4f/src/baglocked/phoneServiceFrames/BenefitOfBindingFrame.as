package baglocked.phoneServiceFrames
{
   import baglocked.BagLockedController;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import quest.TaskManager;
   
   public class BenefitOfBindingFrame extends Frame
   {
       
      
      private var _bagLockedController:BagLockedController;
      
      private var _BG:Bitmap;
      
      private var _startBtn:TextButton;
      
      private var _nextTimeBtn:TextButton;
      
      public function BenefitOfBindingFrame(){super();}
      
      override protected function init() : void{}
      
      protected function __startBtnClick(param1:MouseEvent) : void{}
      
      protected function __nextTimeBtnClick(param1:MouseEvent) : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      public function set bagLockedController(param1:BagLockedController) : void{}
      
      public function show() : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
