package baglocked
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class AppealFrame extends Frame
   {
       
      
      private var _bagLockedController:BagLockedController;
      
      private var _appealMap:MovieClip;
      
      private var _closeBtn:TextButton;
      
      public function AppealFrame(){super();}
      
      override protected function init() : void{}
      
      protected function __closeBtnClick(param1:MouseEvent) : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      public function set bagLockedController(param1:BagLockedController) : void{}
      
      public function show() : void{}
      
      private function addEvent() : void{}
      
      private function remvoeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
