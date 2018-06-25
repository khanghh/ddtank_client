package baglocked.phone4399{   import com.pickgliss.loader.DataAnalyzer;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;      public class MsnConfirmAnalyzer extends DataAnalyzer   {                   private var _type:int;            private var _value:Boolean;            private var _alertMessage:String;            private var _count:int;            public function MsnConfirmAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            public function get type() : int { return 0; }
            public function get value() : Boolean { return false; }
            public function get alertMessage() : String { return null; }
            public function get count() : int { return 0; }
   }}