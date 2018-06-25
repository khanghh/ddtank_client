package campbattle.view.awardsView
{
   import campbattle.CampBattleManager;
   import com.pickgliss.ui.controls.container.VBox;
   
   public class AwardsList extends VBox
   {
       
      
      private var _currentItem:AwardsListItem;
      
      private var items:Vector.<AwardsListItem>;
      
      public function AwardsList()
      {
         super();
      }
      
      override protected function init() : void
      {
         var i:int = 0;
         super.init();
         spacing = 10;
         items = new Vector.<AwardsListItem>(6);
         for(i = 0; i < 6; )
         {
            if(CampBattleManager.instance.goodsZone == 0 && i > 3)
            {
               return;
            }
            if(CampBattleManager.instance.goodsZone == 1)
            {
               items[i] = new AwardsListItem(i + 4,i + 4);
            }
            else if(CampBattleManager.instance.goodsZone == 0)
            {
               items[i] = new AwardsListItem(i,i);
            }
            items[i].buttonMode = true;
            addChild(items[i]);
            i++;
         }
      }
   }
}
