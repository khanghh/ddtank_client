package newOpenGuide
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class NewOpenGuideDialogView extends Sprite implements Disposeable
   {
       
      
      private var _headImg:Bitmap;
      
      private var _titleTxt:FilterFrameText;
      
      private var _descTxt:FilterFrameText;
      
      public function NewOpenGuideDialogView(){super();}
      
      private function initView() : void{}
      
      public function show(param1:String, param2:String = "", param3:Bitmap = null, param4:Point = null) : void{}
      
      public function dispose() : void{}
   }
}
