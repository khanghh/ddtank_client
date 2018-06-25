package demonChiYou.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import demonChiYou.DemonChiYouController;
   import demonChiYou.DemonChiYouManager;
   import demonChiYou.DemonChiYouModel;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class DemonChiYouRewardResultFrame extends Frame
   {
       
      
      private var _btnHelp:BaseButton;
      
      private var _resultItemArr:Array;
      
      private var _myGetBagCellHBox:HBox;
      
      private var _buyBtn:BaseButton;
      
      public function DemonChiYouRewardResultFrame()
      {
         super();
         addEventListener("response",responseHandler);
         DemonChiYouManager.instance.addEventListener("event_shop_info_back",onShopInfoBack);
         SocketManager.Instance.out.getDemonChiYouRankInfo();
         SocketManager.Instance.out.getDemonChiYouShopInfo();
      }
      
      private function initView() : void
      {
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"core.helpButtonCircle",{
            "x":647,
            "y":36
         },LanguageMgr.GetTranslation("store.view.HelpButtonText"),"Demonchiyou.help",438,550);
         var model:DemonChiYouModel = DemonChiYouManager.instance.model;
         var myConsortiaRank:int = model.rankInfo.myConsortiaRank;
         if(myConsortiaRank > 0 && myConsortiaRank < 4)
         {
            UICreatShortcut.creatAndAdd("demonChiYou.resultTitleImage",_container);
         }
         else
         {
            UICreatShortcut.creatAndAdd("demonChiYou.resultTitleLostImage",_container);
         }
         _myGetBagCellHBox = new HBox();
         _myGetBagCellHBox.spacing = 1;
         _myGetBagCellHBox.y = 96;
         addChild(_myGetBagCellHBox);
         _buyBtn = UICreatShortcut.creatAndAdd("demonChiYou.rewardResult.buyBtn",_container);
         updateView();
      }
      
      private function updateView() : void
      {
         var itemData:* = null;
         var inventoryItemInfo:* = null;
         var bg:* = null;
         var bagCell:* = null;
         var model:DemonChiYouModel = DemonChiYouManager.instance.model;
         var shopInfoArr:Array = model.shopInfoArr;
         _myGetBagCellHBox.removeAllChild();
         var i:int = 0;
         if(_resultItemArr)
         {
            var _loc10_:int = 0;
            var _loc9_:* = _resultItemArr;
            for each(var resultItem in _resultItemArr)
            {
               ObjectUtils.disposeObject(resultItem);
            }
         }
         _resultItemArr = [];
         for(i = 0; i < shopInfoArr.length; )
         {
            itemData = shopInfoArr[i];
            if(itemData["HasBuy"] && PlayerManager.Instance.Self.ID == itemData["PlayerId"])
            {
               inventoryItemInfo = itemData["InventoryItemInfo"];
               bg = ComponentFactory.Instance.creatBitmap("asset.horse.frame.itemBg");
               bagCell = new BagCell(i,inventoryItemInfo,true,bg,false);
               bagCell.PicPos = new Point(9,9);
               bagCell.setContentSize(59,59);
               bagCell.setCount(inventoryItemInfo.Count);
               bagCell.refreshTbxPos();
               _myGetBagCellHBox.addChild(bagCell);
            }
            resultItem = new RewardResultItem(i);
            resultItem.x = 10;
            resultItem.y = 200 + 32 * i;
            _resultItemArr.push(resultItem);
            _container.addChild(resultItem);
            i++;
         }
         _myGetBagCellHBox.x = 344 - _myGetBagCellHBox.width / 2;
         _buyBtn.enable = DemonChiYouManager.instance.canBuyItem();
      }
      
      private function initEvent() : void
      {
         DemonChiYouManager.instance.addEventListener("event_buy_item_back",onBuyItemBack);
         _buyBtn.addEventListener("click",onClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",responseHandler);
         DemonChiYouManager.instance.removeEventListener("event_buy_item_back",onBuyItemBack);
         DemonChiYouManager.instance.removeEventListener("event_shop_info_back",onShopInfoBack);
      }
      
      private function onClick(evt:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         DemonChiYouManager.instance.showFrame(3);
      }
      
      private function onBuyItemBack(evt:Event) : void
      {
         updateView();
      }
      
      private function onShopInfoBack(evt:Event) : void
      {
         initView();
         initEvent();
         if(DemonChiYouManager.instance.canBuyItem())
         {
            DemonChiYouManager.instance.showFrame(3);
         }
      }
      
      private function responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.playButtonSound();
            DemonChiYouController.instance.disposeRewardResultFrame();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         _btnHelp = null;
         _resultItemArr = null;
         _myGetBagCellHBox = null;
         _buyBtn = null;
      }
   }
}
