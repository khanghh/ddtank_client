package store.view.exalt
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.greensock.TweenMax;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyAlertBase;
   import ddt.command.QuickBuyFrame;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import store.IStoreViewBG;
   import store.StoneCell;
   import store.StoreCell;
   import store.StoreDragInArea;
   import store.StrengthDataManager;
   import store.data.StoreEquipExperience;
   import store.events.StoreIIEvent;
   import store.view.strength.StrengthStone;
   
   public class StoreExaltBG extends Sprite implements IStoreViewBG
   {
      
      public static const INTERVAL:int = 1400;
       
      
      private var _titleBG:Bitmap;
      
      private var _buyBtn:SimpleBitmapButton;
      
      private var _exaltBtn:BaseButton;
      
      private var _progressBar:StoreExaltProgressBar;
      
      private var _equipmentCellBg:Image;
      
      private var _goodCellBg:Bitmap;
      
      private var _equipmentCellText:FilterFrameText;
      
      private var _rockText:FilterFrameText;
      
      private var _pointArray:Vector.<Point>;
      
      private var _area:StoreDragInArea;
      
      private var _items:Array;
      
      private var _quick:QuickBuyFrame;
      
      private var _continuous:SelectedCheckButton;
      
      private var _timer:Timer;
      
      private var _helpBtn:BaseButton;
      
      private var _movieI:MovieClip;
      
      private var _movieII:MovieClip;
      
      private var _luckyText:FilterFrameText;
      
      private var _restoreBtn:SimpleBitmapButton;
      
      private var _price:int;
      
      private var _lastExaltTime:int = 0;
      
      private var _aler:ExaltSelectNumAlertFrame;
      
      public function StoreExaltBG()
      {
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         var i:int = 0;
         var item:* = null;
         _titleBG = UICreatShortcut.creatAndAdd("asset.ddtstore.exalt.TitleText",this);
         _buyBtn = UICreatShortcut.creatAndAdd("ddt.store.view.exalt.buyBtn",this);
         _exaltBtn = UICreatShortcut.creatAndAdd("ddt.store.view.exalt.exaltBtn",this);
         _progressBar = UICreatShortcut.creatAndAdd("store.view.exalt.storeExaltProgressBar",this);
         _progressBar.progress(0,0);
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"ddtstore.HelpButton",null,LanguageMgr.GetTranslation("store.StoreExaltBG.say"),"store.view.exalt.HelpBG",404,484,false);
         _continuous = UICreatShortcut.creatAndAdd("ddt.store.view.exalt.SelectedCheckButton",this);
         _continuous.selected = false;
         _equipmentCellBg = UICreatShortcut.creatAndAdd("ddtstore.StoreIIStrengthBG.stoneCellBg",this);
         PositionUtils.setPos(_equipmentCellBg,"ddtstore.StoreIIStrengthBG.EquipmentCellBgPos");
         _equipmentCellText = UICreatShortcut.creatTextAndAdd("ddtstore.StoreIIStrengthBG.StrengthenEquipmentCellText",LanguageMgr.GetTranslation("store.Strength.StrengthenCurrentEquipmentCellText"),this);
         PositionUtils.setPos(_equipmentCellText,"ddtstore.StoreIIStrengthBG.StrengthenEquipmentCellTextPos");
         _goodCellBg = UICreatShortcut.creatAndAdd("asset.ddtstore.GoodPanel",this);
         PositionUtils.setPos(_goodCellBg,"ddtstore.StoreIIStrengthBG.StrengthCellBg1Point");
         _rockText = UICreatShortcut.creatTextAndAdd("ddtstore.StoreIIStrengthBG.GoodCellText",LanguageMgr.GetTranslation("store.Strength.GoodPanelText.StoreExaltRock"),this);
         PositionUtils.setPos(_rockText,"ddtstore.StoreIIStrengthBG.StrengthStoneText1Point");
         _restoreBtn = UICreatShortcut.creatAndAdd("ddtstore.restoreBtn",this);
         _restoreBtn.tipData = LanguageMgr.GetTranslation("ddt.store.exaltRestoreTips");
         _restoreBtn.visible = false;
         getCellsPoint();
         _items = [];
         _area = new StoreDragInArea(_items);
         addChildAt(_area,0);
         for(i = 0; i < _pointArray.length; )
         {
            switch(int(i))
            {
               case 0:
                  item = new StrengthStone(["2","45"],i);
                  break;
               case 1:
                  item = new ExaltItemCell(i);
            }
            item.addEventListener("change",__itemInfoChange);
            _items[i] = item;
            item.x = _pointArray[i].x;
            item.y = _pointArray[i].y;
            addChild(item);
            i++;
         }
      }
      
      private function initEvent() : void
      {
         _exaltBtn.addEventListener("click",__onExaltClick);
         _buyBtn.addEventListener("click",__onBuyClick);
         _continuous.addEventListener("click",__continuousClick);
         StrengthDataManager.instance.addEventListener("exaltFinish",__exaltFinish);
         StrengthDataManager.instance.addEventListener("exaltFail",__exaltFail);
         _restoreBtn.addEventListener("click",__onRestoreClick);
      }
      
      private function removeEvent() : void
      {
         var i:int = 0;
         for(i = 0; i < _items.length; )
         {
            _items[i].removeEventListener("change",__itemInfoChange);
            _items[i].dispose();
            i++;
         }
         _exaltBtn.removeEventListener("click",__onExaltClick);
         _buyBtn.removeEventListener("click",__onBuyClick);
         _continuous.removeEventListener("click",__continuousClick);
         StrengthDataManager.instance.removeEventListener("exaltFinish",__exaltFinish);
         StrengthDataManager.instance.removeEventListener("exaltFail",__exaltFail);
         _restoreBtn.removeEventListener("click",__onRestoreClick);
      }
      
      protected function __exaltFinish(event:StoreIIEvent) : void
      {
         showSuccessMovie();
      }
      
      private function __onRestoreClick(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var frame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.store.exaltRestoreAlter",_price),"",LanguageMgr.GetTranslation("cancel"),true,true,false,2);
         frame.addEventListener("response",__onRestoreResponse);
      }
      
      private function __onRestoreResponse(e:FrameEvent) : void
      {
         e = e;
         var frame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__onRestoreResponse);
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            CheckMoneyUtils.instance.checkMoney(false,_price,function():void
            {
               SocketManager.Instance.out.sendExaltRestore();
            });
         }
         frame.dispose();
      }
      
      protected function __exaltFail(event:StoreIIEvent) : void
      {
         ObjectUtils.disposeObject(_luckyText);
         _luckyText = null;
         _luckyText = ComponentFactory.Instance.creatComponentByStylename("ddt.store.view.exalt.luckyText");
         _luckyText.text = LanguageMgr.GetTranslation("store.view.exalt.luckyTips",int(event.data));
         var tempW:int = _luckyText.width;
         var tempH:int = _luckyText.height;
         var tempY:int = _luckyText.y;
         _luckyText.width = _luckyText.width / 2;
         _luckyText.height = _luckyText.height / 2;
         _luckyText.alpha = 0.5;
         TweenMax.fromTo(_luckyText,2,{
            "y":tempY - 30,
            "alpha":1,
            "width":tempW,
            "height":tempH
         },{
            "y":tempY - 60,
            "alpha":0,
            "width":0,
            "height":0,
            "onComplete":onComplete
         });
         addChild(_luckyText);
         SoundManager.instance.play("171");
         if(_continuous.selected)
         {
            setTimeout(sendExalt,1000);
         }
      }
      
      private function onComplete() : void
      {
         ObjectUtils.disposeObject(_luckyText);
         _luckyText = null;
      }
      
      protected function __frameEvent(event:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var frame:Disposeable = event.target as Disposeable;
         frame.dispose();
         frame = null;
      }
      
      protected function __continuousClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(!_continuous.selected)
         {
            disposeTimer();
         }
      }
      
      private function disposeTimer() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__onRepeatCount);
            _timer = null;
            _exaltBtn.enable = true;
            _restoreBtn.enable = true;
         }
      }
      
      protected function __onRepeatCount(event:TimerEvent) : void
      {
         if(isExalt() && equipisAdapt(_items[1].info))
         {
            sendExalt();
         }
         else
         {
            disposeTimer();
         }
      }
      
      protected function __onBuyClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         buyRock();
      }
      
      protected function __onExaltClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var time:int = getTimer();
         if(time - _lastExaltTime > 1400)
         {
            _lastExaltTime = time;
            sendExalt();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.storeIIStrength.startStrengthClickTimerMsg"));
         }
      }
      
      private function sendContinuousExalt() : void
      {
         if(isExalt())
         {
            if(_continuous.selected)
            {
               _timer = new Timer(1400);
               _timer.addEventListener("timer",__onRepeatCount);
               _timer.start();
               _restoreBtn.enable = false;
               _exaltBtn.enable = false;
            }
            else
            {
               disposeTimer();
            }
         }
      }
      
      private function sendExalt() : void
      {
         if(isExalt())
         {
            SocketManager.Instance.out.sendItemExalt();
            showExaltMovie();
         }
      }
      
      private function isExalt() : Boolean
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return false;
         }
         if(StrengthStone(_items[0]).itemInfo == null || ExaltItemCell(_items[1]).itemInfo == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.exalt.warning"));
            return false;
         }
         if(_items[1].info && _items[1].info.StrengthenLevel >= 15)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.exalt.warningI"));
            return false;
         }
         if(int(_items[0].info.Property3) != 0)
         {
            if(_items[1].info.StrengthenLevel - 11 == int(_items[0].info.Property3))
            {
               return true;
            }
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.exalt.warningII"));
            return false;
         }
         return true;
      }
      
      private function getCellsPoint() : void
      {
         _pointArray = new Vector.<Point>();
         var point:Point = ComponentFactory.Instance.creatCustomObject("store.view.exalt.StoreExaltBG.point0");
         _pointArray.push(point);
         var point2:Point = ComponentFactory.Instance.creatCustomObject("store.view.exalt.StoreExaltBG.point1");
         _pointArray.push(point2);
      }
      
      protected function __itemInfoChange(event:Event) : void
      {
         var itemCell:* = null;
         var info:* = null;
         var max:int = 0;
         if(event.currentTarget is ExaltItemCell)
         {
            itemCell = event.currentTarget as ExaltItemCell;
            info = itemCell.info as InventoryItemInfo;
            if(info)
            {
               if(ExaltItemCell(_items[1]).actionState)
               {
                  ExaltItemCell(_items[1]).actionState = false;
               }
               max = StoreEquipExperience.expericence[info.StrengthenLevel + 1];
               if(max == 0)
               {
                  _progressBar.progress(0,0);
               }
               else
               {
                  _progressBar.progress(info.StrengthenExp,max);
               }
               _restoreBtn.enable = info.StrengthenExp > 0;
               _price = ServerConfigManager.instance.storeExaltRestorePrice * info.StrengthenExp;
            }
            else
            {
               _price = 0;
               _progressBar.progress(0,0);
               _restoreBtn.enable = false;
            }
            dispatchEvent(new Event("change"));
         }
      }
      
      private function showSuccessMovie() : void
      {
         disposeSuccessMovie();
         _movieI = UICreatShortcut.creatAndAdd("asset.ddtstore.exalt.movieI",this);
         _movieI.addEventListener("enterFrame",__onSuccessMovieComplete);
         _movieI.gotoAndPlay(1);
         _restoreBtn.enable = false;
      }
      
      private function __onSuccessMovieComplete(e:Event) : void
      {
         if(_movieI.totalFrames == _movieI.currentFrame)
         {
            disposeSuccessMovie();
         }
      }
      
      private function disposeSuccessMovie() : void
      {
         if(_movieI)
         {
            _movieI.stop();
            _movieI.removeEventListener("enterFrame",__onSuccessMovieComplete);
         }
         ObjectUtils.disposeObject(_movieI);
         _movieI = null;
         _restoreBtn.enable = true;
      }
      
      private function showExaltMovie() : void
      {
         disposeExaltMovie();
         _movieII = UICreatShortcut.creatAndAdd("asset.ddtstore.exalt.movieII",this);
         _movieII.addEventListener("enterFrame",__onExaltMovieIIComplete);
         _movieII.gotoAndPlay(1);
         _restoreBtn.enable = false;
      }
      
      private function disposeExaltMovie() : void
      {
         if(_movieII)
         {
            _movieII.stop();
            _movieII.removeEventListener("enterFrame",__onExaltMovieIIComplete);
         }
         ObjectUtils.disposeObject(_movieII);
         _movieII = null;
         _restoreBtn.enable = true;
      }
      
      private function __onExaltMovieIIComplete(e:Event) : void
      {
         if(_movieII.totalFrames == _movieII.currentFrame)
         {
            disposeExaltMovie();
         }
      }
      
      private function buyRock() : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var shopInfo:ShopItemInfo = ShopManager.Instance.getGoodsByTemplateID(11150,1);
         var quickBuyFrame:QuickBuyAlertBase = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickBuyAlert");
         quickBuyFrame.setData(shopInfo.TemplateID,shopInfo.GoodsID,shopInfo.AValue1);
         LayerManager.Instance.addToLayer(quickBuyFrame,3,true,1);
      }
      
      public function dragDrop(source:BagCell) : void
      {
         var ds:* = null;
         if(source == null)
         {
            return;
         }
         var info:InventoryItemInfo = source.info as InventoryItemInfo;
         var _loc5_:int = 0;
         var _loc4_:* = _items;
         for each(ds in _items)
         {
            if(ds.info == info)
            {
               ds.info = null;
               source.locked = false;
               return;
            }
         }
         var _loc7_:int = 0;
         var _loc6_:* = _items;
         for each(ds in _items)
         {
            if(ds)
            {
               if(ds is StoneCell)
               {
                  if((ds as StoneCell).types.indexOf(info.Property1) > -1 && info.CategoryID == 11)
                  {
                     if(isAdaptToStone(info))
                     {
                        SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,12,ds.index,info.Count,true);
                        return;
                     }
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.strength.typeUnpare"));
                  }
               }
               else if(ds is ExaltItemCell)
               {
                  if(info.getRemainDate() <= 0)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.AccessoryDragInArea.overdue"));
                  }
                  else if(source.info.CanStrengthen && equipisAdapt(info))
                  {
                     SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,12,ds.index,1);
                     ExaltItemCell(_items[1]).actionState = true;
                     return;
                  }
               }
            }
         }
         if(EquipType.isExaltStone(info))
         {
            var _loc9_:int = 0;
            var _loc8_:* = _items;
            for each(ds in _items)
            {
               if(ds is StoneCell && (ds as StoneCell).types.indexOf(info.Property1) > -1 && info.CategoryID == 11)
               {
                  if(isAdaptToStone(info))
                  {
                     SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,12,ds.index,info.Count,true);
                     return;
                  }
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.strength.typeUnpare"));
               }
            }
         }
      }
      
      private function showNumAlert(info:InventoryItemInfo, index:int) : void
      {
         _aler = ComponentFactory.Instance.creat("store.view.exalt.exaltSelectNumAlertFrame");
         _aler.addExeFunction(sellFunction,notSellFunction);
         _aler.goodsinfo = info;
         _aler.index = index;
         _aler.show(info.Count);
      }
      
      private function sellFunction(_nowNum:int, goodsinfo:InventoryItemInfo, index:int) : void
      {
         SocketManager.Instance.out.sendMoveGoods(goodsinfo.BagType,goodsinfo.Place,12,index,_nowNum,true);
         if(_aler)
         {
            _aler.dispose();
         }
         if(_aler && _aler.parent)
         {
            removeChild(_aler);
         }
         _aler = null;
      }
      
      private function notSellFunction() : void
      {
         if(_aler)
         {
            _aler.dispose();
         }
         if(_aler && _aler.parent)
         {
            removeChild(_aler);
         }
         _aler = null;
      }
      
      private function isAdaptToStone(info:InventoryItemInfo) : Boolean
      {
         if(_items[0].info != null && _items[0].info.Property1 != info.Property1)
         {
            return false;
         }
         return true;
      }
      
      private function equipisAdapt(info:InventoryItemInfo) : Boolean
      {
         if(info.StrengthenLevel >= 15)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.exalt.warningI"));
            return false;
         }
         return true;
      }
      
      public function refreshData(items:Dictionary) : void
      {
         var itemPlace:* = 0;
         var _loc5_:int = 0;
         var _loc4_:* = items;
         for(itemPlace in items)
         {
            if(_items.hasOwnProperty(itemPlace))
            {
               _items[itemPlace].info = PlayerManager.Instance.Self.StoreBag.items[itemPlace];
            }
         }
      }
      
      public function updateData() : void
      {
         if(PlayerManager.Instance.Self.StoreBag.items[0] && isAdaptToStone(PlayerManager.Instance.Self.StoreBag.items[0]))
         {
            _items[0].info = PlayerManager.Instance.Self.StoreBag.items[0];
         }
         else
         {
            _items[0].info = null;
         }
         if(PlayerManager.Instance.Self.StoreBag.items[1] && EquipType.isStrengthStone(PlayerManager.Instance.Self.StoreBag.items[1]))
         {
            _items[1].info = PlayerManager.Instance.Self.StoreBag.items[1];
         }
         else
         {
            _items[1].info = null;
         }
      }
      
      public function hide() : void
      {
         this.visible = false;
         _items[0].info = null;
         _items[1].info = null;
         disposeTimer();
      }
      
      public function show() : void
      {
         this.visible = true;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_titleBG);
         _titleBG = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_exaltBtn);
         _exaltBtn = null;
         ObjectUtils.disposeObject(_progressBar);
         _progressBar = null;
         ObjectUtils.disposeObject(_equipmentCellBg);
         _equipmentCellBg = null;
         ObjectUtils.disposeObject(_goodCellBg);
         _goodCellBg = null;
         ObjectUtils.disposeObject(_equipmentCellText);
         _equipmentCellText = null;
         ObjectUtils.disposeObject(_rockText);
         _rockText = null;
         ObjectUtils.disposeObject(_area);
         _area = null;
         ObjectUtils.disposeObject(_quick);
         _quick = null;
         ObjectUtils.disposeObject(_continuous);
         _continuous = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_restoreBtn);
         _restoreBtn = null;
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__onRepeatCount);
            _timer = null;
         }
         _items = null;
      }
   }
}
