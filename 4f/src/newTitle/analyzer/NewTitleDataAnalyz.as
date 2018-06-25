package newTitle.analyzer{   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.utils.ObjectUtils;   import flash.utils.Dictionary;   import newTitle.model.NewTitleModel;      public class NewTitleDataAnalyz extends DataAnalyzer   {                   public var _newTitleList:Dictionary;            public function NewTitleDataAnalyz(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            public function get list() : Dictionary { return null; }
   }}