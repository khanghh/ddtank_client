package cardSystem.view.cardEquip{   import bagAndInfo.cell.DragEffect;   import cardSystem.data.CardInfo;   import ddt.interfaces.IAcceptDrag;   import ddt.manager.DragManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import flash.display.Sprite;   import road7th.data.DictionaryData;      public class CardEquipDragArea extends Sprite implements IAcceptDrag   {                   private var _view:CardEquipView;            public function CardEquipDragArea(view:CardEquipView) { super(); }
            private function init() : void { }
            public function dragDrop(effect:DragEffect) : void { }
            public function dispose() : void { }
   }}