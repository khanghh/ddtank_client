package dice.vo{   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.ItemManager;      public class DiceAwardInfo   {                   private var _level:int;            private var _integral:int;            private var _templateInfo:Vector.<DiceAwardCell>;            public function DiceAwardInfo($level:int, $integral:int, $templateString:String) { super(); }
            public function get level() : int { return 0; }
            public function get integral() : int { return 0; }
            public function get templateInfo() : Vector.<DiceAwardCell> { return null; }
            private function set setTemplateInfo(templateString:String) : void { }
            public function dispose() : void { }
   }}