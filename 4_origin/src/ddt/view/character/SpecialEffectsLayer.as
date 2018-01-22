package ddt.view.character
{
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PathManager;
   
   public class SpecialEffectsLayer extends BaseLayer
   {
       
      
      private var _specialType:int;
      
      public function SpecialEffectsLayer(param1:int = 1)
      {
         _specialType = param1;
         super(new ItemTemplateInfo());
      }
      
      override protected function getUrl(param1:int) : String
      {
         return PathManager.SITE_MAIN + "image/equip/effects/specialEffect/effect_" + param1 + ".png";
      }
      
      override protected function initLoaders() : void
      {
         var _loc2_:String = getUrl(_specialType);
         _loc2_ = _loc2_.toLocaleLowerCase();
         var _loc1_:BitmapLoader = LoadResourceManager.Instance.createLoader(_loc2_,0);
         _queueLoader.addLoader(_loc1_);
      }
   }
}
