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
      
      public function RewardGoodsList(){super();}
      
      override protected function init() : void{}
      
      public function setGoodsListItem(param1:int) : void{}
   }
}
