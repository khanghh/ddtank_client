package magicStone.views
{
   import baglocked.BaglockedManager;
   import beadSystem.views.BeadFeedInfoFrame;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CellEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import magicStone.MagicStoneControl;
   import magicStone.MagicStoneManager;
   import magicStone.components.MgStoneCell;
   import magicStone.components.MgStoneFeedBtn;
   import magicStone.components.MgStoneLockBtn;
   import magicStone.components.MgStoneUtils;
   import road7th.data.DictionaryEvent;
   
   public class MagicStoneBagView extends Sprite implements Disposeable
   {
      
      private static const PAGE_COUNT:int = 2;
       
      
      private var _bg:MutipleImage;
      
      private var _bagList:MagicStoneBagList;
      
      private var _batCombBtn:SimpleBitmapButton;
      
      private var _lockBtn:MgStoneLockBtn;
      
      private var _sortBtn:TextButton;
      
      private var _prevBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageBg:Scale9CornerImage;
      
      private var _pageTxt:FilterFrameText;
      
      private var _moneyBg:ScaleBitmapImage;
      
      private var _bindMoneyBg:ScaleBitmapImage;
      
      private var _moneyIcon:Bitmap;
      
      private var _bindMoneyIcon:Bitmap;
      
      private var _moneyTxt:FilterFrameText;
      
      private var _bindMoneyTxt:FilterFrameText;
      
      private var _combineLightMC:MovieClip;
      
      private var _curPage:int;
      
      private var _combineArr:Array;
      
      private var _highLevelArr:Array;
      
      private var _allExp:int;
      
      private var _isPlayMc:Boolean = false;
      
      private var _updateItem:InventoryItemInfo;
      
      private var _mgStoneFeedBtn:MgStoneFeedBtn;
      
      private var _isSingleFeed:Boolean;
      
      private var _isPassExp:Boolean;
      
      public function MagicStoneBagView()
      {
         _combineArr = [];
         _highLevelArr = [];
         super();
         initView();
         initData();
         initEvents();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("magicStone.bagViewBg");
         addChild(_bg);
         _bagList = new MagicStoneBagList(0,8,56);
         PositionUtils.setPos(_bagList,"magicStone.bagListPos");
         addChild(_bagList);
         _batCombBtn = ComponentFactory.Instance.creatComponentByStylename("magicStone.batCombBtn");
         addChild(_batCombBtn);
         _batCombBtn.tipData = LanguageMgr.GetTranslation("magicStone.batCombineTips");
         _lockBtn = ComponentFactory.Instance.creatComponentByStylename("magicStone.lockBtn");
         addChild(_lockBtn);
         _lockBtn.tipData = LanguageMgr.GetTranslation("magicStone.lockTips");
         _sortBtn = ComponentFactory.Instance.creatComponentByStylename("magicStone.sortBtn");
         _sortBtn.text = LanguageMgr.GetTranslation("ddt.beadSystem.sortBtnTxt");
         addChild(_sortBtn);
         _mgStoneFeedBtn = ComponentFactory.Instance.creatComponentByStylename("MgStoneFeedBtn");
         _mgStoneFeedBtn.width = 106;
         _mgStoneFeedBtn.tipStyle = "ddtstore.StoreEmbedBG.MultipleLineTip";
         _mgStoneFeedBtn.tipData = LanguageMgr.GetTranslation("magicStone.feedTip");
         addChild(_mgStoneFeedBtn);
         _moneyBg = ComponentFactory.Instance.creat("magicStone.momeyBg");
         addChild(_moneyBg);
         _moneyBg.tipData = LanguageMgr.GetTranslation("tank.view.bagII.GoldDirections");
         _bindMoneyBg = ComponentFactory.Instance.creat("magicStone.bindMomeyBg");
         addChild(_bindMoneyBg);
         _bindMoneyBg.tipData = LanguageMgr.GetTranslation("tank.view.bagII.GiftDirections");
         _moneyIcon = ComponentFactory.Instance.creatBitmap("bagAndInfo.info.PointCoupon");
         PositionUtils.setPos(_moneyIcon,"magicStone.moneyIconPos");
         addChild(_moneyIcon);
         _bindMoneyIcon = ComponentFactory.Instance.creatBitmap("bagAndInfo.info.ddtMoney1");
         PositionUtils.setPos(_bindMoneyIcon,"magicStone.bindMoneyIconPos");
         addChild(_bindMoneyIcon);
         _moneyTxt = ComponentFactory.Instance.creatComponentByStylename("BagMoneyInfoText");
         PositionUtils.setPos(_moneyTxt,"magicStone.moneyTxtPos");
         addChild(_moneyTxt);
         _bindMoneyTxt = ComponentFactory.Instance.creatComponentByStylename("BagGiftInfoText");
         PositionUtils.setPos(_bindMoneyTxt,"magicStone.bindMoneyTxtPos");
         addChild(_bindMoneyTxt);
         _prevBtn = ComponentFactory.Instance.creatComponentByStylename("magicStone.prevBtn");
         addChild(_prevBtn);
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("magicStone.nextBtn");
         addChild(_nextBtn);
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("magicStone.pageBG");
         addChild(_pageBg);
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("magicStone.pageTxt");
         addChild(_pageTxt);
         _pageTxt.text = "1/2";
      }
      
      private function initData() : void
      {
         curPage = 1;
         _bagList.setData(PlayerManager.Instance.Self.magicStoneBag);
         updateMoney();
      }
      
      private function initEvents() : void
      {
         PlayerManager.Instance.Self.addEventListener("propertychange",__propertyChange);
         PlayerManager.Instance.Self.magicStoneBag.items.addEventListener("add",__magicStoneAdd);
         _bagList.addEventListener("itemclick",__cellClick);
         _bagList.addEventListener("doubleclick",__cellDoubleClick);
         _batCombBtn.addEventListener("click",__batCombBtnClick);
         _lockBtn.addEventListener("click",__lockBtnClick);
         _sortBtn.addEventListener("click",__sortBtnClick);
         _prevBtn.addEventListener("click",__prevBtnClick);
         _nextBtn.addEventListener("click",__nextBtnClick);
         MagicStoneControl.instance.singleFeedFunc = __batCombBtnClick;
      }
      
      private function __propertyChange(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["BandMoney"] || param1.changedProperties["Money"])
         {
            updateMoney();
         }
      }
      
      private function updateMoney() : void
      {
         if(_moneyTxt)
         {
            _moneyTxt.text = PlayerManager.Instance.Self.Money.toString();
         }
         if(_bindMoneyTxt)
         {
            _bindMoneyTxt.text = PlayerManager.Instance.Self.BandMoney.toString();
         }
      }
      
      private function __magicStoneAdd(param1:DictionaryEvent) : void
      {
         var _loc3_:InventoryItemInfo = InventoryItemInfo(param1.data);
         var _loc2_:int = (_loc3_.Place - 32) / 56 + 1;
         if(_loc2_ <= 0 || _loc2_ > 2 || _loc2_ == curPage)
         {
            return;
         }
         curPage = _loc2_;
         _bagList.updateBagList();
      }
      
      protected function __cellClick(param1:CellEvent) : void
      {
         var _loc3_:* = null;
         param1.stopImmediatePropagation();
         var _loc2_:MgStoneCell = param1.data as MgStoneCell;
         if(_loc2_)
         {
            _loc3_ = _loc2_.itemInfo as InventoryItemInfo;
         }
         if(_loc3_ == null)
         {
            return;
         }
         if(!_loc2_.locked)
         {
            SoundManager.instance.play("008");
            _loc2_.dragStart();
         }
      }
      
      protected function __cellDoubleClick(param1:CellEvent) : void
      {
         var _loc6_:* = null;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         param1.stopImmediatePropagation();
         var _loc3_:MgStoneCell = param1.data as MgStoneCell;
         if(_loc3_)
         {
            _loc6_ = _loc3_.itemInfo as InventoryItemInfo;
         }
         if(_loc6_ == null)
         {
            return;
         }
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:BagInfo = PlayerManager.Instance.Self.magicStoneBag;
         _loc5_ = 0;
         while(_loc5_ <= 8)
         {
            _loc4_ = MgStoneUtils.getPlace(_loc5_);
            if(!_loc2_.getItemAt(_loc4_))
            {
               SocketManager.Instance.out.moveMagicStone(_loc6_.Place,_loc4_);
               break;
            }
            _loc5_++;
         }
      }
      
      protected function __batCombBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:* = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         _isSingleFeed = !param1;
         SoundManager.instance.play("008");
         _updateItem = PlayerManager.Instance.Self.magicStoneBag.getItemAt(31);
         if(!_updateItem)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("magicStone.updateCellEmpty"));
            return;
         }
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_updateItem.Level >= 10)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("magicStone.updateCellMaxLevel"));
            return;
         }
         var _loc8_:int = _updateItem.StrengthenExp;
         var _loc5_:int = MagicStoneManager.instance.getNeedExp(_updateItem.TemplateID,10);
         if(!param1)
         {
            _loc6_ = MagicStoneControl.instance.singleFeedCell.itemInfo.Place;
            _loc2_ = MagicStoneControl.instance.singleFeedCell.itemInfo.Place;
         }
         else
         {
            _loc2_ = 32 + (_curPage - 1) * 56;
            _loc6_ = 32 + _curPage * 56 - 1;
         }
         _allExp = 0;
         _combineArr = [];
         _highLevelArr = [];
         _loc7_ = _loc2_;
         while(_loc7_ <= _loc6_)
         {
            _loc4_ = PlayerManager.Instance.Self.magicStoneBag.getItemAt(_loc7_);
            if(_loc4_ && !_loc4_.goodsLock)
            {
               if(!(_loc4_.Level >= 10 && (int(_loc4_.Property3) >= 4 || _loc4_.Quality >= 4)))
               {
                  if(int(_loc4_.Property3) != 0 && (int(_loc4_.Property3) >= 4 && _loc4_.Quality > 1 || _loc4_.Level >= 7 || _loc4_.Quality >= 4 || int(_loc4_.Property3) == 3 && _loc4_.Quality > 2))
                  {
                     _highLevelArr.push(_loc4_);
                  }
                  else
                  {
                     _allExp = _allExp + _loc4_.StrengthenExp;
                     _combineArr.push(_loc4_.Place);
                     if(_allExp + _loc8_ >= _loc5_)
                     {
                        break;
                     }
                  }
               }
            }
            _loc7_++;
         }
         if(_combineArr.length == 0 && _highLevelArr.length == 0)
         {
            if(_isSingleFeed)
            {
               if(_loc4_.goodsLock)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("magicStone.lockedTxt"));
                  return;
               }
               if(_loc4_.Level >= 10)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("magicStone.judgeFeedLevel"));
                  return;
               }
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("magicStone.bagEmpty"));
               return;
            }
         }
         else if(_combineArr.length > 0)
         {
            if(_isSingleFeed && _loc8_ + _loc4_.StrengthenExp >= _loc5_)
            {
               _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("magicStone.feedTip2"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
               _loc3_.addEventListener("response",__onMaxResponse);
               return;
            }
            _isPlayMc = true;
            combineConfirmAlert();
         }
         else if(_highLevelArr.length > 0)
         {
            _isPassExp = _isSingleFeed && _loc8_ + _loc4_.StrengthenExp >= _loc5_;
            highLevelAlert();
         }
      }
      
      protected function maxJudge() : void
      {
         var _loc1_:* = null;
         if(_isPassExp)
         {
            _loc1_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("magicStone.feedTip2"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            _loc1_.addEventListener("response",__onMaxResponse);
         }
         else
         {
            combineConfirmAlert();
         }
      }
      
      protected function __onMaxResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               param1.currentTarget.removeEventListener("response",__onMaxResponse);
               ObjectUtils.disposeObject(param1.currentTarget);
               break;
            case 2:
            case 3:
            case 4:
               _isPlayMc = true;
               combineConfirmAlert();
         }
      }
      
      private function combineConfirmAlert() : void
      {
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.beadSystem.FeedBeadConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
         var _loc1_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("magicStone.ensureAlertTxt");
         _loc1_.htmlText = LanguageMgr.GetTranslation("magicStone.getExp",_allExp);
         _loc2_.addChild(_loc1_);
         _loc2_.addEventListener("response",__onCombineResponse);
      }
      
      private function highLevelAlert() : void
      {
         var _loc2_:InventoryItemInfo = _highLevelArr.pop();
         var _loc4_:int = _updateItem.StrengthenExp;
         var _loc3_:int = MagicStoneManager.instance.getNeedExp(_updateItem.TemplateID,10);
         if(_loc4_ + _allExp >= _loc3_)
         {
            return;
         }
         var _loc1_:BeadFeedInfoFrame = ComponentFactory.Instance.creat("BeadFeedInfoFrame");
         _loc1_.setBeadName(_loc2_.Name + "-Lv" + _loc2_.Level);
         _loc1_.itemInfo = _loc2_;
         LayerManager.Instance.addToLayer(_loc1_,1,true,1);
         _loc1_.textInput.setFocus();
         _loc1_.addEventListener("response",__onConfirmResponse);
      }
      
      protected function __onConfirmResponse(param1:FrameEvent) : void
      {
         var _loc2_:BeadFeedInfoFrame = param1.currentTarget as BeadFeedInfoFrame;
         SoundManager.instance.playButtonSound();
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               if(_loc2_.textInput.text == "YES" || _loc2_.textInput.text == "yes")
               {
                  _allExp = _loc2_.itemInfo.StrengthenExp;
                  _combineArr = [];
                  _combineArr.push(_loc2_.itemInfo.Place);
                  if(!_isSingleFeed)
                  {
                     combineConfirmAlert();
                  }
                  else
                  {
                     maxJudge();
                  }
                  _loc2_.removeEventListener("response",__onConfirmResponse);
                  ObjectUtils.disposeObject(_loc2_);
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("magicStone.pleaseInputYes"));
               }
         }
      }
      
      protected function __onCombineResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               if(_isPlayMc)
               {
                  _isPlayMc = false;
                  break;
               }
               if(!_isSingleFeed && _highLevelArr.length > 0)
               {
                  highLevelAlert();
               }
               break;
            case 2:
            case 3:
            case 4:
               if(_isPlayMc)
               {
                  if(!_combineLightMC)
                  {
                     KeyboardShortcutsManager.Instance.forbiddenFull();
                     _combineLightMC = ComponentFactory.Instance.creat("magicStone.combineLightMc");
                     _combineLightMC.gotoAndPlay(1);
                     var _loc2_:* = 0.9;
                     _combineLightMC.scaleY = _loc2_;
                     _combineLightMC.scaleX = _loc2_;
                     _combineLightMC.x = 748;
                     _combineLightMC.y = 287;
                     _combineLightMC.addEventListener("enterFrame",__disposeCombineLightMC);
                     LayerManager.Instance.addToLayer(_combineLightMC,0,false,1,true);
                  }
                  break;
               }
               updateMagicStone();
               if(_highLevelArr.length > 0)
               {
                  highLevelAlert();
                  break;
               }
               break;
         }
         param1.currentTarget.removeEventListener("response",__onCombineResponse);
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      protected function __disposeCombineLightMC(param1:Event) : void
      {
         if(_combineLightMC.currentFrame == _combineLightMC.totalFrames)
         {
            _combineLightMC.gotoAndStop(1);
            _combineLightMC.removeEventListener("enterFrame",__disposeCombineLightMC);
            ObjectUtils.disposeObject(_combineLightMC);
            _combineLightMC = null;
            _isPlayMc = false;
            KeyboardShortcutsManager.Instance.cancelForbidden();
            updateMagicStone();
            if(_highLevelArr.length > 0)
            {
               highLevelAlert();
            }
         }
      }
      
      private function updateMagicStone() : void
      {
         SocketManager.Instance.out.updateMagicStone(_combineArr);
         var _loc2_:int = _updateItem.StrengthenExp;
         var _loc1_:int = MagicStoneManager.instance.getNeedExp(_updateItem.TemplateID,_updateItem.StrengthenLevel + 1);
         if(_loc1_ != 0 && _allExp + _loc2_ >= _loc1_)
         {
            MagicStoneControl.instance.playUpgradeMc();
         }
         if(_isSingleFeed)
         {
            _mgStoneFeedBtn.dragAgain();
         }
      }
      
      protected function __lockBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      protected function __sortBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BagInfo = PlayerManager.Instance.Self.magicStoneBag;
         PlayerManager.Instance.Self.PropBag.sortBag(41,_loc2_,32,143);
      }
      
      protected function __prevBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(curPage > 1)
         {
            curPage = Number(curPage) - 1;
         }
         else
         {
            curPage = 2;
         }
         _bagList.updateBagList();
      }
      
      protected function __nextBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(curPage < 2)
         {
            curPage = Number(curPage) + 1;
         }
         else
         {
            curPage = 1;
         }
         _bagList.updateBagList();
      }
      
      public function get curPage() : int
      {
         return _curPage;
      }
      
      public function set curPage(param1:int) : void
      {
         _curPage = param1;
         _bagList.curPage = _curPage;
         _pageTxt.text = _curPage + "/" + 2;
      }
      
      private function removeEvents() : void
      {
         PlayerManager.Instance.Self.removeEventListener("propertychange",__propertyChange);
         PlayerManager.Instance.Self.magicStoneBag.items.removeEventListener("add",__magicStoneAdd);
         _bagList.removeEventListener("itemclick",__cellClick);
         _bagList.removeEventListener("doubleclick",__cellDoubleClick);
         _batCombBtn.removeEventListener("click",__batCombBtnClick);
         _lockBtn.removeEventListener("click",__lockBtnClick);
         _sortBtn.removeEventListener("click",__sortBtnClick);
         _prevBtn.removeEventListener("click",__prevBtnClick);
         _nextBtn.removeEventListener("click",__nextBtnClick);
         MagicStoneControl.instance.singleFeedFunc = null;
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_bagList);
         _bagList = null;
         ObjectUtils.disposeObject(_batCombBtn);
         _batCombBtn = null;
         ObjectUtils.disposeObject(_lockBtn);
         _lockBtn = null;
         ObjectUtils.disposeObject(_sortBtn);
         _sortBtn = null;
         ObjectUtils.disposeObject(_prevBtn);
         _prevBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_pageBg);
         _pageBg = null;
         ObjectUtils.disposeObject(_pageTxt);
         _pageTxt = null;
         ObjectUtils.disposeObject(_moneyBg);
         _moneyBg = null;
         ObjectUtils.disposeObject(_moneyIcon);
         _moneyIcon = null;
         ObjectUtils.disposeObject(_moneyTxt);
         _moneyTxt = null;
         ObjectUtils.disposeObject(_bindMoneyBg);
         _bindMoneyBg = null;
         ObjectUtils.disposeObject(_bindMoneyIcon);
         _bindMoneyIcon = null;
         ObjectUtils.disposeObject(_bindMoneyTxt);
         _bindMoneyTxt = null;
         ObjectUtils.disposeObject(_mgStoneFeedBtn);
         _mgStoneFeedBtn = null;
      }
   }
}
