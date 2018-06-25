package guardCore.analyzer{   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.utils.ObjectUtils;   import guardCore.data.GuardCoreLevelInfo;      public class GuardCoreLevelAnayzer extends DataAnalyzer   {                   private var _list:Vector.<GuardCoreLevelInfo>;            public function GuardCoreLevelAnayzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            public function get list() : Vector.<GuardCoreLevelInfo> { return null; }
   }}