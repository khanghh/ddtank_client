package ddt.manager
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.view.common.PreviewFrame;
   import flash.display.Bitmap;
   
   public class PreviewFrameManager
   {
      
      public static const DEFULT_FRAME_STYLE:String = "view.common.PreviewFrame";
      
      public static const DEFULT_SCROLL_STYLE:String = "view.common.PreviewFrame.PreviewScroll";
      
      public static const DEFULT_BUILD_FRAME_STYLE:String = "trainer.hall.buildPreviewFrame";
      
      public static const DEFULT_BUILD_SCROLL_STYLE:String = "view.common.masterAcademyPreviewFrame.PreviewScroll";
      
      private static var _instance:PreviewFrameManager;
       
      
      public function PreviewFrameManager(){super();}
      
      public static function get Instance() : PreviewFrameManager{return null;}
      
      public function createsPreviewFrame(param1:String, param2:String, param3:String = "", param4:String = "", param5:Function = null, param6:Boolean = true) : void{}
      
      public function createBuildPreviewFrame(param1:String, param2:Bitmap) : void{}
   }
}
