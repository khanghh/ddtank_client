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
         var _loc1_:int = 0;
         super.init();
         spacing = 10;
         items = new Vector.<AwardsListItem>(6);
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            if(CampBattleManager.instance.goodsZone == 0 && _loc1_ > 3)
            {
               return;
            }
            if(CampBattleManager.instance.goodsZone == 1)
            {
               items[_loc1_] = new AwardsListItem(_loc1_ + 4,_loc1_ + 4);
            }
            else if(CampBattleManager.instance.goodsZone == 0)
            {
               items[_loc1_] = new AwardsListItem(_loc1_,_loc1_);
            }
            items[_loc1_].buttonMode = true;
            addChild(items[_loc1_]);
            _loc1_++;
         }
      }
   }
}
