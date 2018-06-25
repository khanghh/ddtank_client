package explorerManual.analyzer{   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.utils.ObjectUtils;   import explorerManual.data.model.ManualUpgradeInfo;      public class ManualUpgradeAnalyzer extends DataAnalyzer   {                   private var _data:Array;            public function ManualUpgradeAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            public function get data() : Array { return null; }
   }}