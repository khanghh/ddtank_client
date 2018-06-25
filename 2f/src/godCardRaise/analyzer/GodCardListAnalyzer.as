package godCardRaise.analyzer{   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.utils.ObjectUtils;   import flash.utils.Dictionary;   import godCardRaise.info.GodCardListInfo;      public class GodCardListAnalyzer extends DataAnalyzer   {                   private var _list:Dictionary;            public function GodCardListAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            public function get list() : Dictionary { return null; }
   }}