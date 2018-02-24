package ddt.view.caddyII
{
   import com.pickgliss.ui.ComponentFactory;
   
   public class CaddyAwardModel
   {
      
      private static var _ins:CaddyAwardModel;
       
      
      private var _awards:Vector.<CaddyAwardInfo>;
      
      private var _silverAwards:Vector.<CaddyAwardInfo>;
      
      private var _goldAwards:Vector.<CaddyAwardInfo>;
      
      private var _treasureAwards:Vector.<CaddyAwardInfo>;
      
      private var _silverToyAwards:Vector.<CaddyAwardInfo>;
      
      private var _goldToyAwards:Vector.<CaddyAwardInfo>;
      
      public var silverAwardCount:int;
      
      public var goldAwardCount:int;
      
      public function CaddyAwardModel(){super();}
      
      public static function getInstance() : CaddyAwardModel{return null;}
      
      public function setUp(param1:CaddyAwardDataAnalyzer) : void{}
      
      public function getAwards() : Vector.<CaddyAwardInfo>{return null;}
      
      public function getSilverAwards() : Vector.<CaddyAwardInfo>{return null;}
      
      public function getGoldAwards() : Vector.<CaddyAwardInfo>{return null;}
      
      public function getSilverToyAwards() : Vector.<CaddyAwardInfo>{return null;}
      
      public function getGoldToyAwards() : Vector.<CaddyAwardInfo>{return null;}
      
      public function getTreasureAwards() : Vector.<CaddyAwardInfo>{return null;}
   }
}
