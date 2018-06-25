package mainbutton.data{   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.utils.ObjectUtils;   import flash.utils.Dictionary;   import mainbutton.MainButton;      public class HallIconDataAnalyz extends DataAnalyzer   {                   public var _HallIconList:Dictionary;            public function HallIconDataAnalyz(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            public function get list() : Dictionary { return null; }
   }}