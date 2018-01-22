package cardSystem.analyze
{
   import cardSystem.data.CardTemplateInfo;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   
   public class CardTemplateAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Dictionary;
      
      public function CardTemplateAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get list() : Dictionary{return null;}
   }
}
