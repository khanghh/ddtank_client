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
      
      public function addTempEquip(param1:ShopItemInfo) : Boolean
      {
         var _loc2_:Boolean = _model.addTempEquip(param1);
         showPanel(0);
         return _loc2_;
      }
      
      public function addToCar(param1:ShopCarItemInfo) : Boolean
      {
         _model.addToShoppingCar(param1);
         if(_model.isCarListMax())
         {
            return false;
         }
         return true;
      }
      
      public function buyItems(param1:Array, param2:Boolean, param3:String = "", param4:Array = null) : void
      {
         var _loc7_:int = 0;
         var _loc9_:* = null;
         var _loc10_:Array = [];
         var _loc12_:Array = [];
         var _loc5_:Array = [];
         var _loc11_:Array = [];
         var _loc6_:Array = [];
         var _loc13_:Array = [];
         var _loc8_:Array = [];
         _loc7_ = 0;
         while(_loc7_ < param1.length)
         {
            _loc9_ = param1[_loc7_];
            _loc10_.push(_loc9_.GoodsID);
            _loc12_.push(_loc9_.currentBuyType);
            _loc5_.push(_loc9_.Color);
            _loc6_.push(_loc9_.place);
            if(_loc9_.CategoryID == 6)
            {
               _loc13_.push(_loc9_.skin);
            }
            else
            {
               _loc13_.push("");
            }
            _loc11_.push(!!param2?_loc9_.dressing:false);
            _loc8_.push(_loc9_.isDiscount);
            _loc7_++;
         }
         SocketManager.Instance.out.sendBuyGoods(_loc10_,_loc12_,_loc5_,_loc6_,_loc11_,_loc13_,0,_loc8_,param4);
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
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         super.enter(param1);
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
      
      override public function leaving(param1:BaseStateView) : void
      {
         dispose();
         PlayerManager.Instance.Self.Bag.unLockAll();
         PlayerManager.Instance.Self.playerState = new PlayerState(1,0);
         SocketManager.Instance.out.sendFriendState(PlayerManager.Instance.Self.playerState.StateID);
         super.leaving(param1);
      }
      
      public function loadList() : void
      {
      }
      
      public function get model() : ShopModel
      {
         return _model;
      }
      
      public function presentItems(param1:Array, param2:String, param3:String) : void
      {
         var _loc10_:int = 0;
         var _loc4_:* = null;
         var _loc5_:Array = [];
         var _loc8_:Array = [];
         var _loc6_:Array = [];
         var _loc9_:Array = [];
         var _loc7_:Array = [];
         _loc10_ = 0;
         while(_loc10_ < param1.length)
         {
            _loc4_ = param1[_loc10_];
            _loc5_.push(_loc4_.GoodsID);
            _loc8_.push(_loc4_.currentBuyType);
            _loc6_.push(_loc4_.Color);
            if(_loc4_.CategoryID == 6)
            {
               _loc9_.push(_model.currentModel.Skin);
            }
            else
            {
               _loc9_.push("");
            }
            _loc7_.push(_loc4_.isDiscount);
            _loc10_++;
         }
         SocketManager.Instance.out.sendPresentGoods(_loc5_,_loc8_,_loc6_,_loc7_,param2,param3,_loc9_,[]);
      }
      
      public function removeFromCar(param1:ShopCarItemInfo) : void
      {
         _model.removeFromShoppingCar(param1);
      }
      
      public function removeTempEquip(param1:ShopCarItemInfo) : void
      {
         _model.removeTempEquip(param1);
      }
      
      public function restoreAllItemsOnBody() : void
      {
         _model.restoreAllItemsOnBody();
      }
      
      public function revertToDefault() : void
      {
         _model.revertToDefalt();
      }
      
      public function setFittingModel(param1:Boolean) : void
      {
         _rightView.setCurrentSex(!!param1?1:2);
         _rightView.loadList();
         _model.fittingSex = param1;
         _leftView.hideLight();
         _leftView.adjustUpperView(0);
         _leftView.refreshCharater();
         _rankingView.loadList();
      }
      
      public function setSelectedEquip(param1:ShopCarItemInfo) : void
      {
         _model.setSelectedEquip(param1);
      }
      
      public function showPanel(param1:uint) : void
      {
         _leftView.adjustUpperView(param1);
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
