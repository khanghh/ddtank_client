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
         var _loc2_:int = 0;
         var _loc1_:* = null;
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
         _loc2_ = 0;
         while(_loc2_ < _pointArray.length)
         {
            switch(int(_loc2_))
            {
               case 0:
                  _loc1_ = new StrengthStone(["2","45"],_loc2_);
                  break;
               case 1:
                  _loc1_ = new ExaltItemCell(_loc2_);
            }
            _loc1_.addEventListener("change",__itemInfoChange);
            _items[_loc2_] = _loc1_;
            _loc1_.x = _pointArray[_loc2_].x;
            _loc1_.y = _pointArray[_loc2_].y;
            addChild(_loc1_);
            _loc2_++;
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
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _items.length)
         {
            _items[_loc1_].removeEventListener("change",__itemInfoChange);
            _items[_loc1_].dispose();
            _loc1_++;
         }
         _exaltBtn.removeEventListener("click",__onExaltClick);
         _buyBtn.removeEventListener("click",__onBuyClick);
         _continuous.removeEventListener("click",__continuousClick);
         StrengthDataManager.instance.removeEventListener("exaltFinish",__exaltFinish);
         StrengthDataManager.instance.removeEventListener("exaltFail",__exaltFail);
         _restoreBtn.removeEventListener("click",__onRestoreClick);
      }
      
      protected function __exaltFinish(param1:StoreIIEvent) : void
      {
         showSuccessMovie();
      }
      
      private function __onRestoreClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.store.exaltRestoreAlter",_price),"",LanguageMgr.GetTranslation("cancel"),true,true,false,2);
         _loc2_.addEventListener("response",__onRestoreResponse);
      }
      
      private function __onRestoreResponse(param1:FrameEvent) : void
      {
         e = param1;
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
      
      protected function __exaltFail(param1:StoreIIEvent) : void
      {
         ObjectUtils.disposeObject(_luckyText);
         _luckyText = null;
         _luckyText = ComponentFactory.Instance.creatComponentByStylename("ddt.store.view.exalt.luckyText");
         _luckyText.text = LanguageMgr.GetTranslation("store.view.exalt.luckyTips",int(param1.data));
         var _loc2_:int = _luckyText.width;
         var _loc4_:int = _luckyText.height;
         var _loc3_:int = _luckyText.y;
         _luckyText.width = _luckyText.width / 2;
         _luckyText.height = _luckyText.height / 2;
         _luckyText.alpha = 0.5;
         TweenMax.fromTo(_luckyText,2,{
            "y":_loc3_ - 30,
            "alpha":1,
            "width":_loc2_,
            "height":_loc4_
         },{
            "y":_loc3_ - 60,
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
      
      protected function __frameEvent(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:Disposeable = param1.target as Disposeable;
         _loc2_.dispose();
         _loc2_ = null;
      }
      
      protected function __continuousClick(param1:MouseEvent) : void
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
      
      protected function __onRepeatCount(param1:TimerEvent) : void
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
      
      protected function __onBuyClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         buyRock();
      }
      
      protected function __onExaltClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:int = getTimer();
         if(_loc2_ - _lastExaltTime > 1400)
         {
            _lastExaltTime = _loc2_;
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
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("store.view.exalt.StoreExaltBG.point0");
         _pointArray.push(_loc1_);
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("store.view.exalt.StoreExaltBG.point1");
         _pointArray.push(_loc2_);
      }
      
      protected function __itemInfoChange(param1:Event) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:int = 0;
         if(param1.currentTarget is ExaltItemCell)
         {
            _loc3_ = param1.currentTarget as ExaltItemCell;
            _loc4_ = _loc3_.info as InventoryItemInfo;
            if(_loc4_)
            {
               if(ExaltItemCell(_items[1]).actionState)
               {
                  ExaltItemCell(_items[1]).actionState = false;
               }
               _loc2_ = StoreEquipExperience.expericence[_loc4_.StrengthenLevel + 1];
               if(_loc2_ == 0)
               {
                  _progressBar.progress(0,0);
               }
               else
               {
                  _progressBar.progress(_loc4_.StrengthenExp,_loc2_);
               }
               _restoreBtn.enable = _loc4_.StrengthenExp > 0;
               _price = ServerConfigManager.instance.storeExaltRestorePrice * _loc4_.StrengthenExp;
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
      
      private function __onSuccessMovieComplete(param1:Event) : void
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
      
      private function __onExaltMovieIIComplete(param1:Event) : void
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
         var _loc1_:ShopItemInfo = ShopManager.Instance.getGoodsByTemplateID(11150,1);
         var _loc2_:QuickBuyAlertBase = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickBuyAlert");
         _loc2_.setData(_loc1_.TemplateID,_loc1_.GoodsID,_loc1_.AValue1);
         LayerManager.Instance.addToLayer(_loc2_,3,true,1);
      }
      
      public function dragDrop(param1:BagCell) : void
      {
         var _loc2_:* = null;
         if(param1 == null)
         {
            return;
         }
         var _loc3_:InventoryItemInfo = param1.info as InventoryItemInfo;
         var _loc5_:int = 0;
         var _loc4_:* = _items;
         for each(_loc2_ in _items)
         {
            if(_loc2_.info == _loc3_)
            {
               _loc2_.info = null;
               param1.locked = false;
               return;
            }
         }
         var _loc7_:int = 0;
         var _loc6_:* = _items;
         for each(_loc2_ in _items)
         {
            if(_loc2_)
            {
               if(_loc2_ is StoneCell)
               {
                  if((_loc2_ as StoneCell).types.indexOf(_loc3_.Property1) > -1 && _loc3_.CategoryID == 11)
                  {
                     if(isAdaptToStone(_loc3_))
                     {
                        SocketManager.Instance.out.sendMoveGoods(_loc3_.BagType,_loc3_.Place,12,_loc2_.index,_loc3_.Count,true);
                        return;
                     }
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.strength.typeUnpare"));
                  }
               }
               else if(_loc2_ is ExaltItemCell)
               {
                  if(_loc3_.getRemainDate() <= 0)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.AccessoryDragInArea.overdue"));
                  }
                  else if(param1.info.CanStrengthen && equipisAdapt(_loc3_))
                  {
                     SocketManager.Instance.out.sendMoveGoods(_loc3_.BagType,_loc3_.Place,12,_loc2_.index,1);
                     ExaltItemCell(_items[1]).actionState = true;
                     return;
                  }
               }
            }
         }
         if(EquipType.isExaltStone(_loc3_))
         {
            var _loc9_:int = 0;
            var _loc8_:* = _items;
            for each(_loc2_ in _items)
            {
               if(_loc2_ is StoneCell && (_loc2_ as StoneCell).types.indexOf(_loc3_.Property1) > -1 && _loc3_.CategoryID == 11)
               {
                  if(isAdaptToStone(_loc3_))
                  {
                     SocketManager.Instance.out.sendMoveGoods(_loc3_.BagType,_loc3_.Place,12,_loc2_.index,_loc3_.Count,true);
                     return;
                  }
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.strength.typeUnpare"));
               }
            }
         }
      }
      
      private function showNumAlert(param1:InventoryItemInfo, param2:int) : void
      {
         _aler = ComponentFactory.Instance.creat("store.view.exalt.exaltSelectNumAlertFrame");
         _aler.addExeFunction(sellFunction,notSellFunction);
         _aler.goodsinfo = param1;
         _aler.index = param2;
         _aler.show(param1.Count);
      }
      
      private function sellFunction(param1:int, param2:InventoryItemInfo, param3:int) : void
      {
         SocketManager.Instance.out.sendMoveGoods(param2.BagType,param2.Place,12,param3,param1,true);
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
      
      private function isAdaptToStone(param1:InventoryItemInfo) : Boolean
      {
         if(_items[0].info != null && _items[0].info.Property1 != param1.Property1)
         {
            return false;
         }
         return true;
      }
      
      private function equipisAdapt(param1:InventoryItemInfo) : Boolean
      {
         if(param1.StrengthenLevel >= 15)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.exalt.warningI"));
            return false;
         }
         return true;
      }
      
      public function refreshData(param1:Dictionary) : void
      {
         var _loc2_:* = 0;
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for(_loc2_ in param1)
         {
            if(_items.hasOwnProperty(_loc2_))
            {
               _items[_loc2_].info = PlayerManager.Instance.Self.StoreBag.items[_loc2_];
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
