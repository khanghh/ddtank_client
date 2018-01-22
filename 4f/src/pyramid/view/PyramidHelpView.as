package pyramid.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class PyramidHelpView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _panel:ScrollPanel;
      
      private var _list:VBox;
      
      private var _descripTxt:FilterFrameText;
      
      public function PyramidHelpView(){super();}
      
      private function initView() : void{}
      
      public function dispose() : void{}
   }
}
