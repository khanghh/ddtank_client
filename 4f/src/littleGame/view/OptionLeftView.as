package littleGame.view
{
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PathManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class OptionLeftView extends Sprite implements Disposeable
   {
       
      
      private var _ddtlittlegamebg:MovieImage;
      
      private var _previewLoader:BitmapLoader;
      
      private var _previewMap:Bitmap;
      
      private var _ddtlittlegamebg1:ScaleBitmapImage;
      
      public function OptionLeftView(){super();}
      
      private function initView() : void{}
      
      private function __previewMapComplete(param1:LoaderEvent) : void{}
      
      public function dispose() : void{}
   }
}
