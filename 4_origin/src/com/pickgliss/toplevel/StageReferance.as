package com.pickgliss.toplevel
{
   import com.pickgliss.layout.StageResizeUtils;
   import flash.display.Stage;
   import flash.events.Event;
   
   public final class StageReferance
   {
      
      public static var defaultWidth:int = 1000;
      
      public static var defaultHeight:int = 600;
      
      public static var stageHeight:int = 1000;
      
      public static var stageWidth:int = 600;
      
      private static var _stage:Stage;
       
      
      public function StageReferance()
      {
         super();
      }
      
      public static function setup($stage:Stage) : void
      {
         if(_stage != null)
         {
            return;
         }
         _stage = $stage;
         _stage.addEventListener("exitFrame",__onNextFrame);
         _stage.addEventListener("resize",__onResize);
         _stage.stageFocusRect = false;
         StageResizeUtils.Instance.setup();
      }
      
      private static function __onNextFrame(event:Event) : void
      {
         if(_stage.stageWidth > 0)
         {
            _stage.removeEventListener("exitFrame",__onNextFrame);
            stageWidth = 1000;
            stageHeight = 600;
         }
      }
      
      private static function __onResize(event:Event) : void
      {
         stageWidth = _stage.stageWidth;
         stageHeight = _stage.stageHeight;
      }
      
      public static function isStageResize() : Boolean
      {
         if(defaultWidth != stageWidth || defaultHeight != stageHeight)
         {
            return true;
         }
         return false;
      }
      
      public static function get stage() : Stage
      {
         return _stage;
      }
   }
}
