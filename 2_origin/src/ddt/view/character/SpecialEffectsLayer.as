package ddt.view.character
{
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PathManager;
   
   public class SpecialEffectsLayer extends BaseLayer
   {
       
      
      private var _specialType:int;
      
      public function SpecialEffectsLayer(layer:int = 1)
      {
         _specialType = layer;
         super(new ItemTemplateInfo());
      }
      
      override protected function getUrl(layer:int) : String
      {
         return PathManager.SITE_MAIN + "image/equip/effects/specialEffect/effect_" + layer + ".png";
      }
      
      override protected function initLoaders() : void
      {
         var url:String = getUrl(_specialType);
         url = url.toLocaleLowerCase();
         var l:BitmapLoader = LoadResourceManager.Instance.createLoader(url,0);
         _queueLoader.addLoader(l);
      }
   }
}
