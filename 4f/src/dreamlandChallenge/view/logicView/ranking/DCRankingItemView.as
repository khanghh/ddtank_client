package dreamlandChallenge.view.logicView.ranking{   import dreamlandChallenge.data.DCSpeedMatchRankVo;   import dreamlandChallenge.view.mornui.ranking.DCRankingItemViewUI;      public class DCRankingItemView extends DCRankingItemViewUI   {                   private var _info:DCSpeedMatchRankVo;            private var _curIndex:int = -1;            public function DCRankingItemView() { super(); }
            override protected function initialize() : void { }
            public function set info(info:DCSpeedMatchRankVo) : void { }
            public function set rowIndex(index:int) : void { }
            private function reset() : void { }
            private function updateOther() : void { }
            private function updateRankName() : void { }
            private function updateRankPlayerName() : void { }
            private function updateLevTxtVisbleState(value:Boolean) : void { }
            override public function dispose() : void { }
   }}