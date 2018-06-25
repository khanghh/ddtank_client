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
      
      private function __propertyChange(evt:PlayerPropertyEvent) : void
      {
         if(evt.changedProperties["BandMoney"] || evt.changedProperties["Money"])
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
      
      private function __magicStoneAdd(event:DictionaryEvent) : void
      {
         var item:InventoryItemInfo = InventoryItemInfo(event.data);
         var index:int = (item.Place - 32) / 56 + 1;
         if(index <= 0 || index > 2 || index == curPage)
         {
            return;
         }
         curPage = index;
         _bagList.updateBagList();
      }
      
      protected function __cellClick(event:CellEvent) : void
      {
         var info:* = null;
         event.stopImmediatePropagation();
         var cell:MgStoneCell = event.data as MgStoneCell;
         if(cell)
         {
            info = cell.itemInfo as InventoryItemInfo;
         }
         if(info == null)
         {
            return;
         }
         if(!cell.locked)
         {
            SoundManager.instance.play("008");
            cell.dragStart();
         }
      }
      
      protected function __cellDoubleClick(event:CellEvent) : void
      {
         var info:* = null;
         var i:int = 0;
         var place:int = 0;
         event.stopImmediatePropagation();
         var cell:MgStoneCell = event.data as MgStoneCell;
         if(cell)
         {
            info = cell.itemInfo as InventoryItemInfo;
         }
         if(info == null)
         {
            return;
         }
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var magicStoneBag:BagInfo = PlayerManager.Instance.Self.magicStoneBag;
         for(i = 0; i <= 8; )
         {
            place = MgStoneUtils.getPlace(i);
            if(!magicStoneBag.getItemAt(place))
            {
               SocketManager.Instance.out.moveMagicStone(info.Place,place);
               break;
            }
            i++;
         }
      }
      
      protected function __batCombBtnClick(event:MouseEvent) : void
      {
         var start:int = 0;
         var end:int = 0;
         var i:* = 0;
         var item:* = null;
         var alert:* = null;
         _isSingleFeed = !event;
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
         var completed:int = _updateItem.StrengthenExp;
         var maxLevelNeedExp:int = MagicStoneManager.instance.getNeedExp(_updateItem.TemplateID,10);
         if(!event)
         {
            end = MagicStoneControl.instance.singleFeedCell.itemInfo.Place;
            start = MagicStoneControl.instance.singleFeedCell.itemInfo.Place;
         }
         else
         {
            start = 32 + (_curPage - 1) * 56;
            end = 32 + _curPage * 56 - 1;
         }
         _allExp = 0;
         _combineArr = [];
         _highLevelArr = [];
         for(i = start; i <= end; )
         {
            item = PlayerManager.Instance.Self.magicStoneBag.getItemAt(i);
            if(item && !item.goodsLock)
            {
               if(!(item.Level >= 10 && (int(item.Property3) >= 4 || item.Quality >= 4)))
               {
                  if(int(item.Property3) != 0 && (int(item.Property3) >= 4 && item.Quality > 1 || item.Level >= 7 || item.Quality >= 4 || int(item.Property3) == 3 && item.Quality > 2))
                  {
                     _highLevelArr.push(item);
                  }
                  else
                  {
                     _allExp = _allExp + item.StrengthenExp;
                     _combineArr.push(item.Place);
                     if(_allExp + completed >= maxLevelNeedExp)
                     {
                        break;
                     }
                  }
               }
            }
            i++;
         }
         if(_combineArr.length == 0 && _highLevelArr.length == 0)
         {
            if(_isSingleFeed)
            {
               if(item.goodsLock)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("magicStone.lockedTxt"));
                  return;
               }
               if(item.Level >= 10)
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
            if(_isSingleFeed && completed + item.StrengthenExp >= maxLevelNeedExp)
            {
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("magicStone.feedTip2"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
               alert.addEventListener("response",__onMaxResponse);
               return;
            }
            _isPlayMc = true;
            combineConfirmAlert();
         }
         else if(_highLevelArr.length > 0)
         {
            _isPassExp = _isSingleFeed && completed + item.StrengthenExp >= maxLevelNeedExp;
            highLevelAlert();
         }
      }
      
      protected function maxJudge() : void
      {
         var alert2:* = null;
         if(_isPassExp)
         {
            alert2 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("magicStone.feedTip2"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            alert2.addEventListener("response",__onMaxResponse);
         }
         else
         {
            combineConfirmAlert();
         }
      }
      
      protected function __onMaxResponse(event:FrameEvent) : void
      {
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               event.currentTarget.removeEventListener("response",__onMaxResponse);
               ObjectUtils.disposeObject(event.currentTarget);
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
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.beadSystem.FeedBeadConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
         var showExp:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("magicStone.ensureAlertTxt");
         showExp.htmlText = LanguageMgr.GetTranslation("magicStone.getExp",_allExp);
         alert.addChild(showExp);
         alert.addEventListener("response",__onCombineResponse);
      }
      
      private function highLevelAlert() : void
      {
         var item:InventoryItemInfo = _highLevelArr.pop();
         var completed:int = _updateItem.StrengthenExp;
         var maxLevelNeedExp:int = MagicStoneManager.instance.getNeedExp(_updateItem.TemplateID,10);
         if(completed + _allExp >= maxLevelNeedExp)
         {
            return;
         }
         var promptAlert:BeadFeedInfoFrame = ComponentFactory.Instance.creat("BeadFeedInfoFrame");
         promptAlert.setBeadName(item.Name + "-Lv" + item.Level);
         promptAlert.itemInfo = item;
         LayerManager.Instance.addToLayer(promptAlert,1,true,1);
         promptAlert.textInput.setFocus();
         promptAlert.addEventListener("response",__onConfirmResponse);
      }
      
      protected function __onConfirmResponse(event:FrameEvent) : void
      {
         var alertInfo:BeadFeedInfoFrame = event.currentTarget as BeadFeedInfoFrame;
         SoundManager.instance.playButtonSound();
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               if(alertInfo.textInput.text == "YES" || alertInfo.textInput.text == "yes")
               {
                  _allExp = alertInfo.itemInfo.StrengthenExp;
                  _combineArr = [];
                  _combineArr.push(alertInfo.itemInfo.Place);
                  if(!_isSingleFeed)
                  {
                     combineConfirmAlert();
                  }
                  else
                  {
                     maxJudge();
                  }
                  alertInfo.removeEventListener("response",__onConfirmResponse);
                  ObjectUtils.disposeObject(alertInfo);
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("magicStone.pleaseInputYes"));
               }
         }
      }
      
      protected function __onCombineResponse(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
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
         event.currentTarget.removeEventListener("response",__onCombineResponse);
         ObjectUtils.disposeObject(event.currentTarget);
      }
      
      protected function __disposeCombineLightMC(event:Event) : void
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
         var completed:int = _updateItem.StrengthenExp;
         var needExp:int = MagicStoneManager.instance.getNeedExp(_updateItem.TemplateID,_updateItem.StrengthenLevel + 1);
         if(needExp != 0 && _allExp + completed >= needExp)
         {
            MagicStoneControl.instance.playUpgradeMc();
         }
         if(_isSingleFeed)
         {
            _mgStoneFeedBtn.dragAgain();
         }
      }
      
      protected function __lockBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      protected function __sortBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var mgStoneBag:BagInfo = PlayerManager.Instance.Self.magicStoneBag;
         PlayerManager.Instance.Self.PropBag.sortBag(41,mgStoneBag,32,143);
      }
      
      protected function __prevBtnClick(event:MouseEvent) : void
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
      
      protected function __nextBtnClick(event:MouseEvent) : void
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
      
      public function set curPage(value:int) : void
      {
         _curPage = value;
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
