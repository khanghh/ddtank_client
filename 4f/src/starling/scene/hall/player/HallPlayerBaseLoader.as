package starling.scene.hall.player{   import com.pickgliss.ui.core.Disposeable;   import ddt.view.character.ILayer;      public class HallPlayerBaseLoader implements Disposeable   {                   protected var _isAllLoadSucceed:Boolean = false;            protected var _loaders:Vector.<ILayer>;            protected var _cellBack:Function;            public function HallPlayerBaseLoader() { super(); }
            public function load(callBack:Function) : void { }
            protected function setLoaderData() : void { }
            private function layerComplete(layer:ILayer) : void { }
            protected function drawCharacter() : void { }
            protected function loadComplete() : void { }
            public function get content() : Object { return null; }
            public function get isAllLoadSucceed() : Boolean { return false; }
            public function dispose() : void { }
   }}