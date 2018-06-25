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
      
      public function OptionLeftView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _ddtlittlegamebg = ComponentFactory.Instance.creatComponentByStylename("ddtlittleGame.BG1");
         addChild(_ddtlittlegamebg);
         _ddtlittlegamebg1 = ComponentFactory.Instance.creatComponentByStylename("ddtlittleGameLeftViewBG1");
         addChild(_ddtlittlegamebg1);
         _previewLoader = LoadResourceManager.Instance.createLoader(PathManager.solveLittleGameMapPreview(1),0);
         _previewLoader.addEventListener("complete",__previewMapComplete);
         LoadResourceManager.Instance.startLoad(_previewLoader);
      }
      
      private function __previewMapComplete(evt:LoaderEvent) : void
      {
         if(evt.loader.isSuccess)
         {
            evt.loader.removeEventListener("complete",__previewMapComplete);
            ObjectUtils.disposeObject(_previewMap);
            _previewMap = null;
            _previewMap = evt.loader.content as Bitmap;
            addChildAt(_previewMap,1);
            PositionUtils.setPos(_previewMap,"littleGame.previewMap.pos");
         }
      }
      
      public function dispose() : void
      {
         if(_previewLoader)
         {
            _previewLoader.removeEventListener("complete",__previewMapComplete);
         }
         _previewLoader = null;
         ObjectUtils.disposeObject(_ddtlittlegamebg1);
         _ddtlittlegamebg1 = null;
         ObjectUtils.disposeObject(_ddtlittlegamebg);
         _ddtlittlegamebg = null;
         ObjectUtils.disposeObject(_previewMap);
         _previewMap = null;
      }
   }
}
