package Indiana.analyzer{   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.utils.ObjectUtils;      public class IndianaShopItemsAnalyzer extends DataAnalyzer   {                   public var itemList:Vector.<IndianaShopItemInfo>;            public function IndianaShopItemsAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            public function get data() : Vector.<IndianaShopItemInfo> { return null; }
   }}