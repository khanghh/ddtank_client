package store{   import ddt.manager.PlayerManager;   import road7th.data.DictionaryData;   import store.data.StoreModel;      public class StoreController   {                   private var _type:String;            private var _model:StoreModel;            private var _viewArr:Array;            public var selectedIndex:DictionaryData;            public function StoreController() { super(); }
            private function init() : void { }
            private function initEvents() : void { }
            private function removeEvents() : void { }
            public function startupEvent() : void { }
            public function shutdownEvent() : void { }
            public function get Model() : StoreModel { return null; }
            public function dispose() : void { }
   }}