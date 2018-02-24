package Indiana.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class IndianaGoodsItemAnalyzer extends DataAnalyzer
   {
       
      
      public var itemList:Vector.<IndianaGoodsItemInfo>;
      
      public function IndianaGoodsItemAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get data() : Vector.<IndianaGoodsItemInfo>{return null;}
   }
}
