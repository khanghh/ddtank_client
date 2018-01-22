package campbattle.view.awardsView
{
   import campbattle.CampBattleManager;
   import com.pickgliss.ui.controls.container.HBox;
   
   public class AwardsGoodsList extends HBox
   {
       
      
      private var _currentItem:AwardsGoodsListItem;
      
      private var items:Vector.<AwardsGoodsListItem>;
      
      private var _zone:int;
      
      private var _goodsArr:Array;
      
      public function AwardsGoodsList()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         spacing = 3;
      }
      
      public function setGoodsListItem(param1:int) : void
      {
         var _loc2_:int = 0;
         _goodsArr = CampBattleManager.instance.getLevelGoodsItems(param1);
         items = new Vector.<AwardsGoodsListItem>(_goodsArr.length);
         _loc2_ = 0;
         while(_loc2_ < _goodsArr.length)
         {
            items[_loc2_] = new AwardsGoodsListItem();
            items[_loc2_].buttonMode = true;
            items[_loc2_].goodsInfo(_goodsArr[_loc2_].ItemID,_goodsArr[_loc2_].AttackCompose,_goodsArr[_loc2_].DefendCompose,_goodsArr[_loc2_].AgilityCompose,_goodsArr[_loc2_].LuckCompose,_goodsArr[_loc2_].Count,_goodsArr[_loc2_].IsBind,_goodsArr[_loc2_].Valid);
            addChild(items[_loc2_]);
            _loc2_++;
         }
      }
   }
}
