package dreamlandChallenge.view.logicView.ranking
{
   import dreamlandChallenge.data.DCSpeedMatchRankVo;
   import dreamlandChallenge.view.mornui.ranking.DCPointRankingItemViewUI;
   
   public class DCPointRankingItemView extends DCPointRankingItemViewUI
   {
       
      
      private var _info:DCSpeedMatchRankVo;
      
      private var _curIndex:int = -1;
      
      public function DCPointRankingItemView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip_ranking.visible = false;
      }
      
      public function set info(value:DCSpeedMatchRankVo) : void
      {
         _info = value;
         if(_info == null || _curIndex == 0 && _info.point == 0)
         {
            reset();
         }
         else
         {
            updateRankName();
            updateRankPlayerName();
            updateOther();
         }
      }
      
      public function set rowIndex(index:int) : void
      {
         _curIndex = index;
         var isDouble:* = index % 2 == 0;
         scale_itemBg1.visible = isDouble;
         scale_itemBg0.visible = !isDouble;
         scale_itemBg2.visible = false;
         if(index == 0)
         {
            scale_itemBg2.visible = true;
            var _loc3_:Boolean = false;
            scale_itemBg1.visible = _loc3_;
            scale_itemBg0.visible = _loc3_;
         }
      }
      
      private function reset() : void
      {
         var _loc1_:* = "";
         ntxt_name.text = _loc1_;
         _loc1_ = _loc1_;
         lbl_contribute.text = _loc1_;
         lbl_area.text = _loc1_;
         updateLevTxtVisbleState(true);
         lbl_ranking.text = "";
      }
      
      private function updateOther() : void
      {
         lbl_area.text = _info.area;
         lbl_contribute.text = _info.point.toString();
      }
      
      private function updateRankName() : void
      {
         if(_info.rank < 4 && _info.rank != 0)
         {
            updateLevTxtVisbleState(false);
            clip_ranking.index = _info.rank - 1;
         }
         else
         {
            updateLevTxtVisbleState(true);
            lbl_ranking.text = _info.rank == 0?"0":_info.rank + "th";
         }
      }
      
      private function updateRankPlayerName() : void
      {
         ntxt_name.text = _info.nick;
         ntxt_name.textType = 1;
      }
      
      private function updateLevTxtVisbleState(value:Boolean) : void
      {
         clip_ranking.visible = !value;
         lbl_ranking.visible = value;
      }
   }
}
