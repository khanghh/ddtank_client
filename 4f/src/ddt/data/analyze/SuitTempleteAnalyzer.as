package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.SuitTemplateInfo;
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   
   public class SuitTempleteAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Dictionary;
      
      public function SuitTempleteAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get list() : Dictionary{return null;}
   }
}
