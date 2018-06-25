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
      
      public function CaddyAwardModel()
      {
         super();
      }
      
      public static function getInstance() : CaddyAwardModel
      {
         if(_ins == null)
         {
            _ins = ComponentFactory.Instance.creatCustomObject("CaddyAwardModel");
         }
         return _ins;
      }
      
      public function setUp(analyzer:CaddyAwardDataAnalyzer) : void
      {
         _awards = analyzer._awards;
         _silverAwards = analyzer._silverAwards;
         _goldAwards = analyzer._goldAwards;
         _treasureAwards = analyzer._treasureAwards;
         _silverToyAwards = analyzer._silverToyAwards;
         _goldToyAwards = analyzer._goldToyAwards;
      }
      
      public function getAwards() : Vector.<CaddyAwardInfo>
      {
         return _awards;
      }
      
      public function getSilverAwards() : Vector.<CaddyAwardInfo>
      {
         return _silverAwards;
      }
      
      public function getGoldAwards() : Vector.<CaddyAwardInfo>
      {
         return _goldAwards;
      }
      
      public function getSilverToyAwards() : Vector.<CaddyAwardInfo>
      {
         return _silverToyAwards;
      }
      
      public function getGoldToyAwards() : Vector.<CaddyAwardInfo>
      {
         return _goldToyAwards;
      }
      
      public function getTreasureAwards() : Vector.<CaddyAwardInfo>
      {
         return _treasureAwards;
      }
   }
}
