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
      
      public function setModel(param1:GypsyShopModel) : void
      {
         _model = param1;
      }
      
      override protected function init() : void
      {
         var _loc1_:int = 0;
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
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            _itemList[_loc1_] = new GypsyItemCell();
            _itemList[_loc1_].x = 27 + 218 * (_loc1_ % 2);
            _itemList[_loc1_].y = 148 + 86 * (int(_loc1_ / 2));
            addToContent(_itemList[_loc1_]);
            _loc1_++;
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
      
      private function frameEvent(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      public function updateNewItemList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = Math.min(8,_model.itemDataList.length);
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            _itemList[_loc2_].clear();
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _itemList[_loc2_].updateCell(_model.itemDataList[_loc2_]);
            _loc2_++;
         }
         updateWealth();
      }
      
      public function updateBuyResult() : void
      {
         var _loc1_:int = _model.buyResult.id;
         var _loc4_:int = 0;
         var _loc3_:* = _itemList;
         for each(var _loc2_ in _itemList)
         {
            if(_loc2_.id == _loc1_)
            {
               _loc2_.updateBuyButtonState(_model.buyResult.canBuy);
            }
         }
         updateWealth();
      }
      
      public function updateRareItemsList() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc2_:* = null;
         _loc4_ = 0;
         while(_loc4_ < _rareList.length)
         {
            _loc1_ = _rareList[_loc4_];
            ObjectUtils.disposeObject(_loc1_);
            _loc4_++;
         }
         _rareList = new Vector.<BagCell>();
         var _loc3_:int = _model.listRareItemTempleteIDs.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _rareList[_loc4_] = new BagCell(0,ItemManager.Instance.getTemplateById(_model.listRareItemTempleteIDs[_loc4_]));
            _rareList[_loc4_].x = 76 + 56 * _loc4_;
            _rareList[_loc4_].y = 85;
            addToContent(_rareList[_loc4_]);
            _loc2_ = ComponentFactory.Instance.creat("asset.core.icon.coolShining");
            _loc2_.mouseChildren = false;
            _loc2_.mouseEnabled = false;
            _loc2_.x = _rareList[_loc4_].x - 1;
            _loc2_.y = _rareList[_loc4_].y - 1;
            _loc2_.alpha = 0.5;
            addToContent(_loc2_);
            _coolShiningMCList.push(_loc2_);
            _loc4_++;
         }
         updateWealth();
      }
      
      private function updateWealth() : void
      {
         _rmbTicketsText.text = PlayerManager.Instance.Self.Money.toString();
         _honourText.text = PlayerManager.Instance.Self.myHonor.toString();
      }
      
      private function _response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            close();
         }
      }
      
      private function close() : void
      {
         SoundManager.instance.play("008");
         GypsyShopManager.getInstance().hideMainFrame();
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         if(param1.target == _refreshBtn)
         {
            GypsyShopManager.getInstance().refreshBtnClicked();
         }
      }
      
      protected function onHelp(param1:MouseEvent) : void
      {
         var _loc2_:GypsyHelpFrame = ComponentFactory.Instance.creatComponentByStylename("gypsy.helpFrame");
         _loc2_.addEventListener("response",frameEvent);
         LayerManager.Instance.addToLayer(_loc2_,3,true,1);
      }
      
      override public function dispose() : void
      {
         var _loc2_:int = 0;
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
         var _loc1_:int = _coolShiningMCList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _coolShiningMCList[_loc2_].stop();
            _loc2_++;
         }
         _coolShiningMCList.length = 0;
         _coolShiningMCList = null;
         _model = null;
         super.dispose();
      }
   }
}
