package ddt.data.analyze{   import com.pickgliss.loader.DataAnalyzer;   import ddt.data.quest.QuestInfo;   import flash.utils.Dictionary;      public class QuestListAnalyzer extends DataAnalyzer   {                   private var _xml:XML;            private var _list:Dictionary;            public function QuestListAnalyzer(onCompleteCall:Function) { super(null); }
            public function get list() : Dictionary { return null; }
            public function get improveXml() : XML { return null; }
            override public function analyze(data:*) : void { }
   }}