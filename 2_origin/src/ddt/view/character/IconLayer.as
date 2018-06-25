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
       
      
      public function IconLayer(info:ItemTemplateInfo, color:String = "", gunback:Boolean = false, hairType:int = 1)
      {
         super(info,color,gunback,hairType);
      }
      
      override protected function initLoaders() : void
      {
         var url:* = null;
         var l:* = null;
         if(_info != null)
         {
            url = getUrl(1);
            url = url.toLocaleLowerCase();
            l = LoadResourceManager.Instance.createLoader(url,0);
            _queueLoader.addLoader(l);
            _defaultLayer = 0;
            _currentEdit = _info.Property8 == null?0:_info.Property8.length;
         }
      }
      
      override protected function getUrl(layer:int) : String
      {
         var extend:String = "";
         if(_info.CategoryID == 70)
         {
            if(_info is InventoryItemInfo)
            {
               extend = EquipAmuletManager.Instance.getAmuletPhaseByGrade((_info as InventoryItemInfo).StrengthenLevel).toString();
            }
            else
            {
               extend = "1";
            }
         }
         return PathManager.solveGoodsPath(_info.CategoryID,_info.Pic,_info.NeedSex == 1,"icon",_hairType,String(layer),_info.Level,_gunBack,int(_info.Property1),extend);
      }
   }
}
