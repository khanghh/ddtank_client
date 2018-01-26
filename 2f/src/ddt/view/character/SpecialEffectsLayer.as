package ddt.view.character
{
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PathManager;
   
   public class SpecialEffectsLayer extends BaseLayer
   {
       
      
      private var _specialType:int;
      
      public function SpecialEffectsLayer(param1:int = 1){super(null);}
      
      override protected function getUrl(param1:int) : String{return null;}
      
      override protected function initLoaders() : void{}
   }
}
