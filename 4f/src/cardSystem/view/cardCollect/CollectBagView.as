package cardSystem.view.cardCollect{   import cardSystem.CardManager;   import cardSystem.data.SetsInfo;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;      public class CollectBagView extends Sprite implements Disposeable   {            public static const SELECT:String = "selected";                   private var _container:VBox;            private var _collectItemVector:Vector.<CollectBagItem>;            private var _turnPage:CollectTurnPage;            private var _currentCollectItem:CollectBagItem;            public function CollectBagView() { super(); }
            public function get currentItemSetsInfo() : SetsInfo { return null; }
            private function initView() : void { }
            private function __clickHandler(event:MouseEvent) : void { }
            private function seleted(item:CollectBagItem) : void { }
            private function setPage(page:int) : void { }
            private function __overHandler(event:MouseEvent) : void { }
            private function __outHandler(event:MouseEvent) : void { }
            private function removeEvent() : void { }
            protected function __turnPage(event:Event) : void { }
            public function dispose() : void { }
   }}