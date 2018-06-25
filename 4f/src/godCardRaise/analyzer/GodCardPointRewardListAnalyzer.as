package godCardRaise.analyzer{   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.utils.ObjectUtils;   import godCardRaise.info.GodCardPointRewardListInfo;      public class GodCardPointRewardListAnalyzer extends DataAnalyzer   {                   private var _list:Vector.<GodCardPointRewardListInfo>;            public function GodCardPointRewardListAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            public function get list() : Vector.<GodCardPointRewardListInfo> { return null; }
   }}