package store.fineStore.view.pageForge
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyAlertBase;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.data.store.FineSuitVo;
   import ddt.events.BagEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.FineSuitManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import road7th.comm.PackageIn;
   import store.fineStore.view.ForgeEffectItem;
   
   public class FineForgeView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _movieBg:MutipleImage;
      
      private var _infoBg:Bitmap;
      
      private var _titleBg:Bitmap;
      
      private var _progress:MovieClip;
      
      private var _progressText:FilterFrameText;
      
      private var _forgeBtn:BaseButton;
      
      private var _helpBtn:BaseButton;
      
      private var _select:SelectedCheckButton;
      
      private var _hBox:HBox;
      
      private var _materialList:Array;
      
      private var _effect:Sprite;
      
      private var _efListSp:Sprite;
      
      private var _scroll:ScrollPanel;
      
      private var _mouseOver:Sprite;
      
      private var _list:Array;
      
      private var _cell:Array;
      
      private var _index:int = 0;
      
      private var _butImage:Bitmap;
      
      private var _effectList:Array;
      
      private var _forgeAction:MovieClip;
      
      private var _cellAction:MovieClip;
      
      private var order:Array;
      
      private var _progressTips:Component;
      
      private var _forgeProgress:int;
      
      private var _timer:int;
      
      public function FineForgeView()
      {
         order = [0,1,2,3,4,5,11,13,12,16,9,10,7,8];
         super();
         init();
      }
      
      private function init() : void
      {
         var _loc7_:int = 0;
         var _loc8_:* = null;
         var _loc3_:* = null;
         var _loc6_:* = null;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc12_:* = null;
         var _loc1_:* = null;
         _bg = UICreatShortcut.creatAndAdd("store.fineforge.forgeBg",this);
         _movieBg = UICreatShortcut.creatAndAdd("newStore.fineStore.forgeMovieBg",this);
         _infoBg = UICreatShortcut.creatAndAdd("store.fineforge.infoBg",this);
         _titleBg = UICreatShortcut.creatAndAdd("store.fineforge.forgeTitle",this);
         _progress = UICreatShortcut.creatAndAdd("store.fineforge.forgeProgress",this);
         _progress.stop();
         PositionUtils.setPos(_progress,"storeFine.forge.progressPos");
         _progressTips = UICreatShortcut.creatAndAdd("storeFine.progress.tips",this);
         _progressText = UICreatShortcut.creatTextAndAdd("ddtstore.info.StoreStrengthProgressText","0%",_progressTips);
         _forgeBtn = UICreatShortcut.creatAndAdd("storeFine.forge.forgeBtn",this);
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"ddtstore.HelpButton",null,LanguageMgr.GetTranslation("store.view.HelpButtonText"),"store.fineforge.forgeHelp",404,484);
         PositionUtils.setPos(_helpBtn,"storeFine.forge.helpPos");
         _select = UICreatShortcut.creatAndAdd("storeFine.forge.allInject",this);
         var _loc10_:Array = LanguageMgr.GetTranslation("storeFine.cell.titleText").split(",");
         _cell = [];
         _loc7_ = 0;
         while(_loc7_ < 14)
         {
            _loc8_ = PlayerManager.Instance.Self.Bag.getItemAt(order[_loc7_]);
            _loc3_ = new FineForgeCell(1,_loc10_[_loc7_],_loc8_);
            _loc3_.addEventListener("click",__onClickCell);
            _loc3_.setContentSize(46,46);
            PositionUtils.setPos(_loc3_,"storeFine.cellPos" + _loc7_);
            addChild(_loc3_);
            _cell.push(_loc3_);
            _loc7_++;
         }
         updateCellBgView();
         _hBox = UICreatShortcut.creatAndAdd("storeFine.forge.hBox",this);
         addChild(_hBox);
         _materialList = [];
         var _loc5_:Array = FineSuitManager.Instance.materialIDList;
         var _loc13_:Bitmap = ComponentFactory.Instance.creatBitmap("store.fineforge.materialCellBg");
         _loc13_.visible = false;
         var _loc11_:int = needForgeCellId;
         _loc7_ = 0;
         while(_loc7_ < _loc5_.length)
         {
            _loc6_ = new BagCell(_loc7_,ItemManager.Instance.getTemplateById(_loc5_[_loc7_]),true,_loc13_);
            _loc6_.setContentSize(45,45);
            setForgeCellInfo(_loc6_,_loc11_);
            _hBox.addChild(_loc6_);
            _materialList.push(_loc6_);
            _loc7_++;
         }
         _hBox.arrange();
         updateMaterialCount();
         _butImage = UICreatShortcut.creatAndAdd("asset.horse.frame.buyBtn_small",this);
         _butImage.visible = false;
         var _loc9_:Array = getTipsDataListView();
         var _loc14_:Array = LanguageMgr.GetTranslation("storeFine.suit.type").split(",");
         _effect = new Sprite();
         addChild(_effect);
         PositionUtils.setPos(_effect,"storeFine.forge.effectPos");
         _efListSp = new Sprite();
         var _loc15_:int = 0;
         _effectList = [];
         _loc7_ = 0;
         while(_loc7_ < 5)
         {
            _loc2_ = LanguageMgr.GetTranslation("storeFine.effect.titleText",_loc14_[_loc7_]);
            _loc4_ = getforgeEffectState(_loc7_);
            _loc12_ = new ForgeEffectItem(_loc7_,_loc2_,_loc9_[_loc7_],_loc4_);
            _efListSp.addChild(_loc12_);
            _effect.addChild(_loc12_);
            _effectList.push(_loc12_);
            _loc12_.y = _loc15_;
            _loc15_ = _loc12_.y + _loc12_.height - 3;
            _loc7_++;
         }
         _scroll = ComponentFactory.Instance.creatComponentByStylename("storeFine.forge.effect.scrollpanel");
         _scroll.setView(_efListSp);
         _scroll.invalidateViewport();
         _effect.addChild(_scroll);
         _list = [];
         _loc7_ = 0;
         while(_loc7_ < 6)
         {
            _loc1_ = UICreatShortcut.creatAndAdd("storeFine.forge.infoText",_effect);
            _loc1_.x = _loc7_ % 2 == 0?42:Number(177);
            _loc1_.y = Math.ceil((_loc7_ + 1) / 2) * 23 + 270;
            _list.push(_loc1_);
            _loc7_++;
         }
         _mouseOver = new Sprite();
         PositionUtils.setPos(_mouseOver,"forgeMainView.mouseOverPos");
         _mouseOver.graphics.beginFill(0,0);
         _mouseOver.graphics.drawRect(0,0,277,99);
         _mouseOver.graphics.endFill();
         _effect.addChild(_mouseOver);
         _mouseOver.addEventListener("rollOver",onMOOver);
         _mouseOver.addEventListener("rollOut",onMOOut);
         updateInfo();
         updateSuitExp();
         _forgeBtn.addEventListener("click",__onClickForgeBtn);
         _forgeBtn.addEventListener("rollOver",onMOOver);
         _forgeBtn.addEventListener("rollOut",onMOOut);
         SocketManager.Instance.addEventListener(PkgEvent.format(295),__onChangeSuitExp);
         PlayerManager.Instance.Self.getBag(1).addEventListener("update",__onBagUpdate);
      }
      
      protected function onMOOut(param1:MouseEvent) : void
      {
         updateInfo();
      }
      
      protected function onMOOver(param1:MouseEvent) : void
      {
         updateInfoOver();
      }
      
      private function __onCellClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc3_:BagCell = param1.currentTarget as BagCell;
         var _loc2_:ShopItemInfo = ShopManager.Instance.getGoodsByTemplateID(_loc3_.info.TemplateID,1);
         var _loc4_:QuickBuyAlertBase = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickBuyAlert");
         _loc4_.setData(_loc2_.TemplateID,_loc2_.GoodsID,_loc2_.AValue1);
         LayerManager.Instance.addToLayer(_loc4_,3,true,1);
      }
      
      private function __onCellOver(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = param1.currentTarget as DisplayObject;
         _butImage.visible = true;
         _butImage.x = _hBox.x + _loc2_.x + 2;
         _butImage.y = _hBox.y + 25;
      }
      
      private function __onCellOut(param1:MouseEvent) : void
      {
         _butImage.visible = false;
      }
      
      private function forgeResultAction() : void
      {
         if(_index == currentIndex)
         {
            _forgeProgress = forgeProgress;
            if(_forgeProgress > 100)
            {
               _forgeProgress = 100;
            }
         }
         else
         {
            _forgeProgress = 100;
         }
         _progress.addEventListener("enterFrame",__onProgressAction);
         _progress.gotoAndPlay(_progress.currentFrame);
         _progress["star"].gotoAndStop(2);
      }
      
      private function __onProgressAction(param1:Event) : void
      {
         _progressText.text = _progress.currentFrame.toString() + "%";
         if(_progress.currentFrame >= _forgeProgress)
         {
            _progress.removeEventListener("enterFrame",__onProgressAction);
            _progress.gotoAndStop(_forgeProgress);
            _progressText.text = _forgeProgress.toString() + "%";
            _progress["star"].gotoAndStop(1);
            if(_forgeProgress == 100)
            {
               forgeSucceed();
            }
            else
            {
               _forgeBtn.enable = true;
            }
         }
      }
      
      public function forgeSucceed() : void
      {
         var _loc1_:int = 0;
         if(!_forgeAction)
         {
            _forgeAction = UICreatShortcut.creatAndAdd("store.fineforge.forgeAction",this);
            _forgeAction.addEventListener("enterFrame",__onEnterForgeAction);
            _loc1_ = FineSuitManager.Instance.getSuitVoByExp(PlayerManager.Instance.Self.fineSuitExp).type;
            PositionUtils.setPos(_forgeAction,"storeFine.actionPos" + _loc1_);
            _forgeAction.gotoAndPlay(1);
         }
      }
      
      private function __onEnterForgeAction(param1:Event) : void
      {
         var _loc2_:* = null;
         if(_forgeAction.currentFrame == _forgeAction.totalFrames - 1)
         {
            _forgeAction.removeEventListener("enterFrame",__onEnterForgeAction);
            _forgeAction.gotoAndStop(_forgeAction.totalFrames);
            _loc2_ = new Point(currentSelectedCell.x + currentSelectedCell.width / 2,currentSelectedCell.y + currentSelectedCell.height / 2);
            _forgeAction.rotation = Math.atan2(_loc2_.y - _forgeAction.y,_loc2_.x - _forgeAction.x) * 180 / 3.14159265358979 + 90;
            TweenLite.to(_forgeAction,1,{
               "x":_loc2_.x,
               "y":_loc2_.y,
               "onComplete":moveComplete
            });
         }
      }
      
      private function moveComplete() : void
      {
         var _loc1_:* = null;
         disposeForgeAction();
         if(!_cellAction)
         {
            _loc1_ = new Point(currentSelectedCell.x,currentSelectedCell.y);
            _cellAction = UICreatShortcut.creatAndAdd("store.fineforge.cellBgAction",this);
            _cellAction.addEventListener("enterFrame",__onEnterCellAction);
            _cellAction.gotoAndPlay(1);
            PositionUtils.setPos(_cellAction,_loc1_);
         }
      }
      
      private function __onEnterCellAction(param1:Event) : void
      {
         if(_cellAction.currentFrame == _cellAction.totalFrames - 1)
         {
            disposeCellAction();
            updateCellBgView();
            updateSuitExp();
            updateInfo();
            updateTipsData();
            _forgeBtn.enable = true;
         }
      }
      
      private function __onClickForgeBtn(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(getTimer() - _timer < 1000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.storeIIStrength.startStrengthClickTimerMsg"));
            return;
         }
         if(PlayerManager.Instance.Self.fineSuitExp == FineSuitManager.Instance.getSuitVoByLevel(70).exp)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("storeFine.accomplish"));
            return;
         }
         var _loc3_:int = FineSuitManager.Instance.getNextSuitVoByExp(PlayerManager.Instance.Self.fineSuitExp).materialID;
         var _loc2_:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(_loc3_);
         if(_loc2_ <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("storeFine.forgeTips"));
            return;
         }
         _forgeBtn.enable = false;
         _timer = getTimer();
         SocketManager.Instance.out.sendForgeSuit(!!_select.selected?0:1);
      }
      
      private function __onClickCell(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.fineSuitExp == FineSuitManager.Instance.getSuitVoByLevel(70).exp)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("storeFine.accomplish"));
            return;
         }
         var _loc2_:FineForgeCell = param1.currentTarget as FineForgeCell;
         if(!_loc2_.selected)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("storeFine.cell.selectTips",currentSelectedCell.cellName));
         }
      }
      
      private function __onChangeSuitExp(param1:PkgEvent) : void
      {
         var _loc3_:Boolean = false;
         var _loc2_:PackageIn = param1.pkg;
         var _loc4_:int = _loc2_.readByte();
         if(!(int(_loc4_) - 1))
         {
            _loc3_ = _loc2_.readBoolean();
            PlayerManager.Instance.Self.fineSuitExp = _loc2_.readInt();
            updateMaterialCount();
            if(_loc3_)
            {
               forgeResultAction();
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("storeFine.forgeFail"));
            }
         }
      }
      
      private function __onBagUpdate(param1:BagEvent) : void
      {
         updateMaterialCount();
      }
      
      private function updateInfo() : void
      {
         var _loc1_:int = 0;
         var _loc3_:FineSuitVo = FineSuitManager.Instance.getFineSuitPropertyByExp(PlayerManager.Instance.Self.fineSuitExp);
         var _loc2_:Array = [_loc3_.Defence,_loc3_.hp,_loc3_.Luck,_loc3_.Agility,_loc3_.MagicDefence,_loc3_.Armor];
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            _list[_loc1_].text = _loc2_[_loc1_] < 0?0:_loc2_[_loc1_];
            _loc1_++;
         }
      }
      
      private function updateInfoOver() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = PlayerManager.Instance.Self.fineSuitExp;
         var _loc2_:FineSuitVo = FineSuitManager.Instance.getNextLevelSuiteVo(_loc1_);
         if(_loc2_ == null)
         {
            return;
         }
         var _loc6_:FineSuitVo = FineSuitManager.Instance.getFineSuitPropertyByExp(_loc1_);
         var _loc5_:Array = [_loc6_.Defence,_loc6_.hp,_loc6_.Luck,_loc6_.Agility,_loc6_.MagicDefence,_loc6_.Armor];
         var _loc4_:Array = [_loc2_.Defence,_loc2_.hp,_loc2_.Luck,_loc2_.Agility,_loc2_.MagicDefence,_loc2_.Armor];
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _list[_loc3_].htmlText = (_loc5_[_loc3_] < 0?0:_loc5_[_loc3_]) + "<font color=\'#ff0000\'>+" + (_loc4_[_loc3_] < 0?0:_loc4_[_loc3_]) + "</font>";
            _loc3_++;
         }
      }
      
      private function updateSuitExp() : void
      {
         var _loc1_:int = forgeProgress;
         _progress.gotoAndStop(_loc1_);
         _progressText.text = _loc1_ + "%";
      }
      
      private function updateMaterialCount() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc1_:int = 0;
         var _loc2_:int = needForgeCellId;
         _loc4_ = 0;
         while(_loc4_ < _materialList.length)
         {
            _loc3_ = _materialList[_loc4_] as BagCell;
            _loc1_ = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(_loc3_.info.TemplateID);
            _loc3_.setCount(_loc1_);
            setForgeCellInfo(_loc3_,_loc2_);
            _loc4_++;
         }
      }
      
      private function updateCellBgView() : void
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc1_:* = 0;
         var _loc2_:int = currentIndex;
         if(_index == _loc2_ && _index != 0)
         {
            return;
         }
         _index = _loc2_;
         var _loc3_:int = FineSuitManager.Instance.getNextSuitVoByExp(PlayerManager.Instance.Self.fineSuitExp).level;
         var _loc5_:int = (_loc3_ - 1) / 14;
         _loc6_ = 0;
         while(_loc6_ < _cell.length)
         {
            _loc4_ = _cell[_loc6_] as FineForgeCell;
            if(_loc6_ < _index - 1)
            {
               _loc1_ = int(_loc5_ + 1);
            }
            else
            {
               _loc1_ = _loc5_;
            }
            _loc1_++;
            _loc4_.bgType = _loc1_ > 6?6:_loc1_;
            _loc4_.selected = false;
            _loc6_++;
         }
         if(PlayerManager.Instance.Self.fineSuitExp != FineSuitManager.Instance.getSuitVoByLevel(70).exp)
         {
            currentSelectedCell.selected = true;
         }
      }
      
      private function updateTipsData() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _effectList.length)
         {
            _loc1_ = getforgeEffectState(_loc2_);
            ForgeEffectItem(_effectList[_loc2_]).updateTipData(_loc1_);
            _loc2_++;
         }
      }
      
      private function get currentSelectedCell() : FineForgeCell
      {
         return _cell[_index - 1] as FineForgeCell;
      }
      
      private function get currentIndex() : int
      {
         var _loc1_:int = FineSuitManager.Instance.getNextSuitVoByExp(PlayerManager.Instance.Self.fineSuitExp).level;
         _loc1_ = _loc1_ % 14;
         return _loc1_ == 0?14:_loc1_;
      }
      
      private function get needForgeCellId() : int
      {
         var _loc1_:int = FineSuitManager.Instance.getNextSuitVoByExp(PlayerManager.Instance.Self.fineSuitExp).materialID;
         return _loc1_;
      }
      
      private function setForgeCellInfo(param1:BagCell, param2:int) : void
      {
         if(param1.info.TemplateID != param2)
         {
            param1.grayFilters = true;
            param1.removeEventListener("click",__onCellClick);
            param1.removeEventListener("mouseOver",__onCellOver);
            param1.removeEventListener("mouseOut",__onCellOut);
         }
         else
         {
            param1.grayFilters = false;
            param1.buttonMode = true;
            param1.addEventListener("click",__onCellClick);
            param1.addEventListener("mouseOver",__onCellOver);
            param1.addEventListener("mouseOut",__onCellOut);
         }
      }
      
      private function get forgeProgress() : int
      {
         var _loc2_:int = PlayerManager.Instance.Self.fineSuitExp;
         var _loc1_:int = FineSuitManager.Instance.getSuitVoByExp(_loc2_).exp;
         var _loc3_:int = FineSuitManager.Instance.getNextSuitVoByExp(_loc2_).exp;
         _progressTips.tipData = _loc2_ - _loc1_ + "/" + (_loc3_ - _loc1_);
         if(_loc1_ == _loc3_)
         {
            return 100;
         }
         return int((_loc2_ - _loc1_) / (_loc3_ - _loc1_) * 100);
      }
      
      private function getforgeEffectState(param1:int) : int
      {
         var _loc2_:int = FineSuitManager.Instance.getNextSuitVoByExp(PlayerManager.Instance.Self.fineSuitExp).level / 14;
         var _loc3_:int = -1;
         if(_loc2_ < param1)
         {
            _loc3_ = 3;
         }
         else if(_loc2_ == param1)
         {
            _loc3_ = currentIndex == 14?3:2;
         }
         else if(_loc2_ == param1 + 1)
         {
            if(_loc2_ == 5 && currentIndex == 14)
            {
               _loc3_ = 1;
            }
            else
            {
               _loc3_ = currentIndex == 14?2:1;
            }
         }
         else
         {
            _loc3_ = 1;
         }
         return _loc3_;
      }
      
      private function getTipsDataListView() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         _loc2_ = 1;
         while(_loc2_ <= 5)
         {
            _loc1_.push(FineSuitManager.Instance.getTipsPropertyInfoList(_loc2_,"all"));
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function disposeForgeAction() : void
      {
         if(_forgeAction)
         {
            TweenLite.killTweensOf(_forgeAction);
            _forgeAction.stop();
            _forgeAction.removeEventListener("enterFrame",__onEnterForgeAction);
            ObjectUtils.disposeObject(_forgeAction);
            _forgeAction = null;
         }
      }
      
      private function disposeCellAction() : void
      {
         if(_cellAction)
         {
            _cellAction.stop();
            _cellAction.removeEventListener("enterFrame",__onEnterCellAction);
            ObjectUtils.disposeObject(_cellAction);
            _cellAction = null;
         }
      }
      
      private function disposeProgressAction() : void
      {
         if(_progress)
         {
            _progress.stop();
            _progress.removeEventListener("enterFrame",__onProgressAction);
            ObjectUtils.disposeObject(_progress);
            _progress = null;
         }
      }
      
      public function dispose() : void
      {
         var _loc2_:* = null;
         disposeProgressAction();
         disposeForgeAction();
         disposeCellAction();
         if(_mouseOver)
         {
            _mouseOver.removeEventListener("rollOver",onMOOver);
            _mouseOver.removeEventListener("rollOut",onMOOut);
            ObjectUtils.disposeObject(_mouseOver);
            _mouseOver = null;
         }
         ObjectUtils.disposeObject(_scroll);
         _scroll = null;
         ObjectUtils.disposeObject(_efListSp);
         _efListSp = null;
         ObjectUtils.disposeObject(_progressText);
         _progressText = null;
         ObjectUtils.disposeAllChildren(_effect);
         var _loc4_:int = 0;
         var _loc3_:* = _cell;
         for each(var _loc1_ in _cell)
         {
            _loc1_.removeEventListener("click",__onClickCell);
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         _cell = null;
         while(_hBox.numChildren)
         {
            _loc2_ = _hBox.getChildAt(0) as BagCell;
            _loc2_.removeEventListener("click",__onCellClick);
            _loc2_.removeEventListener("mouseOver",__onCellOver);
            _loc2_.removeEventListener("mouseOut",__onCellOut);
            ObjectUtils.disposeObject(_loc2_);
         }
         _forgeBtn.removeEventListener("click",__onClickForgeBtn);
         _forgeBtn.removeEventListener("rollOver",onMOOver);
         _forgeBtn.removeEventListener("rollOut",onMOOut);
         SocketManager.Instance.removeEventListener(PkgEvent.format(295),__onChangeSuitExp);
         PlayerManager.Instance.Self.getBag(1).removeEventListener("update",__onBagUpdate);
         ObjectUtils.disposeAllChildren(this);
         _effectList = null;
         _list = null;
         _hBox = null;
      }
   }
}
