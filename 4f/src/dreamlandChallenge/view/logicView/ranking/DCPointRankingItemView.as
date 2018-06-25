package dreamlandChallenge.view.logicView.ranking{   import dreamlandChallenge.data.DCSpeedMatchRankVo;   import dreamlandChallenge.view.mornui.ranking.DCPointRankingItemViewUI;      public class DCPointRankingItemView extends DCPointRankingItemViewUI   {                   private var _info:DCSpeedMatchRankVo;            private var _curIndex:int = -1;            public function DCPointRankingItemView() { super(); }
            override protected function initialize() : void { }
            public function set info(value:DCSpeedMatchRankVo) : void { }
            public function set rowIndex(index:int) : void { }
            private function reset() : void { }
            private function updateOther() : void { }
            private function updateRankName() : void { }
            private function updateRankPlayerName() : void { }
            private function updateLevTxtVisbleState(value:Boolean) : void { }
   }}