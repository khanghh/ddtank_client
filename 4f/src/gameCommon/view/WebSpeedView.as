package gameCommon.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import ddt.events.WebSpeedEvent;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.getTimer;
   import gameCommon.GameControl;
   import room.model.WebSpeedInfo;
   
   public class WebSpeedView extends Sprite
   {
       
      
      private var _bg:ScaleFrameImage;
      
      private var _info:WebSpeedInfo;
      
      private var _startTime:Number;
      
      private var _count:uint = 1500;
      
      public function WebSpeedView(){super();}
      
      private function initView() : void{}
      
      public function dispose() : void{}
      
      private function initEvent() : void{}
      
      private function __stateChanged(param1:WebSpeedEvent) : void{}
      
      private function __frame(param1:Event) : void{}
   }
}
