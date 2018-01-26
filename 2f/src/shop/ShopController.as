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
      
      public function ShopController(){super();}
      
      public function get leftView() : ShopLeftView{return null;}
      
      public function get rightView() : ShopRightView{return null;}
      
      public function get rankingView() : ShopRankingView{return null;}
      
      public function addTempEquip(param1:ShopItemInfo) : Boolean{return false;}
      
      public function addToCar(param1:ShopCarItemInfo) : Boolean{return false;}
      
      public function buyItems(param1:Array, param2:Boolean, param3:String = "", param4:Array = null) : void{}
      
      override public function dispose() : void{}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      override public function getBackType() : String{return null;}
      
      override public function getType() : String{return null;}
      
      override public function getView() : DisplayObject{return null;}
      
      override public function leaving(param1:BaseStateView) : void{}
      
      public function loadList() : void{}
      
      public function get model() : ShopModel{return null;}
      
      public function presentItems(param1:Array, param2:String, param3:String) : void{}
      
      public function removeFromCar(param1:ShopCarItemInfo) : void{}
      
      public function removeTempEquip(param1:ShopCarItemInfo) : void{}
      
      public function restoreAllItemsOnBody() : void{}
      
      public function revertToDefault() : void{}
      
      public function setFittingModel(param1:Boolean) : void{}
      
      public function setSelectedEquip(param1:ShopCarItemInfo) : void{}
      
      public function showPanel(param1:uint) : void{}
      
      public function updateCost() : void{}
      
      private function init() : void{}
   }
}
