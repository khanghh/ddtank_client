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
      
      public function setGoodsListItem(index:int) : void
      {
         var i:int = 0;
         _goodsArr = KingDivisionManager.Instance.model.getLevelGoodsItems(index);
         items = new Vector.<RewardGoodsListItem>(_goodsArr.length);
         for(i = 0; i < _goodsArr.length; )
         {
            items[i] = new RewardGoodsListItem();
            items[i].buttonMode = true;
            items[i].goodsInfo(_goodsArr[i].TemplateID,_goodsArr[i].AttackCompose,_goodsArr[i].DefendCompose,_goodsArr[i].AgilityCompose,_goodsArr[i].LuckCompose,_goodsArr[i].Count,_goodsArr[i].IsBind,_goodsArr[i].ValidDate);
            addChild(items[i]);
            i++;
         }
      }
   }
}
