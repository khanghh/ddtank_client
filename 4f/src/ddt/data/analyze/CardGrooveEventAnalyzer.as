package ddt.data.analyze
{
   import cardSystem.data.CardGrooveInfo;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   
   public class CardGrooveEventAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Dictionary;
      
      public function CardGrooveEventAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get list() : Dictionary{return null;}
   }
}
