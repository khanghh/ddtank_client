package store.view.shortcutBuy
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ShortcutBuyFrame extends Frame
   {
      
      public static const ADDFrameHeight:int = 60;
      
      public static const ADD_OKBTN_Y:int = 53;
       
      
      private var _view:ShortCutBuyView;
      
      private var _panelIndex:int;
      
      private var _showRadioBtn:Boolean;
      
      private var okBtn:TextButton;
      
      public function ShortcutBuyFrame()
      {
         super();
      }
      
      public function show(param1:Array, param2:Boolean, param3:String, param4:int, param5:int = -1, param6:Number = 30, param7:Number = 40) : void
      {
         this.titleText = param3;
         _showRadioBtn = param2;
         _panelIndex = param4;
         _view = ComponentFactory.Instance.creatCustomObject("ddtstore.ShortcutBuyFrame.ShortcutBuyView",[param1,param2]);
         escEnable = true;
         enterEnable = true;
         initII();
         initEvents();
         showToLayer();
         relocationView(param5,param6,param7);
      }
      
      private function relocationView(param1:int, param2:Number, param3:Number) : void
      {
         if(param1 != -1)
         {
            _view.List.selectedIndex = param1;
         }
         _view.List.list.hSpace = param2;
         _view.List.list.vSpace = param3;
      }
      
      private function initII() : void
      {
         _view.addEventListener("change",changeHandler);
         _view.addEventListener("number_close",_numberClose);
         addToContent(_view);
         if(!_showRadioBtn)
         {
            _view.x = _view.x + 5;
         }
         okBtn = ComponentFactory.Instance.creatComponentByStylename("ddtstore.ShortBuyFrameEnter");
         okBtn.text = LanguageMgr.GetTranslation("store.view.shortcutBuy.buyBtn");
         height = _view.height + this._containerY + 60;
         okBtn.y = height - 53;
         addChild(okBtn);
      }
      
      private function initEvents() : void
      {
         addEventListener("response",_response);
         okBtn.addEventListener("click",okFun);
         addEventListener("number_enter",_numberEnter);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",_response);
         okBtn.removeEventListener("click",okFun);
         removeEventListener("number_enter",_numberEnter);
      }
      
      private function _numberClose(param1:Event) : void
      {
         ObjectUtils.disposeObject(this);
      }
      
      private function _numberEnter(param1:Event) : void
      {
         param1.stopImmediatePropagation();
         okFun(null);
      }
      
      private function changeHandler(param1:Event) : void
      {
         okBtn.enable = _view.totalDDTMoney != 0 || _view.totalMoney != 0;
      }
      
      private function _response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            ObjectUtils.disposeObject(this);
         }
         else if(param1.responseCode == 2)
         {
            okFun(null);
         }
      }
      
      private function okFun(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_view.currentShopItem == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionSellView.Choose"));
            _view.List.shine();
            return;
         }
         CheckMoneyUtils.instance.checkMoney(_view.isBand,_view.totalMoney,onCheckComplete);
      }
      
      protected function onCheckComplete() : void
      {
         buyGoods();
         _view.save();
         dispose();
      }
      
      private function buyGoods() : void
      {
         var _loc10_:int = 0;
         var _loc3_:Array = [];
         var _loc8_:Array = [];
         var _loc4_:Array = [];
         var _loc5_:Array = [];
         var _loc9_:Array = [];
         var _loc6_:Array = [];
         var _loc2_:Array = [];
         var _loc7_:int = _view.currentShopItem.GoodsID;
         var _loc1_:int = _view.totalNum;
         _loc10_ = 0;
         while(_loc10_ < _loc1_)
         {
            _loc3_.push(_loc7_);
            _loc8_.push(1);
            _loc4_.push("");
            _loc5_.push(false);
            _loc9_.push("");
            _loc6_.push(-1);
            _loc2_.push(CheckMoneyUtils.instance.isBind);
            _loc10_++;
         }
         SocketManager.Instance.out.sendBuyGoods(_loc3_,_loc8_,_loc4_,_loc5_,_loc9_,_loc6_,_panelIndex,null,_loc2_);
      }
      
      private function showToLayer() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvents();
         _view.removeEventListener("change",changeHandler);
         _view.dispose();
         super.dispose();
         _view = null;
         if(okBtn)
         {
            ObjectUtils.disposeObject(okBtn);
         }
         okBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
