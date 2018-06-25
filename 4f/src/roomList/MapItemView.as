package roomList{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.loader.MapSmallIcon;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;      public class MapItemView extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _mapIcon:MapSmallIcon;            private var _bgII:ScaleBitmapImage;            private var _mapID:int;            private var _cellWidth:int;            private var _cellheight:int;            public function MapItemView(mapID:int, cellWidth:int, cellheight:int) { super(); }
            private function init() : void { }
            protected function __itemOut(event:MouseEvent) : void { }
            protected function __itemOver(event:MouseEvent) : void { }
            private function __mapIconLoadComplete(event:Event) : void { }
            public function get id() : int { return 0; }
            public function dispose() : void { }
   }}