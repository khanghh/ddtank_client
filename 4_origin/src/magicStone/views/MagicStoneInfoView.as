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
      
      public function updataCharacter(_info:PlayerInfo) : void
      {
         if(_character)
         {
            _character.dispose();
            _character = null;
         }
         _character = CharactoryFactory.createCharacter(_info,"room") as RoomCharacter;
         _character.showGun = false;
         _character.show(false,-1);
         PositionUtils.setPos(_character,"magicStone.characterPos");
         addChild(_character);
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var place:int = 0;
         var cell:* = null;
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
         for(i = 0; i <= 9 - 1; )
         {
            place = MgStoneUtils.getPlace(i);
            cell = createEmbedMgStoneCell(place) as EmbedMgStoneCell;
            cell.addEventListener("interactive_click",__cellClickHandler);
            cell.addEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.enableDoubleClick(cell);
            PositionUtils.setPos(cell,"magicStone.mgStoneCellPos" + i);
            addChild(cell);
            _mgStoneCells.push(cell);
            _cells[place] = cell;
            i++;
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
      
      public function createEmbedMgStoneCell(place:int = 0, info:ItemTemplateInfo = null, showLoading:Boolean = true) : ICell
      {
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16777215,0);
         sp.graphics.drawRect(0,0,60,60);
         sp.graphics.endFill();
         var cell:EmbedMgStoneCell = new EmbedMgStoneCell(place,info,showLoading,sp);
         fillTipProp(cell);
         return cell;
      }
      
      private function fillTipProp(cell:ICell) : void
      {
         cell.tipDirctions = "7,6,2,1,5,4,0,3,6";
         cell.tipGapV = 10;
         cell.tipGapH = 10;
         cell.tipStyle = "core.GoodsTip";
      }
      
      public function updateModel() : void
      {
         var sItem:* = null;
         var tItem:* = null;
         var i:int = 0;
         var templateId:int = 0;
         var itemId:int = 0;
         var key:int = 0;
         var _self:SelfInfo = PlayerManager.Instance.Self;
         var _currentIndex:int = PlayerDressManager.instance.currentIndex;
         if(_self.Sex)
         {
            _currentModel.model.updateStyle(_self.Sex,_self.Hide,DressModel.DEFAULT_MAN_STYLE,",,,,,,","");
         }
         else
         {
            _currentModel.model.updateStyle(_self.Sex,_self.Hide,DressModel.DEFAULT_WOMAN_STYLE,",,,,,,","");
         }
         var _bodyThings:DictionaryData = new DictionaryData();
         var dressArr:Array = PlayerDressManager.instance.modelArr[_currentIndex];
         var reSave:Boolean = false;
         if(dressArr)
         {
            for(i = 0; i <= dressArr.length - 1; )
            {
               templateId = (dressArr[i] as DressVo).templateId;
               itemId = (dressArr[i] as DressVo).itemId;
               tItem = new InventoryItemInfo();
               sItem = _self.Bag.getItemByItemId(itemId);
               if(!sItem)
               {
                  sItem = _self.Bag.getItemByTemplateId(templateId);
                  reSave = true;
               }
               if(sItem)
               {
                  tItem.setIsUsed(sItem.IsUsed);
                  ObjectUtils.copyProperties(tItem,sItem);
                  key = DressUtils.findItemPlace(tItem);
                  _bodyThings.add(key,tItem);
                  if(tItem.CategoryID == 6)
                  {
                     _currentModel.model.Skin = tItem.Skin;
                  }
                  _currentModel.model.setPartStyle(tItem.CategoryID,tItem.NeedSex,tItem.TemplateID,tItem.Color);
               }
               i++;
            }
         }
         _currentModel.model.Bag.items = _bodyThings;
      }
      
      private function initData() : void
      {
         var i:int = 0;
         var place:int = 0;
         var item:* = null;
         _mgStonebag = PlayerManager.Instance.Self.magicStoneBag;
         clearCells();
         for(i = 0; i <= 9 - 1; )
         {
            place = MgStoneUtils.getPlace(i);
            item = _mgStonebag.getItemAt(place);
            if(item)
            {
               setCellInfo(item.Place,item);
            }
            i++;
         }
         updateProgress();
      }
      
      private function updateProgress() : void
      {
         var completed:int = 0;
         var total:int = 0;
         var updateItem:InventoryItemInfo = _mgStonebag.getItemAt(31);
         if(updateItem)
         {
            completed = updateItem.StrengthenExp - MagicStoneManager.instance.getNeedExp(updateItem.TemplateID,updateItem.StrengthenLevel);
            total = MagicStoneManager.instance.getNeedExpPerLevel(updateItem.TemplateID,updateItem.StrengthenLevel + 1);
            _progress.setData(completed,total);
         }
         else
         {
            _progress.setData(0,0);
         }
      }
      
      private function clearCells() : void
      {
         var i:int = 0;
         for(i = 0; i <= 9 - 1; )
         {
            _mgStoneCells[i].info = null;
            i++;
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
      
      private function __magicStoneDoubleScore(evt:MagicStoneEvent) : void
      {
      }
      
      protected function __cellClickHandler(event:InteractiveEvent) : void
      {
         if((event.currentTarget as BagCell).info != null)
         {
            dispatchEvent(new CellEvent("itemclick",event.currentTarget,false,false,event.ctrlKey));
         }
      }
      
      protected function __doubleClickHandler(event:InteractiveEvent) : void
      {
         var info:InventoryItemInfo = (event.currentTarget as BagCell).info as InventoryItemInfo;
         if(info != null)
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
               SocketManager.Instance.out.moveMagicStone(info.Place,-1);
            }
         }
      }
      
      private function isBagFull() : Boolean
      {
         var i:int = 0;
         var item:* = null;
         for(i = 32; i <= 143; )
         {
            item = _mgStonebag.getItemAt(i);
            if(!item)
            {
               return false;
            }
            i++;
         }
         return true;
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
      
      protected function __updateGoods(event:BagEvent) : void
      {
         var c:* = null;
         var changes:Dictionary = event.changedSlots;
         var _loc6_:int = 0;
         var _loc5_:* = changes;
         for each(var item in changes)
         {
            if(item.Place >= 0 && item.Place <= 31)
            {
               c = _mgStonebag.getItemAt(item.Place);
               if(c)
               {
                  setCellInfo(c.Place,c);
               }
               else
               {
                  setCellInfo(item.Place,null);
               }
               MagicStoneManager.instance.removeWeakGuide(2);
               dispatchEvent(new Event("change"));
            }
         }
         updateProgress();
      }
      
      public function setCellInfo(index:int, info:InventoryItemInfo) : void
      {
         var key:String = String(index);
         if(info == null)
         {
            if(_cells[key])
            {
               _cells[key].info = null;
            }
            return;
         }
         if(info.Count == 0)
         {
            _cells[key].info = null;
         }
         else
         {
            _cells[key].info = info;
         }
      }
      
      protected function __covertBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var frame:MagicStoneShopFrame = ComponentFactory.Instance.creatCustomObject("magicStone.magicStoneShopFrame");
         frame.addEventListener("response",__frameEvent);
         frame.show();
      }
      
      protected function __frameEvent(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var frame:Disposeable = event.target as Disposeable;
         frame.dispose();
         frame = null;
      }
      
      protected function __exploreBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var tmpNeedMoney:int = getNeedMoney();
         if(MagicStoneControl.instance.isNoPrompt)
         {
            if(MagicStoneControl.instance.isBand && PlayerManager.Instance.Self.BandMoney < tmpNeedMoney)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("bindMoneyPoorNote"));
               MagicStoneControl.instance.isNoPrompt = false;
            }
            else if(!MagicStoneControl.instance.isBand && PlayerManager.Instance.Self.Money < tmpNeedMoney)
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
      
      private function comfirmHandler(event:FrameEvent) : void
      {
         var tmpNeedMoney:int = 0;
         SoundManager.instance.play("008");
         _confirmFrame.removeEventListener("response",comfirmHandler);
         if(event.responseCode == 3 || event.responseCode == 2)
         {
            tmpNeedMoney = getNeedMoney();
            CheckMoneyUtils.instance.checkMoney(_confirmFrame.isBand,tmpNeedMoney,onCheckComplete);
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
         var serverStr:* = null;
         var strArr:* = null;
         var arr:* = null;
         var obj:Object = ServerConfigManager.instance.serverConfigInfo["OpenMagicBoxMoney"];
         if(obj)
         {
            serverStr = obj.Value;
            if(serverStr && serverStr != "")
            {
               strArr = serverStr.split("|");
               if(strArr[selectedIndex - 1])
               {
                  arr = strArr[selectedIndex - 1].split(",");
                  return parseInt(arr[0]);
               }
            }
         }
         return 0;
      }
      
      public function getNeedMoney2(index:int) : int
      {
         var serverStr:* = null;
         var strArr:* = null;
         var arr:* = null;
         var obj:Object = ServerConfigManager.instance.serverConfigInfo["OpenMagicBoxMoney"];
         if(obj)
         {
            serverStr = obj.Value;
            if(serverStr && serverStr != "")
            {
               strArr = serverStr.split("|");
               if(strArr[index])
               {
                  arr = strArr[index].split(",");
                  return parseInt(arr[0]);
               }
            }
         }
         return 0;
      }
      
      protected function __exploreBatBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var remain:int = getBagRemain();
         var tmpNeedMoney:int = getNeedMoney() * 10;
         if(MagicStoneControl.instance.isBatNoPrompt)
         {
            if(MagicStoneControl.instance.isBatBand && PlayerManager.Instance.Self.BandMoney < tmpNeedMoney)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("bindMoneyPoorNote"));
               MagicStoneControl.instance.isBatNoPrompt = false;
            }
            else if(!MagicStoneControl.instance.isBatBand && PlayerManager.Instance.Self.Money < tmpNeedMoney)
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
         if(remain == 0)
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
      
      private function confirmBatHandler(event:FrameEvent) : void
      {
         var tmpNeedMoney:int = 0;
         SoundManager.instance.play("008");
         _confirmFrame1.removeEventListener("response",confirmBatHandler);
         if(event.responseCode == 3 || event.responseCode == 2)
         {
            tmpNeedMoney = getNeedMoney() * 10;
            CheckMoneyUtils.instance.checkMoney(_confirmFrame1.isBand,tmpNeedMoney,onBatCheckComplete);
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
         var i:int = 0;
         var item:* = null;
         var count:int = 0;
         for(i = 32; i <= 143; )
         {
            item = _mgStonebag.getItemAt(i);
            if(!item)
            {
               count++;
            }
            i++;
         }
         return count;
      }
      
      private function __stoneExploreClick(e:MouseEvent) : void
      {
         SocketManager.Instance.out.sendCheckMagicStoneNumber();
      }
      
      private function __showExploreView(e:Event) : void
      {
         _stoneExploreView = ComponentFactory.Instance.creatComponentByStylename("MagicStone.StoneExploreViewFrame");
         LayerManager.Instance.addToLayer(_stoneExploreView,3,true,1);
      }
      
      public function updateScore(num:int) : void
      {
         _scoreTxt.text = num.toString();
      }
      
      private function removeEvents() : void
      {
         var i:int = 0;
         removeEventListener("itemclick",__cellClick);
         _covertBtn.removeEventListener("click",__covertBtnClick);
         _exploreBtn.removeEventListener("click",__exploreBtnClick);
         _exploreBatBtn.removeEventListener("click",__exploreBatBtnClick);
         _stoneExploreBtn.removeEventListener("click",__stoneExploreClick);
         PlayerManager.Instance.Self.magicStoneBag.removeEventListener("update",__updateGoods);
         MagicStoneControl.instance.removeEventListener("showExploreView",__showExploreView);
         for(i = 0; i <= _mgStoneCells.length - 1; )
         {
            if(_mgStoneCells[i])
            {
               _mgStoneCells[i].removeEventListener("interactive_click",__cellClickHandler);
               _mgStoneCells[i].removeEventListener("interactive_double_click",__doubleClickHandler);
            }
            i++;
         }
      }
      
      public function dispose() : void
      {
         var i:int = 0;
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
         for(i = 0; i <= _mgStoneCells.length - 1; )
         {
            ObjectUtils.disposeObject(_mgStoneCells[i]);
            _mgStoneCells[i] = null;
            i++;
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
