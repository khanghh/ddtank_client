package draft.data{   import com.pickgliss.loader.DataAnalyzer;      public class DraftListAnalyzer extends DataAnalyzer   {                   private var _draftInfoVec:Vector.<DraftModel>;            public function DraftListAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            public function get draftInfoVec() : Vector.<DraftModel> { return null; }
   }}