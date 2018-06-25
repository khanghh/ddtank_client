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
      
      public function show(templateIDList:Array, showRadioBtn:Boolean, title:String, panelIndex:int, selectedIndex:int = -1, hSpace:Number = 30, vSpace:Number = 40) : void
      {
         this.titleText = title;
         _showRadioBtn = showRadioBtn;
         _panelIndex = panelIndex;
         _view = ComponentFactory.Instance.creatCustomObject("ddtstore.ShortcutBuyFrame.ShortcutBuyView",[templateIDList,showRadioBtn]);
         escEnable = true;
         enterEnable = true;
         initII();
         initEvents();
         showToLayer();
         relocationView(selectedIndex,hSpace,vSpace);
      }
      
      private function relocationView(selectedIndex:int, hSpace:Number, vSpace:Number) : void
      {
         if(selectedIndex != -1)
         {
            _view.List.selectedIndex = selectedIndex;
         }
         _view.List.list.hSpace = hSpace;
         _view.List.list.vSpace = vSpace;
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
      
      private function _numberClose(e:Event) : void
      {
         ObjectUtils.disposeObject(this);
      }
      
      private function _numberEnter(e:Event) : void
      {
         e.stopImmediatePropagation();
         okFun(null);
      }
      
      private function changeHandler(evt:Event) : void
      {
         okBtn.enable = _view.totalDDTMoney != 0 || _view.totalMoney != 0;
      }
      
      private function _response(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(e.responseCode == 0 || e.responseCode == 1)
         {
            ObjectUtils.disposeObject(this);
         }
         else if(e.responseCode == 2)
         {
            okFun(null);
         }
      }
      
      private function okFun(e:MouseEvent) : void
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
         var i:int = 0;
         var items:Array = [];
         var types:Array = [];
         var colors:Array = [];
         var dresses:Array = [];
         var skins:Array = [];
         var places:Array = [];
         var bands:Array = [];
         var goodsID:int = _view.currentShopItem.GoodsID;
         var num:int = _view.totalNum;
         for(i = 0; i < num; )
         {
            items.push(goodsID);
            types.push(1);
            colors.push("");
            dresses.push(false);
            skins.push("");
            places.push(-1);
            bands.push(CheckMoneyUtils.instance.isBind);
            i++;
         }
         SocketManager.Instance.out.sendBuyGoods(items,types,colors,dresses,skins,places,_panelIndex,null,bands);
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
