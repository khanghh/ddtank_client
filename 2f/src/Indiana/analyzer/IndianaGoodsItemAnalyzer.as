package Indiana.analyzer{   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.utils.ObjectUtils;      public class IndianaGoodsItemAnalyzer extends DataAnalyzer   {                   public var itemList:Vector.<IndianaGoodsItemInfo>;            public function IndianaGoodsItemAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            public function get data() : Vector.<IndianaGoodsItemInfo> { return null; }
   }}