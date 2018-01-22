package ddt.view.common.church
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   
   public class ChurchDialogueUnmarried extends BaseAlerFrame
   {
       
      
      private var _bg:Bitmap;
      
      private var _alertInfo:AlertInfo;
      
      public function ChurchDialogueUnmarried(){super();}
      
      protected function initialize() : void{}
      
      private function onFrameResponse(param1:FrameEvent) : void{}
      
      public function show() : void{}
      
      override public function dispose() : void{}
   }
}
