package guardCore.analyzer{   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.utils.ObjectUtils;   import guardCore.data.GuardCoreInfo;      public class GuardCoreAnalyzer extends DataAnalyzer   {                   private var _list:Vector.<GuardCoreInfo>;            public function GuardCoreAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            public function get list() : Vector.<GuardCoreInfo> { return null; }
   }}