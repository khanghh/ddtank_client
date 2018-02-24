package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.CateCoryInfo;
   
   public class GoodCategoryAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Vector.<CateCoryInfo>;
      
      private var _xml:XML;
      
      public function GoodCategoryAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
   }
}
