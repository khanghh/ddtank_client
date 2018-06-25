package gypsyShop.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import gypsyShop.ctrl.GypsyShopManager;
   import gypsyShop.model.GypsyShopModel;
   import gypsyShop.ui.GypsyItemCell;
   
   public class GypsyShopMainFrame extends Frame implements Disposeable
   {
       
      
      private var _model:GypsyShopModel;
      
      private var _bg:Bitmap;
      
      private var _rareTitle:Bitmap;
      
      private var _coolShiningMCList:Vector.<MovieClip>;
      
      private var _rareList:Vector.<BagCell>;
      
      private var _itemList:Vector.<GypsyItemCell>;
      
      private var _rmbTicketsIcon:Bitmap;
      
      private var _honourIcon:Bitmap;
      
      private var _ticketsBG:Bitmap;
      
      private var _honourBG:Bitmap;
      
      private var _rmbTicketsText:FilterFrameText;
      
      private var _honourText:FilterFrameText;
      
      private var _refreshTimeDetails:FilterFrameText;
      
      private var _refreshBtn:BaseButton;
      
      private var _helpBtn:SimpleBitmapButton;
      
      public function GypsyShopMainFrame()
      {
         super();
      }
      
      public function setModel(modelProxy:GypsyShopModel) : void
      {
         _model = modelProxy;
      }
      
      override protected function init() : void
      {
         var i:int = 0;
         super.init();
         _bg = ComponentFactory.Instance.creatBitmap("gypsy.frame.bg");
         addToContent(_bg);
         _rareTitle = ComponentFactory.Instance.creatBitmap("gypsy.frame.rare.title");
         addToContent(_rareTitle);
         _ticketsBG = ComponentFactory.Instance.creatBitmap("gypsy.money.bg");
         PositionUtils.setPos(_ticketsBG,"gypsy.pt.rmb");
         addToContent(_ticketsBG);
         _rmbTicketsIcon = ComponentFactory.Instance.creatBitmap("gypsy.icon.dianjuanWithBG");
         addToContent(_rmbTicketsIcon);
         _rmbTicketsText = ComponentFactory.Instance.creat("gypsy.textfield.rmbTicketRemain");
         addToContent(_rmbTicketsText);
         _rmbTicketsText.text = "0";
         _honourBG = ComponentFactory.Instance.creatBitmap("gypsy.money.bg");
         PositionUtils.setPos(_honourBG,"gypsy.pt.honour.bg");
         addToContent(_honourBG);
         _honourIcon = ComponentFactory.Instance.creatBitmap("gypsy.icon.honor");
         PositionUtils.setPos(_honourIcon,"gypsy.pt.honour.icon");
         addToContent(_honourIcon);
         _honourText = ComponentFactory.Instance.creat("gypsy.textfield.honourRemain");
         addToContent(_honourText);
         _honourText.text = "0";
         _refreshTimeDetails = ComponentFactory.Instance.creat("gypsy.textfield.timeRefreshDetail");
         addToContent(_refreshTimeDetails);
         _refreshTimeDetails.text = LanguageMgr.GetTranslation("gypsy.refresh.details","18:00");
         _refreshBtn = ComponentFactory.Instance.creat("gypsy.refreshBtn");
         addToContent(_refreshBtn);
         _itemList = new Vector.<GypsyItemCell>();
         for(i = 0; i < 8; )
         {
            _itemList[i] = new GypsyItemCell();
            _itemList[i].x = 27 + 218 * (i % 2);
            _itemList[i].y = 148 + 86 * (int(i / 2));
            addToContent(_itemList[i]);
            i++;
         }
         _helpBtn = ComponentFactory.Instance.creat("gypsy.btn.helpBtn");
         _helpBtn.addEventListener("click",onHelp);
         addToContent(_helpBtn);
         _rareList = new Vector.<BagCell>();
         _coolShiningMCList = new Vector.<MovieClip>();
         _refreshBtn.addEventListener("click",onClick);
         addEventListener("response",_response);
         updateWealth();
      }
      
      private function frameEvent(e:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         ObjectUtils.disposeObject(e.currentTarget);
      }
      
      public function updateNewItemList() : void
      {
         var i:int = 0;
         var len:int = Math.min(8,_model.itemDataList.length);
         for(i = 0; i < _itemList.length; )
         {
            _itemList[i].clear();
            i++;
         }
         for(i = 0; i < len; )
         {
            _itemList[i].updateCell(_model.itemDataList[i]);
            i++;
         }
         updateWealth();
      }
      
      public function updateBuyResult() : void
      {
         var id:int = _model.buyResult.id;
         var _loc4_:int = 0;
         var _loc3_:* = _itemList;
         for each(var item in _itemList)
         {
            if(item.id == id)
            {
               item.updateBuyButtonState(_model.buyResult.canBuy);
            }
         }
         updateWealth();
      }
      
      public function updateRareItemsList() : void
      {
         var i:int = 0;
         var bagCell:* = null;
         var mc:* = null;
         for(i = 0; i < _rareList.length; )
         {
            bagCell = _rareList[i];
            ObjectUtils.disposeObject(bagCell);
            i++;
         }
         _rareList = new Vector.<BagCell>();
         var len:int = _model.listRareItemTempleteIDs.length;
         for(i = 0; i < len; )
         {
            _rareList[i] = new BagCell(0,ItemManager.Instance.getTemplateById(_model.listRareItemTempleteIDs[i]));
            _rareList[i].x = 76 + 56 * i;
            _rareList[i].y = 85;
            addToContent(_rareList[i]);
            mc = ComponentFactory.Instance.creat("asset.core.icon.coolShining");
            mc.mouseChildren = false;
            mc.mouseEnabled = false;
            mc.x = _rareList[i].x - 1;
            mc.y = _rareList[i].y - 1;
            mc.alpha = 0.5;
            addToContent(mc);
            _coolShiningMCList.push(mc);
            i++;
         }
         updateWealth();
      }
      
      private function updateWealth() : void
      {
         _rmbTicketsText.text = PlayerManager.Instance.Self.Money.toString();
         _honourText.text = PlayerManager.Instance.Self.myHonor.toString();
      }
      
      private function _response(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            close();
         }
      }
      
      private function close() : void
      {
         SoundManager.instance.play("008");
         GypsyShopManager.getInstance().hideMainFrame();
      }
      
      protected function onClick(me:MouseEvent) : void
      {
         if(me.target == _refreshBtn)
         {
            GypsyShopManager.getInstance().refreshBtnClicked();
         }
      }
      
      protected function onHelp(me:MouseEvent) : void
      {
         var helpFrame:GypsyHelpFrame = ComponentFactory.Instance.creatComponentByStylename("gypsy.helpFrame");
         helpFrame.addEventListener("response",frameEvent);
         LayerManager.Instance.addToLayer(helpFrame,3,true,1);
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         removeEventListener("response",_response);
         _helpBtn.removeEventListener("click",onHelp);
         _refreshBtn.removeEventListener("click",onClick);
         ObjectUtils.disposeObject(_refreshBtn);
         _refreshBtn = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_rareTitle);
         _rareTitle = null;
         ObjectUtils.disposeObject(_rmbTicketsIcon);
         _rmbTicketsIcon = null;
         ObjectUtils.disposeObject(_rmbTicketsText);
         _rmbTicketsText = null;
         ObjectUtils.disposeObject(_honourBG);
         _honourBG = null;
         ObjectUtils.disposeObject(_honourIcon);
         _honourIcon = null;
         ObjectUtils.disposeObject(_honourText);
         _honourText = null;
         ObjectUtils.disposeObject(_refreshTimeDetails);
         _refreshTimeDetails = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         _itemList.length = 0;
         _itemList = null;
         _rareList.length = 0;
         _rareList = null;
         var len:int = _coolShiningMCList.length;
         for(i = 0; i < len; )
         {
            _coolShiningMCList[i].stop();
            i++;
         }
         _coolShiningMCList.length = 0;
         _coolShiningMCList = null;
         _model = null;
         super.dispose();
      }
   }
}
