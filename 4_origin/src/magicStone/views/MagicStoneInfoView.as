package magicStone.views
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.BagEvent;
   import ddt.events.CellEvent;
   import ddt.interfaces.ICell;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.RoomCharacter;
   import ddt.view.tips.OneLineTip;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import game.GameManager;
   import magicStone.MagicStoneControl;
   import magicStone.MagicStoneManager;
   import magicStone.components.EmbedMgStoneCell;
   import magicStone.components.MagicStoneConfirmView;
   import magicStone.components.MagicStoneProgress;
   import magicStone.components.MgStoneCell;
   import magicStone.components.MgStoneUtils;
   import magicStone.event.MagicStoneEvent;
   import magicStone.stoneExploreView.StoneExploreView;
   import playerDress.PlayerDressManager;
   import playerDress.components.DressModel;
   import playerDress.components.DressUtils;
   import playerDress.data.DressVo;
   import road7th.data.DictionaryData;
   import trainer.view.NewHandContainer;
   
   public class MagicStoneInfoView extends Sprite implements Disposeable
   {
      
      private static const CELL_LEN:int = 9;
      
      public static const UPDATE_CELL:int = 31;
       
      
      private var _bg:Bitmap;
      
      private var _lightBg:Bitmap;
      
      private var _whiteStone:Bitmap;
      
      private var _blueStone:Bitmap;
      
      private var _purpleStone:Bitmap;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _covertBtn:TextButton;
      
      private var _exploreBtn:SimpleBitmapButton;
      
      private var _exploreBatBtn:SimpleBitmapButton;
      
      private var _oneLineTip:OneLineTip;
      
      private var _lightFilters:Array;
      
      private var _progress:MagicStoneProgress;
      
      private var _mgStoneCells:Vector.<EmbedMgStoneCell>;
      
      private var _cells:Dictionary;
      
      public var selectedIndex:int;
      
      private var _mgStonebag:BagInfo;
      
      private var _character:RoomCharacter;
      
      private var _currentModel:DressModel;
      
      private var _helpTxt:FilterFrameText;
      
      private var _stoneExploreBtn:SimpleBitmapButton;
      
      private var _stoneExploreView:StoneExploreView;
      
      private var _confirmFrame:BaseAlerFrame;
      
      private var _confirmFrame1:BaseAlerFrame;
      
      public function MagicStoneInfoView()
      {
         super();
         selectedIndex = 1;
         _mgStoneCells = new Vector.<EmbedMgStoneCell>();
         _cells = new Dictionary();
         MagicStoneControl.instance.infoView = this;
         _currentModel = new DressModel();
         updateModel();
         initView();
         initData();
         initEvent();
      }
      
      public function updataCharacter(param1:PlayerInfo) : void
      {
         if(_character)
         {
            _character.dispose();
            _character = null;
         }
         _character = CharactoryFactory.createCharacter(param1,"room") as RoomCharacter;
         _character.showGun = false;
         _character.show(false,-1);
         PositionUtils.setPos(_character,"magicStone.characterPos");
         addChild(_character);
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _bg = ComponentFactory.Instance.creat("magicStone.bg");
         addChild(_bg);
         _lightBg = ComponentFactory.Instance.creat("magicStone.lightBg");
         addChild(_lightBg);
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("magicStone.scoreTxt");
         addChild(_scoreTxt);
         _scoreTxt.text = "12354";
         _covertBtn = ComponentFactory.Instance.creatComponentByStylename("magicStone.covertBtn");
         addChild(_covertBtn);
         _covertBtn.text = LanguageMgr.GetTranslation("magicStone.covertBtnTxt");
         _exploreBtn = ComponentFactory.Instance.creatComponentByStylename("magicStone.exploreBtn");
         addChild(_exploreBtn);
         _exploreBatBtn = ComponentFactory.Instance.creatComponentByStylename("magicStone.exploreBatBtn");
         addChild(_exploreBatBtn);
         _progress = new MagicStoneProgress();
         PositionUtils.setPos(_progress,"magicStone.progressPos");
         addChild(_progress);
         updataCharacter(_currentModel.model);
         _loc3_ = 0;
         while(_loc3_ <= 9 - 1)
         {
            _loc2_ = MgStoneUtils.getPlace(_loc3_);
            _loc1_ = createEmbedMgStoneCell(_loc2_) as EmbedMgStoneCell;
            _loc1_.addEventListener("interactive_click",__cellClickHandler);
            _loc1_.addEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.enableDoubleClick(_loc1_);
            PositionUtils.setPos(_loc1_,"magicStone.mgStoneCellPos" + _loc3_);
            addChild(_loc1_);
            _mgStoneCells.push(_loc1_);
            _cells[_loc2_] = _loc1_;
            _loc3_++;
         }
         _whiteStone = ComponentFactory.Instance.creat("magicStone.white");
         _lightFilters = ComponentFactory.Instance.creatFilters("lightFilter");
         _helpTxt = ComponentFactory.Instance.creatComponentByStylename("magicStone.helpTxt");
         _helpTxt.text = LanguageMgr.GetTranslation("magicStone.helpTxt.LG");
         addChild(_helpTxt);
         _stoneExploreBtn = ComponentFactory.Instance.creatComponentByStylename("magicStone.stoneExploreBtn");
         addChild(_stoneExploreBtn);
         if(GameManager.exploreOver)
         {
            GameManager.exploreOver = false;
            __stoneExploreClick(null);
         }
      }
      
      public function createEmbedMgStoneCell(param1:int = 0, param2:ItemTemplateInfo = null, param3:Boolean = true) : ICell
      {
         var _loc4_:Sprite = new Sprite();
         _loc4_.graphics.beginFill(16777215,0);
         _loc4_.graphics.drawRect(0,0,60,60);
         _loc4_.graphics.endFill();
         var _loc5_:EmbedMgStoneCell = new EmbedMgStoneCell(param1,param2,param3,_loc4_);
         fillTipProp(_loc5_);
         return _loc5_;
      }
      
      private function fillTipProp(param1:ICell) : void
      {
         param1.tipDirctions = "7,6,2,1,5,4,0,3,6";
         param1.tipGapV = 10;
         param1.tipGapH = 10;
         param1.tipStyle = "core.GoodsTip";
      }
      
      public function updateModel() : void
      {
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc11_:int = 0;
         var _loc1_:int = 0;
         var _loc7_:int = 0;
         var _loc10_:int = 0;
         var _loc9_:SelfInfo = PlayerManager.Instance.Self;
         var _loc2_:int = PlayerDressManager.instance.currentIndex;
         if(_loc9_.Sex)
         {
            _currentModel.model.updateStyle(_loc9_.Sex,_loc9_.Hide,DressModel.DEFAULT_MAN_STYLE,",,,,,,","");
         }
         else
         {
            _currentModel.model.updateStyle(_loc9_.Sex,_loc9_.Hide,DressModel.DEFAULT_WOMAN_STYLE,",,,,,,","");
         }
         var _loc4_:DictionaryData = new DictionaryData();
         var _loc8_:Array = PlayerDressManager.instance.modelArr[_loc2_];
         var _loc5_:Boolean = false;
         if(_loc8_)
         {
            _loc11_ = 0;
            while(_loc11_ <= _loc8_.length - 1)
            {
               _loc1_ = (_loc8_[_loc11_] as DressVo).templateId;
               _loc7_ = (_loc8_[_loc11_] as DressVo).itemId;
               _loc3_ = new InventoryItemInfo();
               _loc6_ = _loc9_.Bag.getItemByItemId(_loc7_);
               if(!_loc6_)
               {
                  _loc6_ = _loc9_.Bag.getItemByTemplateId(_loc1_);
                  _loc5_ = true;
               }
               if(_loc6_)
               {
                  _loc3_.setIsUsed(_loc6_.IsUsed);
                  ObjectUtils.copyProperties(_loc3_,_loc6_);
                  _loc10_ = DressUtils.findItemPlace(_loc3_);
                  _loc4_.add(_loc10_,_loc3_);
                  if(_loc3_.CategoryID == 6)
                  {
                     _currentModel.model.Skin = _loc3_.Skin;
                  }
                  _currentModel.model.setPartStyle(_loc3_.CategoryID,_loc3_.NeedSex,_loc3_.TemplateID,_loc3_.Color);
               }
               _loc11_++;
            }
         }
         _currentModel.model.Bag.items = _loc4_;
      }
      
      private function initData() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _mgStonebag = PlayerManager.Instance.Self.magicStoneBag;
         clearCells();
         _loc3_ = 0;
         while(_loc3_ <= 9 - 1)
         {
            _loc2_ = MgStoneUtils.getPlace(_loc3_);
            _loc1_ = _mgStonebag.getItemAt(_loc2_);
            if(_loc1_)
            {
               setCellInfo(_loc1_.Place,_loc1_);
            }
            _loc3_++;
         }
         updateProgress();
      }
      
      private function updateProgress() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         var _loc3_:InventoryItemInfo = _mgStonebag.getItemAt(31);
         if(_loc3_)
         {
            _loc2_ = _loc3_.StrengthenExp - MagicStoneManager.instance.getNeedExp(_loc3_.TemplateID,_loc3_.StrengthenLevel);
            _loc1_ = MagicStoneManager.instance.getNeedExpPerLevel(_loc3_.TemplateID,_loc3_.StrengthenLevel + 1);
            _progress.setData(_loc2_,_loc1_);
         }
         else
         {
            _progress.setData(0,0);
         }
      }
      
      private function clearCells() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ <= 9 - 1)
         {
            _mgStoneCells[_loc1_].info = null;
            _loc1_++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("itemclick",__cellClick);
         _covertBtn.addEventListener("click",__covertBtnClick);
         _exploreBtn.addEventListener("click",__exploreBtnClick);
         _exploreBatBtn.addEventListener("click",__exploreBatBtnClick);
         _stoneExploreBtn.addEventListener("click",__stoneExploreClick);
         PlayerManager.Instance.Self.magicStoneBag.addEventListener("update",__updateGoods);
         MagicStoneControl.instance.addEventListener("showExploreView",__showExploreView);
      }
      
      private function __magicStoneDoubleScore(param1:MagicStoneEvent) : void
      {
      }
      
      protected function __cellClickHandler(param1:InteractiveEvent) : void
      {
         if((param1.currentTarget as BagCell).info != null)
         {
            dispatchEvent(new CellEvent("itemclick",param1.currentTarget,false,false,param1.ctrlKey));
         }
      }
      
      protected function __doubleClickHandler(param1:InteractiveEvent) : void
      {
         var _loc2_:InventoryItemInfo = (param1.currentTarget as BagCell).info as InventoryItemInfo;
         if(_loc2_ != null)
         {
            SoundManager.instance.play("008");
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            if(isBagFull())
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("magicStone.bagFull"));
            }
            else
            {
               SocketManager.Instance.out.moveMagicStone(_loc2_.Place,-1);
            }
         }
      }
      
      private function isBagFull() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 32;
         while(_loc2_ <= 143)
         {
            _loc1_ = _mgStonebag.getItemAt(_loc2_);
            if(!_loc1_)
            {
               return false;
            }
            _loc2_++;
         }
         return true;
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
      
      protected function __updateGoods(param1:BagEvent) : void
      {
         var _loc2_:* = null;
         var _loc4_:Dictionary = param1.changedSlots;
         var _loc6_:int = 0;
         var _loc5_:* = _loc4_;
         for each(var _loc3_ in _loc4_)
         {
            if(_loc3_.Place >= 0 && _loc3_.Place <= 31)
            {
               _loc2_ = _mgStonebag.getItemAt(_loc3_.Place);
               if(_loc2_)
               {
                  setCellInfo(_loc2_.Place,_loc2_);
               }
               else
               {
                  setCellInfo(_loc3_.Place,null);
               }
               MagicStoneManager.instance.removeWeakGuide(2);
               dispatchEvent(new Event("change"));
            }
         }
         updateProgress();
      }
      
      public function setCellInfo(param1:int, param2:InventoryItemInfo) : void
      {
         var _loc3_:String = String(param1);
         if(param2 == null)
         {
            if(_cells[_loc3_])
            {
               _cells[_loc3_].info = null;
            }
            return;
         }
         if(param2.Count == 0)
         {
            _cells[_loc3_].info = null;
         }
         else
         {
            _cells[_loc3_].info = param2;
         }
      }
      
      protected function __covertBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:MagicStoneShopFrame = ComponentFactory.Instance.creatCustomObject("magicStone.magicStoneShopFrame");
         _loc2_.addEventListener("response",__frameEvent);
         _loc2_.show();
      }
      
      protected function __frameEvent(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:Disposeable = param1.target as Disposeable;
         _loc2_.dispose();
         _loc2_ = null;
      }
      
      protected function __exploreBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:int = getNeedMoney();
         if(MagicStoneControl.instance.isNoPrompt)
         {
            if(MagicStoneControl.instance.isBand && PlayerManager.Instance.Self.BandMoney < _loc2_)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("bindMoneyPoorNote"));
               MagicStoneControl.instance.isNoPrompt = false;
            }
            else if(!MagicStoneControl.instance.isBand && PlayerManager.Instance.Self.Money < _loc2_)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("moneyPoorNote"));
               MagicStoneControl.instance.isNoPrompt = false;
            }
            else
            {
               SocketManager.Instance.out.exploreMagicStone(selectedIndex,MagicStoneControl.instance.isBand);
               return;
            }
         }
         _confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("magicStone.exploreConfirmTxt",getNeedMoney()),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"magicStone.confirmView",30,true,1);
         _confirmFrame.moveEnable = false;
         _confirmFrame.addEventListener("response",comfirmHandler,false,0,true);
      }
      
      private function comfirmHandler(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         _confirmFrame.removeEventListener("response",comfirmHandler);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _loc2_ = getNeedMoney();
            CheckMoneyUtils.instance.checkMoney(_confirmFrame.isBand,_loc2_,onCheckComplete);
         }
      }
      
      protected function onCheckComplete() : void
      {
         if((_confirmFrame as MagicStoneConfirmView).isNoPrompt)
         {
            MagicStoneControl.instance.isNoPrompt = true;
            MagicStoneControl.instance.isBand = _confirmFrame.isBand;
         }
         SocketManager.Instance.out.exploreMagicStone(selectedIndex,CheckMoneyUtils.instance.isBind);
      }
      
      public function getNeedMoney() : int
      {
         var _loc1_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc3_:Object = ServerConfigManager.instance.serverConfigInfo["OpenMagicBoxMoney"];
         if(_loc3_)
         {
            _loc1_ = _loc3_.Value;
            if(_loc1_ && _loc1_ != "")
            {
               _loc4_ = _loc1_.split("|");
               if(_loc4_[selectedIndex - 1])
               {
                  _loc2_ = _loc4_[selectedIndex - 1].split(",");
                  return parseInt(_loc2_[0]);
               }
            }
         }
         return 0;
      }
      
      public function getNeedMoney2(param1:int) : int
      {
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc4_:Object = ServerConfigManager.instance.serverConfigInfo["OpenMagicBoxMoney"];
         if(_loc4_)
         {
            _loc2_ = _loc4_.Value;
            if(_loc2_ && _loc2_ != "")
            {
               _loc5_ = _loc2_.split("|");
               if(_loc5_[param1])
               {
                  _loc3_ = _loc5_[param1].split(",");
                  return parseInt(_loc3_[0]);
               }
            }
         }
         return 0;
      }
      
      protected function __exploreBatBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:int = getBagRemain();
         var _loc3_:int = getNeedMoney() * 10;
         if(MagicStoneControl.instance.isBatNoPrompt)
         {
            if(MagicStoneControl.instance.isBatBand && PlayerManager.Instance.Self.BandMoney < _loc3_)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("bindMoneyPoorNote"));
               MagicStoneControl.instance.isBatNoPrompt = false;
            }
            else if(!MagicStoneControl.instance.isBatBand && PlayerManager.Instance.Self.Money < _loc3_)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("moneyPoorNote"));
               MagicStoneControl.instance.isBatNoPrompt = false;
            }
            else
            {
               SocketManager.Instance.out.exploreMagicStone(selectedIndex,MagicStoneControl.instance.isBatBand,10);
               return;
            }
         }
         if(_loc2_ == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("magicStone.bagFull"));
         }
         else
         {
            _confirmFrame1 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("magicStone.exploreConfirmBatTxt",getNeedMoney() * 10),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"magicStone.confirmView",30,true,1);
            _confirmFrame1.moveEnable = false;
            _confirmFrame1.addEventListener("response",confirmBatHandler);
         }
      }
      
      private function confirmBatHandler(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         _confirmFrame1.removeEventListener("response",confirmBatHandler);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _loc2_ = getNeedMoney() * 10;
            CheckMoneyUtils.instance.checkMoney(_confirmFrame1.isBand,_loc2_,onBatCheckComplete);
         }
      }
      
      protected function onBatCheckComplete() : void
      {
         if((_confirmFrame1 as MagicStoneConfirmView).isNoPrompt)
         {
            MagicStoneControl.instance.isBatNoPrompt = true;
            MagicStoneControl.instance.isBatBand = _confirmFrame1.isBand;
         }
         SocketManager.Instance.out.exploreMagicStone(selectedIndex,CheckMoneyUtils.instance.isBind,10);
      }
      
      private function getBagRemain() : int
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:int = 0;
         _loc3_ = 32;
         while(_loc3_ <= 143)
         {
            _loc2_ = _mgStonebag.getItemAt(_loc3_);
            if(!_loc2_)
            {
               _loc1_++;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function __stoneExploreClick(param1:MouseEvent) : void
      {
         SocketManager.Instance.out.sendCheckMagicStoneNumber();
      }
      
      private function __showExploreView(param1:Event) : void
      {
         _stoneExploreView = ComponentFactory.Instance.creatComponentByStylename("MagicStone.StoneExploreViewFrame");
         LayerManager.Instance.addToLayer(_stoneExploreView,3,true,1);
      }
      
      public function updateScore(param1:int) : void
      {
         _scoreTxt.text = param1.toString();
      }
      
      private function removeEvents() : void
      {
         var _loc1_:int = 0;
         removeEventListener("itemclick",__cellClick);
         _covertBtn.removeEventListener("click",__covertBtnClick);
         _exploreBtn.removeEventListener("click",__exploreBtnClick);
         _exploreBatBtn.removeEventListener("click",__exploreBatBtnClick);
         _stoneExploreBtn.removeEventListener("click",__stoneExploreClick);
         PlayerManager.Instance.Self.magicStoneBag.removeEventListener("update",__updateGoods);
         MagicStoneControl.instance.removeEventListener("showExploreView",__showExploreView);
         _loc1_ = 0;
         while(_loc1_ <= _mgStoneCells.length - 1)
         {
            if(_mgStoneCells[_loc1_])
            {
               _mgStoneCells[_loc1_].removeEventListener("interactive_click",__cellClickHandler);
               _mgStoneCells[_loc1_].removeEventListener("interactive_double_click",__doubleClickHandler);
            }
            _loc1_++;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         NewHandContainer.Instance.clearArrowByID(-1);
         MagicStoneControl.instance.infoView = null;
         if(_cells[31] && _cells[31].info)
         {
            if(!isBagFull())
            {
               SocketManager.Instance.out.moveMagicStone(31,-1);
            }
         }
         removeEvents();
         _loc1_ = 0;
         while(_loc1_ <= _mgStoneCells.length - 1)
         {
            ObjectUtils.disposeObject(_mgStoneCells[_loc1_]);
            _mgStoneCells[_loc1_] = null;
            _loc1_++;
         }
         _cells = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_lightBg);
         _lightBg = null;
         ObjectUtils.disposeObject(_whiteStone);
         _whiteStone = null;
         ObjectUtils.disposeObject(_blueStone);
         _blueStone = null;
         ObjectUtils.disposeObject(_purpleStone);
         _purpleStone = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         ObjectUtils.disposeObject(_covertBtn);
         _covertBtn = null;
         ObjectUtils.disposeObject(_exploreBtn);
         _exploreBtn = null;
         ObjectUtils.disposeObject(_exploreBatBtn);
         _exploreBatBtn = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_oneLineTip);
         _oneLineTip = null;
         ObjectUtils.disposeObject(_character);
         _character = null;
      }
   }
}
