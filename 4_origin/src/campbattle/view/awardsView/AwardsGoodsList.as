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
      
      public function setGoodsListItem(index:int) : void
      {
         var i:int = 0;
         _goodsArr = CampBattleManager.instance.getLevelGoodsItems(index);
         items = new Vector.<AwardsGoodsListItem>(_goodsArr.length);
         for(i = 0; i < _goodsArr.length; )
         {
            items[i] = new AwardsGoodsListItem();
            items[i].buttonMode = true;
            items[i].goodsInfo(_goodsArr[i].ItemID,_goodsArr[i].AttackCompose,_goodsArr[i].DefendCompose,_goodsArr[i].AgilityCompose,_goodsArr[i].LuckCompose,_goodsArr[i].Count,_goodsArr[i].IsBind,_goodsArr[i].Valid);
            addChild(items[i]);
            i++;
         }
      }
   }
}
