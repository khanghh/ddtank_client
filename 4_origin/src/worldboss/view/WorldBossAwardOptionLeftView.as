package worldboss.view
{
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import worldboss.WorldBossManager;
   
   public class WorldBossAwardOptionLeftView extends Sprite implements Disposeable
   {
       
      
      private var _ddtlittlegamebg:MovieImage;
      
      private var _previewLoader:BitmapLoader;
      
      private var _previewMap:Bitmap;
      
      private var _ddtlittlegamebg1:ScaleBitmapImage;
      
      private var _rankingView:WorldBossRankingView;
      
      public function WorldBossAwardOptionLeftView()
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
         _previewLoader = LoadResourceManager.Instance.createLoader(WorldBossManager.Instance.getWorldbossResource() + "/preview/previewmap.png",0);
         _previewLoader.addEventListener("complete",__previewMapComplete);
         LoadResourceManager.Instance.startLoad(_previewLoader);
      }
      
      private function __previewMapComplete(param1:LoaderEvent) : void
      {
         if(param1.loader.isSuccess)
         {
            param1.loader.removeEventListener("complete",__previewMapComplete);
            ObjectUtils.disposeObject(_previewMap);
            _previewMap = null;
            _previewMap = param1.loader.content as Bitmap;
            addChildAt(_previewMap,1);
            PositionUtils.setPos(_previewMap,"asset.worldbossAwardRoom.previewMap");
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_ddtlittlegamebg1);
         _ddtlittlegamebg1 = null;
         ObjectUtils.disposeObject(_ddtlittlegamebg);
         _ddtlittlegamebg = null;
         ObjectUtils.disposeObject(_previewMap);
         _previewMap = null;
         ObjectUtils.disposeObject(_rankingView);
         _rankingView = null;
      }
   }
}
