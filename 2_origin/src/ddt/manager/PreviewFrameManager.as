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
       
      
      public function PreviewFrameManager()
      {
         super();
      }
      
      public static function get Instance() : PreviewFrameManager
      {
         if(_instance == null)
         {
            _instance = new PreviewFrameManager();
         }
         return _instance;
      }
      
      public function createsPreviewFrame(titleTxt:String, previewBitmapStyle:String, frameStyle:String = "", scrollStyle:String = "", submitFunction:Function = null, submitEnable:Boolean = true) : void
      {
         var previewFrame:* = null;
         if(frameStyle == "")
         {
            previewFrame = ComponentFactory.Instance.creatComponentByStylename("view.common.PreviewFrame");
         }
         else
         {
            previewFrame = ComponentFactory.Instance.creatComponentByStylename(frameStyle);
         }
         if(scrollStyle == "")
         {
            previewFrame.setStyle(titleTxt,previewBitmapStyle,"view.common.PreviewFrame.PreviewScroll",submitFunction,submitEnable);
         }
         else
         {
            previewFrame.setStyle(titleTxt,previewBitmapStyle,scrollStyle,submitFunction,submitEnable);
         }
         previewFrame.show();
      }
      
      public function createBuildPreviewFrame(title:String, previewBitmap:Bitmap) : void
      {
         var previewFrame:* = null;
         previewFrame = ComponentFactory.Instance.creatComponentByStylename("trainer.hall.buildPreviewFrame");
         previewFrame.setStyle(title,"","view.common.masterAcademyPreviewFrame.PreviewScroll",null,true,previewBitmap);
         previewFrame.show();
      }
   }
}
