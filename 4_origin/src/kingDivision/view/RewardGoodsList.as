package kingDivision.view
{
   import com.pickgliss.ui.controls.container.HBox;
   import kingDivision.KingDivisionManager;
   
   public class RewardGoodsList extends HBox
   {
       
      
      private var _currentItem:RewardGoodsListItem;
      
      private var items:Vector.<RewardGoodsListItem>;
      
      private var _zone:int;
      
      private var _goodsArr:Array;
      
      public function RewardGoodsList()
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
         _goodsArr = KingDivisionManager.Instance.model.getLevelGoodsItems(param1);
         items = new Vector.<RewardGoodsListItem>(_goodsArr.length);
         _loc2_ = 0;
         while(_loc2_ < _goodsArr.length)
         {
            items[_loc2_] = new RewardGoodsListItem();
            items[_loc2_].buttonMode = true;
            items[_loc2_].goodsInfo(_goodsArr[_loc2_].TemplateID,_goodsArr[_loc2_].AttackCompose,_goodsArr[_loc2_].DefendCompose,_goodsArr[_loc2_].AgilityCompose,_goodsArr[_loc2_].LuckCompose,_goodsArr[_loc2_].Count,_goodsArr[_loc2_].IsBind,_goodsArr[_loc2_].ValidDate);
            addChild(items[_loc2_]);
            _loc2_++;
         }
      }
   }
}
