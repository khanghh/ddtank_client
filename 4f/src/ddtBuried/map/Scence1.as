package ddtBuried.map{   import bagAndInfo.cell.BagCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.ItemManager;   import ddtBuried.BuriedControl;   import ddtBuried.BuriedManager;   import ddtBuried.data.MapItemData;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.geom.Point;      public class Scence1 extends MovieClip implements Disposeable   {                   private var _content:Sprite;            private var _mapArray:Array;            private var _map:Maps;            private var standArray:Array;            public function Scence1(str:String, row:int, col:int) { super(); }
            private function initView(str:String, row:int, col:int) : void { }
            private function initMapItem() : void { }
            public function getRoadPoint() : Point { return null; }
            public function updateRoadPoint(pos:int = 0) : void { }
            private function creatIcon(id:int) : Sprite { return null; }
            public function selfFindPath(xpos:int, ypos:int) : void { }
            public function dispose() : void { }
   }}