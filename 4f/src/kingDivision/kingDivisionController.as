package kingDivision
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import kingDivision.view.KingDivisionFrame;
   
   public class kingDivisionController extends EventDispatcher
   {
      
      private static var _instance:kingDivisionController;
       
      
      public var _kingDivFrame:KingDivisionFrame;
      
      public function kingDivisionController(param1:PrivateClass){super();}
      
      public static function get Instance() : kingDivisionController{return null;}
      
      public function setup() : void{}
      
      private function __onSearchResult(param1:Event) : void{}
      
      private function __onMatchInfo(param1:Event) : void{}
      
      private function __onMatchScore(param1:Event) : void{}
      
      private function __onMatchRank(param1:Event) : void{}
      
      private function __onMatchAreaRank(param1:Event) : void{}
      
      private function __onMatchAreaRankInfo(param1:Event) : void{}
      
      private function __onKingDivisionOpenFrame(param1:Event) : void{}
   }
}

class PrivateClass
{
    
   
   function PrivateClass(){super();}
}
