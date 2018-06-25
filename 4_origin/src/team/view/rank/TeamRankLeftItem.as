package team.view.rank
{
   import team.view.mornui.Rank.TeamRankLeftItemUI;
   
   public class TeamRankLeftItem extends TeamRankLeftItemUI
   {
       
      
      private var _isClick:Boolean;
      
      private var _index:int;
      
      public function TeamRankLeftItem(index:int = 0)
      {
         super();
         _index = index;
         _isClick = false;
      }
      
      public function set index(value:int) : void
      {
         _index = value;
         updataItem();
      }
      
      private function updataItem() : void
      {
         if(_isClick)
         {
            image_itemBg.index = 1;
            image_itemContent.index = 5 + _index;
         }
         else
         {
            image_itemBg.index = 0;
            image_itemContent.index = _index;
         }
      }
      
      public function set isClick(value:Boolean) : void
      {
         _isClick = value;
         updataItem();
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
