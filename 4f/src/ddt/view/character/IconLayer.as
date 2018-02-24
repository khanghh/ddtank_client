package ddt.view.character
{
   import bagAndInfo.amulet.EquipAmuletManager;
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PathManager;
   
   public class IconLayer extends BaseLayer
   {
       
      
      public function IconLayer(param1:ItemTemplateInfo, param2:String = "", param3:Boolean = false, param4:int = 1){super(null,null,null,null);}
      
      override protected function initLoaders() : void{}
      
      override protected function getUrl(param1:int) : String{return null;}
   }
}
