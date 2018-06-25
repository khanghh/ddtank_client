package groupPurchase.analyzer{   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.utils.ObjectUtils;   import groupPurchase.data.GroupPurchaseAwardInfo;      public class GroupPurchaseAwardAnalyzer extends DataAnalyzer   {                   private var _awardList:Object;            public function GroupPurchaseAwardAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            public function get awardList() : Object { return null; }
   }}