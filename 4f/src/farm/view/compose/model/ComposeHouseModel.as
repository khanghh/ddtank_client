package farm.view.compose.model{   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import flash.utils.Dictionary;   import road7th.data.DictionaryData;      public class ComposeHouseModel extends EventDispatcher   {                   private var _items:DictionaryData;            private var _foodComposeList:Dictionary;            public function ComposeHouseModel(target:IEventDispatcher = null) { super(null); }
            public function get foodComposeList() : Dictionary { return null; }
            public function set foodComposeList(value:Dictionary) : void { }
            public function get items() : DictionaryData { return null; }
            public function set items(value:DictionaryData) : void { }
   }}