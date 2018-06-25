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
         var i:int = 0;
         super.init();
         spacing = 10;
         items = new Vector.<RewardListItem>(5);
         for(i = 0; i < 5; )
         {
            if(KingDivisionManager.Instance.model.goodsZone == 1)
            {
               items[i] = new RewardListItem(i,i + 5);
            }
            else
            {
               items[i] = new RewardListItem(i,i);
            }
            items[i].buttonMode = true;
            addChild(items[i]);
            i++;
         }
      }
   }
}
