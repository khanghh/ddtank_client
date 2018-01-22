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
      
      public function setUp(param1:CaddyAwardDataAnalyzer) : void
      {
         _awards = param1._awards;
         _silverAwards = param1._silverAwards;
         _goldAwards = param1._goldAwards;
         _treasureAwards = param1._treasureAwards;
         _silverToyAwards = param1._silverToyAwards;
         _goldToyAwards = param1._goldToyAwards;
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
