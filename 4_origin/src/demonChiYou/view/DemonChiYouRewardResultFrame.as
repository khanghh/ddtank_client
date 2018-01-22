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
         var _loc1_:DemonChiYouModel = DemonChiYouManager.instance.model;
         var _loc2_:int = _loc1_.rankInfo.myConsortiaRank;
         if(_loc2_ > 0 && _loc2_ < 4)
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
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc1_:* = null;
         var _loc4_:DemonChiYouModel = DemonChiYouManager.instance.model;
         var _loc3_:Array = _loc4_.shopInfoArr;
         _myGetBagCellHBox.removeAllChild();
         var _loc8_:int = 0;
         if(_resultItemArr)
         {
            var _loc10_:int = 0;
            var _loc9_:* = _resultItemArr;
            for each(var _loc7_ in _resultItemArr)
            {
               ObjectUtils.disposeObject(_loc7_);
            }
         }
         _resultItemArr = [];
         _loc8_ = 0;
         while(_loc8_ < _loc3_.length)
         {
            _loc2_ = _loc3_[_loc8_];
            if(_loc2_["HasBuy"] && PlayerManager.Instance.Self.ID == _loc2_["PlayerId"])
            {
               _loc5_ = _loc2_["InventoryItemInfo"];
               _loc6_ = ComponentFactory.Instance.creatBitmap("asset.horse.frame.itemBg");
               _loc1_ = new BagCell(_loc8_,_loc5_,true,_loc6_,false);
               _loc1_.PicPos = new Point(9,9);
               _loc1_.setContentSize(59,59);
               _loc1_.setCount(_loc5_.Count);
               _loc1_.refreshTbxPos();
               _myGetBagCellHBox.addChild(_loc1_);
            }
            _loc7_ = new RewardResultItem(_loc8_);
            _loc7_.x = 10;
            _loc7_.y = 200 + 32 * _loc8_;
            _resultItemArr.push(_loc7_);
            _container.addChild(_loc7_);
            _loc8_++;
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
      
      private function onClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         DemonChiYouManager.instance.showFrame(3);
      }
      
      private function onBuyItemBack(param1:Event) : void
      {
         updateView();
      }
      
      private function onShopInfoBack(param1:Event) : void
      {
         initView();
         initEvent();
         if(DemonChiYouManager.instance.canBuyItem())
         {
            DemonChiYouManager.instance.showFrame(3);
         }
      }
      
      private function responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
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
