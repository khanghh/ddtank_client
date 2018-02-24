package store.view.strength
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.view.tips.GoodTip;
   import ddt.view.tips.GoodTipInfo;
   import store.view.strength.manager.ItemStrengthenGoodsInfoManager;
   import store.view.strength.vo.ItemStrengthenGoodsInfo;
   
   public class StrengthTips extends GoodTip
   {
       
      
      protected var _laterEquipmentView:LaterEquipmentView;
      
      public function StrengthTips(){super();}
      
      override protected function init() : void{}
      
      override protected function addChildren() : void{}
      
      override public function set tipData(param1:Object) : void{}
      
      override public function showTip(param1:ItemTemplateInfo, param2:Boolean = false) : void{}
      
      protected function laterEquipment(param1:GoodTipInfo) : void{}
      
      override public function dispose() : void{}
   }
}
