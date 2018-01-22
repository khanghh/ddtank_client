package team.view.rank
{
   import team.view.mornui.Rank.TeamRankLeftItemUI;
   
   public class TeamRankLeftItem extends TeamRankLeftItemUI
   {
       
      
      private var _isClick:Boolean;
      
      private var _index:int;
      
      public function TeamRankLeftItem(param1:int = 0)
      {
         super();
         _index = param1;
         _isClick = false;
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
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
      
      public function set isClick(param1:Boolean) : void
      {
         _isClick = param1;
         updataItem();
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
