package bagAndInfo.cell{   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.view.PropItemView;   import ddt.view.character.ILayer;   import ddt.view.character.ILayerFactory;   import ddt.view.character.LayerFactory;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import times.utils.timerManager.TimerJuggler;   import times.utils.timerManager.TimerManager;      public class CellContentCreator extends Sprite implements Disposeable   {                   protected var _factory:ILayerFactory;            protected var _loader:ILayer;            protected var _callBack:Function;            protected var _timer:TimerJuggler;            protected var _info:ItemTemplateInfo;            private var _w:Number;            private var _h:Number;            public function CellContentCreator() { super(); }
            public function set info($info:ItemTemplateInfo) : void { }
            public function loadSync(callBack:Function) : void { }
            public function clearLoader() : void { }
            protected function __timerComplete(evt:Event) : void { }
            protected function loadComplete(layer:ILayer) : void { }
            public function setColor(color:*) : Boolean { return false; }
            public function get editLayer() : int { return 0; }
            override public function set width(value:Number) : void { }
            override public function set height(value:Number) : void { }
            public function dispose() : void { }
   }}