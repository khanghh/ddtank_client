package starling.scene.hall.player{   import ddt.manager.ItemManager;   import ddt.view.sceneCharacter.SceneCharacterLayer;   import flash.display.BitmapData;      public class HallPlayerHeadLoader extends HallPlayerBaseLoader   {                   private var _content:BitmapData;            private var _color:Array;            private var _style:Array;            public function HallPlayerHeadLoader(style:Array, color:Array) { super(); }
            override protected function setLoaderData() : void { }
            override protected function drawCharacter() : void { }
            override public function get content() : Object { return null; }
            override public function dispose() : void { }
   }}