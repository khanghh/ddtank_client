package changeColor.view
{
   import changeColor.ChangeColorControl;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.ChangeColorCellEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ChangeColorManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.geom.Rectangle;
   
   public class ChangeColorFrame extends Frame
   {
       
      
      private var _changeColorLeftView:ChangeColorLeftView;
      
      private var _changeColorRightView:ChangeColorRightView;
      
      public function ChangeColorFrame(){super();}
      
      override public function dispose() : void{}
      
      public function show() : void{}
      
      override protected function init() : void{}
      
      private function addEvent() : void{}
      
      private function remvoeEvent() : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      private function __cellClickHandler(param1:ChangeColorCellEvent) : void{}
      
      private function __useCardHandler(param1:PkgEvent) : void{}
      
      public function setFirstItemSelected() : void{}
   }
}
