package store.view.fusion
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   import store.data.PreviewInfoII;
   
   public class PreviewItem extends Sprite implements Disposeable
   {
       
      
      private var _cell:PreviewItemCell;
      
      private var rate_txt:FilterFrameText;
      
      private var title_txt:FilterFrameText;
      
      public function PreviewItem(){super();}
      
      private function initView() : void{}
      
      public function set info(param1:PreviewInfoII) : void{}
      
      public function dispose() : void{}
   }
}
