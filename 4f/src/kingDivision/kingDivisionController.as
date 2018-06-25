package kingDivision{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import flash.events.Event;   import flash.events.EventDispatcher;   import kingDivision.view.KingDivisionFrame;      public class kingDivisionController extends EventDispatcher   {            private static var _instance:kingDivisionController;                   public var _kingDivFrame:KingDivisionFrame;            public function kingDivisionController(pct:PrivateClass) { super(); }
            public static function get Instance() : kingDivisionController { return null; }
            public function setup() : void { }
            private function __onSearchResult(evt:Event) : void { }
            private function __onMatchInfo(evt:Event) : void { }
            private function __onMatchScore(evt:Event) : void { }
            private function __onMatchRank(evt:Event) : void { }
            private function __onMatchAreaRank(evt:Event) : void { }
            private function __onMatchAreaRankInfo(evt:Event) : void { }
            private function __onKingDivisionOpenFrame(evt:Event) : void { }
   }}class PrivateClass{          function PrivateClass() { super(); }
}