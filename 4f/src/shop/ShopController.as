package shop{   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ShopCarItemInfo;   import ddt.data.goods.ShopItemInfo;   import ddt.data.player.PlayerState;   import ddt.manager.ChatManager;   import ddt.manager.PlayerManager;   import ddt.manager.QQtipsManager;   import ddt.manager.SocketManager;   import ddt.states.BaseStateView;   import ddt.view.MainToolBar;   import ddt.view.chat.ChatBugleView;   import flash.display.DisplayObject;   import flash.display.Sprite;   import shop.view.ShopLeftView;   import shop.view.ShopRankingView;   import shop.view.ShopRightView;      public class ShopController extends BaseStateView   {                   private var _leftView:ShopLeftView;            private var _view:Sprite;            private var _model:ShopModel;            private var _rightView:ShopRightView;            private var _rankingView:ShopRankingView;            public function ShopController() { super(); }
            public function get leftView() : ShopLeftView { return null; }
            public function get rightView() : ShopRightView { return null; }
            public function get rankingView() : ShopRankingView { return null; }
            public function addTempEquip(item:ShopItemInfo) : Boolean { return false; }
            public function addToCar(item:ShopCarItemInfo) : Boolean { return false; }
            public function buyItems(list:Array, dressing:Boolean, skin:String = "", isBandArr:Array = null) : void { }
            override public function dispose() : void { }
            override public function enter(prev:BaseStateView, data:Object = null) : void { }
            override public function getBackType() : String { return null; }
            override public function getType() : String { return null; }
            override public function getView() : DisplayObject { return null; }
            override public function leaving(next:BaseStateView) : void { }
            public function loadList() : void { }
            public function get model() : ShopModel { return null; }
            public function presentItems(list:Array, msg:String, nick:String) : void { }
            public function removeFromCar(item:ShopCarItemInfo) : void { }
            public function removeTempEquip(item:ShopCarItemInfo) : void { }
            public function restoreAllItemsOnBody() : void { }
            public function revertToDefault() : void { }
            public function setFittingModel(gender:Boolean) : void { }
            public function setSelectedEquip(item:ShopCarItemInfo) : void { }
            public function showPanel(type:uint) : void { }
            public function updateCost() : void { }
            private function init() : void { }
   }}