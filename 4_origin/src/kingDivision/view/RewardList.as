package kingDivision.view
{
   import com.pickgliss.ui.controls.container.VBox;
   import kingDivision.KingDivisionManager;
   
   public class RewardList extends VBox
   {
       
      
      private var _currentItem:RewardListItem;
      
      private var items:Vector.<RewardListItem>;
      
      public function RewardList()
      {
         super();
      }
      
      override protected function init() : void
      {
         var _loc1_:int = 0;
         super.init();
         spacing = 10;
         items = new Vector.<RewardListItem>(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            if(KingDivisionManager.Instance.model.goodsZone == 1)
            {
               items[_loc1_] = new RewardListItem(_loc1_,_loc1_ + 5);
            }
            else
            {
               items[_loc1_] = new RewardListItem(_loc1_,_loc1_);
            }
            items[_loc1_].buttonMode = true;
            addChild(items[_loc1_]);
            _loc1_++;
         }
      }
   }
}
