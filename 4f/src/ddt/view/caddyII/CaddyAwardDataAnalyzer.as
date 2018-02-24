package ddt.view.caddyII
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class CaddyAwardDataAnalyzer extends DataAnalyzer
   {
       
      
      public var _awards:Vector.<CaddyAwardInfo>;
      
      public var _silverAwards:Vector.<CaddyAwardInfo>;
      
      public var _goldAwards:Vector.<CaddyAwardInfo>;
      
      public var _treasureAwards:Vector.<CaddyAwardInfo>;
      
      public var _silverToyAwards:Vector.<CaddyAwardInfo>;
      
      public var _goldToyAwards:Vector.<CaddyAwardInfo>;
      
      public function CaddyAwardDataAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
   }
}
