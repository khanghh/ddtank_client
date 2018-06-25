package team.analyze{   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.utils.ObjectUtils;   import road7th.data.DictionaryData;   import team.model.TeamBattleSegmentInfo;      public class TeamBattleSegmentAnalyzer extends DataAnalyzer   {                   private var _data:DictionaryData;            public function TeamBattleSegmentAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(value:*) : void { }
            public function get data() : DictionaryData { return null; }
   }}