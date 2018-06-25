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
         var i:int = 0;
         var info:* = null;
         var cell:* = null;
         var material:* = null;
         var titleName:* = null;
         var itemState:int = 0;
         var item:* = null;
         var text:* = null;
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
         var title:Array = LanguageMgr.GetTranslation("storeFine.cell.titleText").split(",");
         _cell = [];
         for(i = 0; i < 14; )
         {
            info = PlayerManager.Instance.Self.Bag.getItemAt(order[i]);
            cell = new FineForgeCell(1,title[i],info);
            cell.addEventListener("click",__onClickCell);
            cell.setContentSize(46,46);
            PositionUtils.setPos(cell,"storeFine.cellPos" + i);
            addChild(cell);
            _cell.push(cell);
            i++;
         }
         updateCellBgView();
         _hBox = UICreatShortcut.creatAndAdd("storeFine.forge.hBox",this);
         addChild(_hBox);
         _materialList = [];
         var idList:Array = FineSuitManager.Instance.materialIDList;
         var cellBg:Bitmap = ComponentFactory.Instance.creatBitmap("store.fineforge.materialCellBg");
         cellBg.visible = false;
         var needForgeId:int = needForgeCellId;
         for(i = 0; i < idList.length; )
         {
            material = new BagCell(i,ItemManager.Instance.getTemplateById(idList[i]),true,cellBg);
            material.setContentSize(45,45);
            setForgeCellInfo(material,needForgeId);
            _hBox.addChild(material);
            _materialList.push(material);
            i++;
         }
         _hBox.arrange();
         updateMaterialCount();
         _butImage = UICreatShortcut.creatAndAdd("asset.horse.frame.buyBtn_small",this);
         _butImage.visible = false;
         var dataList:Array = getTipsDataListView();
         var suitType:Array = LanguageMgr.GetTranslation("storeFine.suit.type").split(",");
         _effect = new Sprite();
         addChild(_effect);
         PositionUtils.setPos(_effect,"storeFine.forge.effectPos");
         _efListSp = new Sprite();
         var currentY:int = 0;
         _effectList = [];
         for(i = 0; i < 5; )
         {
            titleName = LanguageMgr.GetTranslation("storeFine.effect.titleText",suitType[i]);
            itemState = getforgeEffectState(i);
            item = new ForgeEffectItem(i,titleName,dataList[i],itemState);
            _efListSp.addChild(item);
            _effect.addChild(item);
            _effectList.push(item);
            item.y = currentY;
            currentY = item.y + item.height - 3;
            i++;
         }
         _scroll = ComponentFactory.Instance.creatComponentByStylename("storeFine.forge.effect.scrollpanel");
         _scroll.setView(_efListSp);
         _scroll.invalidateViewport();
         _effect.addChild(_scroll);
         _list = [];
         for(i = 0; i < 6; )
         {
            text = UICreatShortcut.creatAndAdd("storeFine.forge.infoText",_effect);
            text.x = i % 2 == 0?42:Number(177);
            text.y = Math.ceil((i + 1) / 2) * 23 + 270;
            _list.push(text);
            i++;
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
      
      protected function onMOOut(e:MouseEvent) : void
      {
         updateInfo();
      }
      
      protected function onMOOver(e:MouseEvent) : void
      {
         updateInfoOver();
      }
      
      private function __onCellClick(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var cell:BagCell = e.currentTarget as BagCell;
         var shopInfo:ShopItemInfo = ShopManager.Instance.getGoodsByTemplateID(cell.info.TemplateID,1);
         var quickBuyFrame:QuickBuyAlertBase = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickBuyAlert");
         quickBuyFrame.setData(shopInfo.TemplateID,shopInfo.GoodsID,shopInfo.AValue1);
         LayerManager.Instance.addToLayer(quickBuyFrame,3,true,1);
      }
      
      private function __onCellOver(e:MouseEvent) : void
      {
         var display:DisplayObject = e.currentTarget as DisplayObject;
         _butImage.visible = true;
         _butImage.x = _hBox.x + display.x + 2;
         _butImage.y = _hBox.y + 25;
      }
      
      private function __onCellOut(e:MouseEvent) : void
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
      
      private function __onProgressAction(e:Event) : void
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
         var type:int = 0;
         if(!_forgeAction)
         {
            _forgeAction = UICreatShortcut.creatAndAdd("store.fineforge.forgeAction",this);
            _forgeAction.addEventListener("enterFrame",__onEnterForgeAction);
            type = FineSuitManager.Instance.getSuitVoByExp(PlayerManager.Instance.Self.fineSuitExp).type;
            PositionUtils.setPos(_forgeAction,"storeFine.actionPos" + type);
            _forgeAction.gotoAndPlay(1);
         }
      }
      
      private function __onEnterForgeAction(e:Event) : void
      {
         var pos:* = null;
         if(_forgeAction.currentFrame == _forgeAction.totalFrames - 1)
         {
            _forgeAction.removeEventListener("enterFrame",__onEnterForgeAction);
            _forgeAction.gotoAndStop(_forgeAction.totalFrames);
            pos = new Point(currentSelectedCell.x + currentSelectedCell.width / 2,currentSelectedCell.y + currentSelectedCell.height / 2);
            _forgeAction.rotation = Math.atan2(pos.y - _forgeAction.y,pos.x - _forgeAction.x) * 180 / 3.14159265358979 + 90;
            TweenLite.to(_forgeAction,1,{
               "x":pos.x,
               "y":pos.y,
               "onComplete":moveComplete
            });
         }
      }
      
      private function moveComplete() : void
      {
         var pos:* = null;
         disposeForgeAction();
         if(!_cellAction)
         {
            pos = new Point(currentSelectedCell.x,currentSelectedCell.y);
            _cellAction = UICreatShortcut.creatAndAdd("store.fineforge.cellBgAction",this);
            _cellAction.addEventListener("enterFrame",__onEnterCellAction);
            _cellAction.gotoAndPlay(1);
            PositionUtils.setPos(_cellAction,pos);
         }
      }
      
      private function __onEnterCellAction(e:Event) : void
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
      
      private function __onClickForgeBtn(e:MouseEvent) : void
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
         var materialID:int = FineSuitManager.Instance.getNextSuitVoByExp(PlayerManager.Instance.Self.fineSuitExp).materialID;
         var count:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(materialID);
         if(count <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("storeFine.forgeTips"));
            return;
         }
         _forgeBtn.enable = false;
         _timer = getTimer();
         SocketManager.Instance.out.sendForgeSuit(!!_select.selected?0:1);
      }
      
      private function __onClickCell(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.fineSuitExp == FineSuitManager.Instance.getSuitVoByLevel(70).exp)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("storeFine.accomplish"));
            return;
         }
         var cell:FineForgeCell = e.currentTarget as FineForgeCell;
         if(!cell.selected)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("storeFine.cell.selectTips",currentSelectedCell.cellName));
         }
      }
      
      private function __onChangeSuitExp(e:PkgEvent) : void
      {
         var bool:Boolean = false;
         var pkg:PackageIn = e.pkg;
         var type:int = pkg.readByte();
         if(!(int(type) - 1))
         {
            bool = pkg.readBoolean();
            PlayerManager.Instance.Self.fineSuitExp = pkg.readInt();
            updateMaterialCount();
            if(bool)
            {
               forgeResultAction();
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("storeFine.forgeFail"));
            }
         }
      }
      
      private function __onBagUpdate(e:BagEvent) : void
      {
         updateMaterialCount();
      }
      
      private function updateInfo() : void
      {
         var i:int = 0;
         var vo:FineSuitVo = FineSuitManager.Instance.getFineSuitPropertyByExp(PlayerManager.Instance.Self.fineSuitExp);
         var info:Array = [vo.Defence,vo.hp,vo.Luck,vo.Agility,vo.MagicDefence,vo.Armor];
         for(i = 0; i < 6; )
         {
            _list[i].text = info[i] < 0?0:info[i];
            i++;
         }
      }
      
      private function updateInfoOver() : void
      {
         var i:int = 0;
         var exp:int = PlayerManager.Instance.Self.fineSuitExp;
         var nLvVo:FineSuitVo = FineSuitManager.Instance.getNextLevelSuiteVo(exp);
         if(nLvVo == null)
         {
            return;
         }
         var vo:FineSuitVo = FineSuitManager.Instance.getFineSuitPropertyByExp(exp);
         var info:Array = [vo.Defence,vo.hp,vo.Luck,vo.Agility,vo.MagicDefence,vo.Armor];
         var nextLevelInfo:Array = [nLvVo.Defence,nLvVo.hp,nLvVo.Luck,nLvVo.Agility,nLvVo.MagicDefence,nLvVo.Armor];
         for(i = 0; i < 6; )
         {
            _list[i].htmlText = (info[i] < 0?0:info[i]) + "<font color=\'#ff0000\'>+" + (nextLevelInfo[i] < 0?0:nextLevelInfo[i]) + "</font>";
            i++;
         }
      }
      
      private function updateSuitExp() : void
      {
         var exp:int = forgeProgress;
         _progress.gotoAndStop(exp);
         _progressText.text = exp + "%";
      }
      
      private function updateMaterialCount() : void
      {
         var i:int = 0;
         var material:* = null;
         var count:int = 0;
         var needForgeId:int = needForgeCellId;
         for(i = 0; i < _materialList.length; )
         {
            material = _materialList[i] as BagCell;
            count = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(material.info.TemplateID);
            material.setCount(count);
            setForgeCellInfo(material,needForgeId);
            i++;
         }
      }
      
      private function updateCellBgView() : void
      {
         var i:int = 0;
         var cell:* = null;
         var cellPhase:* = 0;
         var index:int = currentIndex;
         if(_index == index && _index != 0)
         {
            return;
         }
         _index = index;
         var level:int = FineSuitManager.Instance.getNextSuitVoByExp(PlayerManager.Instance.Self.fineSuitExp).level;
         var levelPhase:int = (level - 1) / 14;
         for(i = 0; i < _cell.length; )
         {
            cell = _cell[i] as FineForgeCell;
            if(i < _index - 1)
            {
               cellPhase = int(levelPhase + 1);
            }
            else
            {
               cellPhase = levelPhase;
            }
            cellPhase++;
            cell.bgType = cellPhase > 6?6:cellPhase;
            cell.selected = false;
            i++;
         }
         if(PlayerManager.Instance.Self.fineSuitExp != FineSuitManager.Instance.getSuitVoByLevel(70).exp)
         {
            currentSelectedCell.selected = true;
         }
      }
      
      private function updateTipsData() : void
      {
         var i:int = 0;
         var itemState:int = 0;
         for(i = 0; i < _effectList.length; )
         {
            itemState = getforgeEffectState(i);
            ForgeEffectItem(_effectList[i]).updateTipData(itemState);
            i++;
         }
      }
      
      private function get currentSelectedCell() : FineForgeCell
      {
         return _cell[_index - 1] as FineForgeCell;
      }
      
      private function get currentIndex() : int
      {
         var level:int = FineSuitManager.Instance.getNextSuitVoByExp(PlayerManager.Instance.Self.fineSuitExp).level;
         level = level % 14;
         return level == 0?14:level;
      }
      
      private function get needForgeCellId() : int
      {
         var id:int = FineSuitManager.Instance.getNextSuitVoByExp(PlayerManager.Instance.Self.fineSuitExp).materialID;
         return id;
      }
      
      private function setForgeCellInfo(material:BagCell, id:int) : void
      {
         if(material.info.TemplateID != id)
         {
            material.grayFilters = true;
            material.removeEventListener("click",__onCellClick);
            material.removeEventListener("mouseOver",__onCellOver);
            material.removeEventListener("mouseOut",__onCellOut);
         }
         else
         {
            material.grayFilters = false;
            material.buttonMode = true;
            material.addEventListener("click",__onCellClick);
            material.addEventListener("mouseOver",__onCellOver);
            material.addEventListener("mouseOut",__onCellOut);
         }
      }
      
      private function get forgeProgress() : int
      {
         var exp:int = PlayerManager.Instance.Self.fineSuitExp;
         var baseExp:int = FineSuitManager.Instance.getSuitVoByExp(exp).exp;
         var nextExp:int = FineSuitManager.Instance.getNextSuitVoByExp(exp).exp;
         _progressTips.tipData = exp - baseExp + "/" + (nextExp - baseExp);
         if(baseExp == nextExp)
         {
            return 100;
         }
         return int((exp - baseExp) / (nextExp - baseExp) * 100);
      }
      
      private function getforgeEffectState(index:int) : int
      {
         var level:int = FineSuitManager.Instance.getNextSuitVoByExp(PlayerManager.Instance.Self.fineSuitExp).level / 14;
         var nRes:int = -1;
         if(level < index)
         {
            nRes = 3;
         }
         else if(level == index)
         {
            nRes = currentIndex == 14?3:2;
         }
         else if(level == index + 1)
         {
            if(level == 5 && currentIndex == 14)
            {
               nRes = 1;
            }
            else
            {
               nRes = currentIndex == 14?2:1;
            }
         }
         else
         {
            nRes = 1;
         }
         return nRes;
      }
      
      private function getTipsDataListView() : Array
      {
         var i:int = 0;
         var dataList:Array = [];
         for(i = 1; i <= 5; )
         {
            dataList.push(FineSuitManager.Instance.getTipsPropertyInfoList(i,"all"));
            i++;
         }
         return dataList;
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
         var material:* = null;
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
         for each(var cell in _cell)
         {
            cell.removeEventListener("click",__onClickCell);
            ObjectUtils.disposeObject(cell);
            cell = null;
         }
         _cell = null;
         while(_hBox.numChildren)
         {
            material = _hBox.getChildAt(0) as BagCell;
            material.removeEventListener("click",__onCellClick);
            material.removeEventListener("mouseOver",__onCellOver);
            material.removeEventListener("mouseOut",__onCellOut);
            ObjectUtils.disposeObject(material);
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
