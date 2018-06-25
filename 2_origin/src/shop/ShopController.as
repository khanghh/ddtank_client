package shop
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.data.player.PlayerState;
   import ddt.manager.ChatManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.QQtipsManager;
   import ddt.manager.SocketManager;
   import ddt.states.BaseStateView;
   import ddt.view.MainToolBar;
   import ddt.view.chat.ChatBugleView;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import shop.view.ShopLeftView;
   import shop.view.ShopRankingView;
   import shop.view.ShopRightView;
   
   public class ShopController extends BaseStateView
   {
       
      
      private var _leftView:ShopLeftView;
      
      private var _view:Sprite;
      
      private var _model:ShopModel;
      
      private var _rightView:ShopRightView;
      
      private var _rankingView:ShopRankingView;
      
      public function ShopController()
      {
         super();
      }
      
      public function get leftView() : ShopLeftView
      {
         return _leftView;
      }
      
      public function get rightView() : ShopRightView
      {
         return _rightView;
      }
      
      public function get rankingView() : ShopRankingView
      {
         return _rankingView;
      }
      
      public function addTempEquip(item:ShopItemInfo) : Boolean
      {
         var boolean:Boolean = _model.addTempEquip(item);
         showPanel(0);
         return boolean;
      }
      
      public function addToCar(item:ShopCarItemInfo) : Boolean
      {
         _model.addToShoppingCar(item);
         if(_model.isCarListMax())
         {
            return false;
         }
         return true;
      }
      
      public function buyItems(list:Array, dressing:Boolean, skin:String = "", isBandArr:Array = null) : void
      {
         var i:int = 0;
         var t:* = null;
         var items:Array = [];
         var types:Array = [];
         var colors:Array = [];
         var dresses:Array = [];
         var places:Array = [];
         var skins:Array = [];
         var goodsTyps:Array = [];
         for(i = 0; i < list.length; )
         {
            t = list[i];
            items.push(t.GoodsID);
            types.push(t.currentBuyType);
            colors.push(t.Color);
            places.push(t.place);
            if(t.CategoryID == 6)
            {
               skins.push(t.skin);
            }
            else
            {
               skins.push("");
            }
            dresses.push(!!dressing?t.dressing:false);
            goodsTyps.push(t.isDiscount);
            i++;
         }
         SocketManager.Instance.out.sendBuyGoods(items,types,colors,places,dresses,skins,0,goodsTyps,isBandArr);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(_view);
         _model = null;
         _leftView = null;
         _rightView = null;
         _rankingView = null;
         MainToolBar.Instance.hide();
      }
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         super.enter(prev);
         SocketManager.Instance.out.sendCurrentState(1);
         SocketManager.Instance.out.sendUpdateGoodsCount();
         ChatManager.Instance.state = 16;
         ChatBugleView.instance.hide();
         PlayerManager.Instance.Self.playerState = new PlayerState(4,0);
         SocketManager.Instance.out.sendFriendState(PlayerManager.Instance.Self.playerState.StateID);
         init();
         StageReferance.stage.focus = StageReferance.stage;
      }
      
      override public function getBackType() : String
      {
         return "main";
      }
      
      override public function getType() : String
      {
         return "shop";
      }
      
      override public function getView() : DisplayObject
      {
         return _view;
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         dispose();
         PlayerManager.Instance.Self.Bag.unLockAll();
         PlayerManager.Instance.Self.playerState = new PlayerState(1,0);
         SocketManager.Instance.out.sendFriendState(PlayerManager.Instance.Self.playerState.StateID);
         super.leaving(next);
      }
      
      public function loadList() : void
      {
      }
      
      public function get model() : ShopModel
      {
         return _model;
      }
      
      public function presentItems(list:Array, msg:String, nick:String) : void
      {
         var i:int = 0;
         var t:* = null;
         var items:Array = [];
         var types:Array = [];
         var colors:Array = [];
         var skins:Array = [];
         var goodTypes:Array = [];
         for(i = 0; i < list.length; )
         {
            t = list[i];
            items.push(t.GoodsID);
            types.push(t.currentBuyType);
            colors.push(t.Color);
            if(t.CategoryID == 6)
            {
               skins.push(_model.currentModel.Skin);
            }
            else
            {
               skins.push("");
            }
            goodTypes.push(t.isDiscount);
            i++;
         }
         SocketManager.Instance.out.sendPresentGoods(items,types,colors,goodTypes,msg,nick,skins,[]);
      }
      
      public function removeFromCar(item:ShopCarItemInfo) : void
      {
         _model.removeFromShoppingCar(item);
      }
      
      public function removeTempEquip(item:ShopCarItemInfo) : void
      {
         _model.removeTempEquip(item);
      }
      
      public function restoreAllItemsOnBody() : void
      {
         _model.restoreAllItemsOnBody();
      }
      
      public function revertToDefault() : void
      {
         _model.revertToDefalt();
      }
      
      public function setFittingModel(gender:Boolean) : void
      {
         _rightView.setCurrentSex(!!gender?1:2);
         _rightView.loadList();
         _model.fittingSex = gender;
         _leftView.hideLight();
         _leftView.adjustUpperView(0);
         _leftView.refreshCharater();
         _rankingView.loadList();
      }
      
      public function setSelectedEquip(item:ShopCarItemInfo) : void
      {
         _model.setSelectedEquip(item);
      }
      
      public function showPanel(type:uint) : void
      {
         _leftView.adjustUpperView(type);
      }
      
      public function updateCost() : void
      {
         _model.updateCost();
      }
      
      private function init() : void
      {
         _model = new ShopModel();
         _view = new Sprite();
         _rightView = ComponentFactory.Instance.creatCustomObject("ddtshop.RightView");
         _leftView = ComponentFactory.Instance.creatCustomObject("ddtshop.LeftView");
         _rightView.setup(this);
         _leftView.setup(this,_model);
         _view.addChild(_leftView);
         _view.addChild(_rightView);
         MainToolBar.Instance.show();
         MainToolBar.Instance.setShopState();
         if(QQtipsManager.instance.isGotoShop)
         {
            QQtipsManager.instance.isGotoShop = false;
            _rightView.gotoPage(0,QQtipsManager.instance.indexCurrentShop - 1);
         }
         else
         {
            _rightView.gotoPage(ShopRightView.TOP_TYPE,ShopRightView.SUB_TYPE,ShopRightView.CURRENT_PAGE,ShopRightView.CURRENT_GENDER);
         }
         _rankingView = ComponentFactory.Instance.creatCustomObject("ddtshop.RankingView");
         _rankingView.setup(this);
         _view.addChild(_rankingView);
         if(!QQtipsManager.instance.isGotoShop)
         {
            setFittingModel(ShopRightView.CURRENT_GENDER == 1);
         }
      }
   }
}
