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
       
      
      public function IconLayer(param1:ItemTemplateInfo, param2:String = "", param3:Boolean = false, param4:int = 1)
      {
         super(param1,param2,param3,param4);
      }
      
      override protected function initLoaders() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(_info != null)
         {
            _loc2_ = getUrl(1);
            _loc2_ = _loc2_.toLocaleLowerCase();
            _loc1_ = LoadResourceManager.Instance.createLoader(_loc2_,0);
            _queueLoader.addLoader(_loc1_);
            _defaultLayer = 0;
            _currentEdit = _info.Property8 == null?0:_info.Property8.length;
         }
      }
      
      override protected function getUrl(param1:int) : String
      {
         var _loc2_:String = "";
         if(_info.CategoryID == 70)
         {
            if(_info is InventoryItemInfo)
            {
               _loc2_ = EquipAmuletManager.Instance.getAmuletPhaseByGrade((_info as InventoryItemInfo).StrengthenLevel).toString();
            }
            else
            {
               _loc2_ = "1";
            }
         }
         return PathManager.solveGoodsPath(_info.CategoryID,_info.Pic,_info.NeedSex == 1,"icon",_hairType,String(param1),_info.Level,_gunBack,int(_info.Property1),_loc2_);
      }
   }
}
