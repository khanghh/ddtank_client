package bagAndInfo.bag.ring.data{   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.utils.ObjectUtils;   import flash.utils.Dictionary;      public class RingDataAnalyzer extends DataAnalyzer   {                   private var _data:Dictionary;            public function RingDataAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            public function get data() : Dictionary { return null; }
   }}