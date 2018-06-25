package beadSystem.views
{
   import baglocked.BaglockedManager;
   import beadSystem.beadSystemManager;
   import beadSystem.controls.BeadFeedProgress;
   import beadSystem.controls.DrillItemInfo;
   import beadSystem.controls.DrillSelectButton;
   import beadSystem.data.BeadEvent;
   import beadSystem.model.BeadModel;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.list.DropList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CellEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.view.character.ShowCharacter;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import quest.TaskManager;
   import road7th.data.DictionaryData;
   import store.data.HoleExpModel;
   import store.view.embed.EmbedStoneCell;
   import store.view.embed.EmbedUpLevelCell;
   import store.view.embed.HoleExpBar;
   import trainer.view.NewHandContainer;
   
   public class BeadInfoView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _character:ShowCharacter;
      
      private var _pointArray:Vector.<Point>;
      
      private var _progressLevel:BeadFeedProgress;
      
      private var _holeExpBar:HoleExpBar;
      
      public var _beadGetView:BeadGetView;
      
      private var _openHoleBtn:TextButton;
      
      private var _Cells:DictionaryData;
      
      private var _HoleOpen:DictionaryData;
      
      private var _stateList:DropList;
      
      private var _stateSelectBtn:DrillSelectButton;
      
      private var _beadHoleModel:HoleExpModel;
      
      private var _beadUpGradeTxt:FilterFrameText;
      
      private var _beadFeedCell:EmbedUpLevelCell;
      
      private var _helpButton:BaseButton;
      
      private var _max:int = 21;
      
      private var _beadEnter:TextButton;
      
      private var _frame:BeadAdvancedFrame;
      
      public function BeadInfoView()
      {
         super();
         _HoleOpen = new DictionaryData();
         initView();
         initBeadEquip();
         beadGuide();
      }
      
      private function beadGuide() : void
      {
         if(!PlayerManager.Instance.Self.isNewOnceFinish(126))
         {
            if(PlayerManager.Instance.Self.Grade == 16 && TaskManager.instance.isAchieved(TaskManager.instance.getQuestByID(29)))
            {
               NewHandContainer.Instance.showArrow(142,0,new Point(468,-33),"asset.trainer.txtBeadGuide","guide.bead.txtPos",this);
            }
         }
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var stoneCell:* = null;
         _Cells = new DictionaryData();
         _bg = ComponentFactory.Instance.creatBitmap("beadSystem.info.bg");
         getCellsPoint();
         addChild(_bg);
         var stoneAttackCell:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[1,1]);
         stoneAttackCell.x = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint1")).x;
         stoneAttackCell.y = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint1")).y;
         stoneAttackCell.StoneType = 1;
         addChild(stoneAttackCell);
         _Cells.add(1,stoneAttackCell);
         var stoneDefanceCell1:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[2,2]);
         stoneDefanceCell1.x = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint2")).x;
         stoneDefanceCell1.y = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint2")).y;
         stoneDefanceCell1.StoneType = 2;
         addChild(stoneDefanceCell1);
         _Cells.add(2,stoneDefanceCell1);
         var stoneDefanceCell2:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[3,2]);
         stoneDefanceCell2.x = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint3")).x;
         stoneDefanceCell2.y = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint3")).y;
         stoneDefanceCell2.StoneType = 2;
         addChild(stoneDefanceCell2);
         _Cells.add(3,stoneDefanceCell2);
         for(i = 4; i <= 12; )
         {
            stoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[i,3]);
            stoneCell.StoneType = 3;
            stoneCell.x = _pointArray[i - 1].x;
            stoneCell.y = _pointArray[i - 1].y;
            addChild(stoneCell);
            _Cells.add(i,stoneCell);
            i++;
         }
         var stoneNeedOpen1:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[13,3]);
         stoneNeedOpen1.x = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint13")).x;
         stoneNeedOpen1.y = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint13")).y;
         stoneNeedOpen1.StoneType = 3;
         addChild(stoneNeedOpen1);
         _Cells.add(13,stoneNeedOpen1);
         _HoleOpen.add(13,stoneNeedOpen1);
         var stoneNeedOpen2:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[14,3]);
         stoneNeedOpen2.x = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint14")).x;
         stoneNeedOpen2.y = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint14")).y;
         stoneNeedOpen2.StoneType = 3;
         addChild(stoneNeedOpen2);
         _Cells.add(14,stoneNeedOpen2);
         _HoleOpen.add(14,stoneNeedOpen2);
         var stoneNeedOpen3:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[15,3]);
         stoneNeedOpen3.x = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint15")).x;
         stoneNeedOpen3.y = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint15")).y;
         stoneNeedOpen3.StoneType = 3;
         addChild(stoneNeedOpen3);
         _Cells.add(15,stoneNeedOpen3);
         _HoleOpen.add(15,stoneNeedOpen3);
         var stoneNeedOpen4:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[16,3]);
         stoneNeedOpen4.x = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint16")).x;
         stoneNeedOpen4.y = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint16")).y;
         stoneNeedOpen4.StoneType = 3;
         addChild(stoneNeedOpen4);
         _Cells.add(16,stoneNeedOpen4);
         _HoleOpen.add(16,stoneNeedOpen4);
         var stoneNeedOpen5:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[17,3]);
         stoneNeedOpen5.x = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint17")).x;
         stoneNeedOpen5.y = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint17")).y;
         stoneNeedOpen5.StoneType = 3;
         addChild(stoneNeedOpen5);
         _Cells.add(17,stoneNeedOpen5);
         _HoleOpen.add(17,stoneNeedOpen5);
         var stoneNeedOpen6:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[18,3]);
         stoneNeedOpen6.x = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint18")).x;
         stoneNeedOpen6.y = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint18")).y;
         stoneNeedOpen6.StoneType = 3;
         addChild(stoneNeedOpen6);
         _Cells.add(18,stoneNeedOpen6);
         _HoleOpen.add(18,stoneNeedOpen6);
         _progressLevel = ComponentFactory.Instance.creatComponentByStylename("beadSystem.FeedProgress");
         _progressLevel.tipStyle = "ddt.view.tips.OneLineTip";
         _progressLevel.tipDirctions = "3,7,6";
         _progressLevel.tipGapV = 4;
         var _loc12_:* = 0.8;
         _progressLevel.scaleY = _loc12_;
         _progressLevel.scaleX = _loc12_;
         addChild(_progressLevel);
         _holeExpBar = ComponentFactory.Instance.creatCustomObject("beadSystem.HoleExpBar");
         _holeExpBar.visible = true;
         _holeExpBar.setProgress(0);
         _holeExpBar.tipData = LanguageMgr.GetTranslation("ddt.beadSystem.HoleNoSelect");
         addChild(_holeExpBar);
         _beadFeedCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedUpLevelCell");
         _beadFeedCell.x = _pointArray[18].x;
         _beadFeedCell.y = _pointArray[18].y;
         addChild(_beadFeedCell);
         _beadGetView = ComponentFactory.Instance.creatCustomObject("beadGetView");
         addChild(_beadGetView);
         _openHoleBtn = ComponentFactory.Instance.creatComponentByStylename("beadSystem.openHole");
         _openHoleBtn.text = LanguageMgr.GetTranslation("ddt.beadSystem.OpenHoleText");
         _openHoleBtn.tipData = LanguageMgr.GetTranslation("ddt.beadSystem.OpenHoleText");
         addChild(_openHoleBtn);
         _stateSelectBtn = ComponentFactory.Instance.creatCustomObject("beadSystem.DrillButton");
         addChild(_stateSelectBtn);
         _stateList = ComponentFactory.Instance.creatComponentByStylename("beadSystem.drillList");
         _stateList.targetDisplay = _stateSelectBtn;
         _stateList.showLength = 6;
         _beadUpGradeTxt = ComponentFactory.Instance.creatComponentByStylename("beadSystem.upderBeadUpgradeCell.Text");
         _beadUpGradeTxt.text = LanguageMgr.GetTranslation("ddt.beadSystem.underBeadFeedCellTxt");
         addChild(_beadUpGradeTxt);
         _beadEnter = ComponentFactory.Instance.creatComponentByStylename("beadSystem.beadEnterBtn");
         addChild(_beadEnter);
         _helpButton = HelpFrameUtils.Instance.simpleHelpButton(this,"beadSystem.btnHelp",{
            "x":658,
            "y":-91
         },LanguageMgr.GetTranslation("ddt.beadSystem.beadDisc"),"beadSystem.helpTxt",404,484);
         updateBtn();
         initEvent();
         initHoleExp();
         BeadModel._BeadCells = _HoleOpen;
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(this.visible)
         {
            _beadGetView.removeTimer();
         }
         .super.visible = value;
      }
      
      private function loadStateList() : void
      {
         _stateList.dataList = BeadModel.getDrillsIgnoreBindState().list.sort(drillSortFun);
      }
      
      private function __stateSelectClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         event.stopImmediatePropagation();
         if(_stateList.parent == null)
         {
            addChild(_stateList);
            _stateList.dataList = BeadModel.getDrillsIgnoreBindState().list.sort(drillSortFun);
         }
         else
         {
            _stateList.parent.removeChild(_stateList);
         }
      }
      
      private function drillSortFun(a:DrillItemInfo, b:DrillItemInfo) : int
      {
         return a.itemInfo.Level - b.itemInfo.Level;
      }
      
      private function __feedCellChanged(pEvent:BeadEvent) : void
      {
         var c:EmbedUpLevelCell = pEvent.currentTarget as EmbedUpLevelCell;
         if(c.info)
         {
            _progressLevel.currentExp = c.invenItemInfo.Hole2;
            if(c.invenItemInfo.Hole1 < _max)
            {
               _progressLevel.upLevelExp = ServerConfigManager.instance.getBeadUpgradeExp()[c.invenItemInfo.Hole1 + 1];
            }
            _progressLevel.intProgress(c.invenItemInfo);
         }
         else
         {
            _progressLevel.resetProgress();
         }
      }
      
      private function __onOpenHoleClick(pEvent:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var index:int = getSelectedHoleIndex();
         if(index == -1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.tipHoleNotSelected"));
            return;
         }
         var _loc5_:int = 0;
         var _loc4_:* = _HoleOpen;
         for each(var o in _HoleOpen)
         {
            if(o.selected)
            {
               if(o.HoleLv == int(LanguageMgr.GetTranslation("ddt.beadSystem.MaxHoleLevel")))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.MaxHoleLevelText"));
               }
               else if(index >= 0 && _stateSelectBtn.DrillItem)
               {
                  if(o.HoleLv == _stateSelectBtn.DrillItem.Level - 1)
                  {
                     if(PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_stateSelectBtn.DrillItem.TemplateID) > 0)
                     {
                        toShowNumberSelect(index,_stateSelectBtn.DrillItem.TemplateID);
                     }
                     else
                     {
                        MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.noEnoughDrills"));
                     }
                  }
                  else
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.tipErrorDrills"));
                  }
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.tipNoDrillSelected"));
               }
               break;
            }
         }
      }
      
      private function toShowNumberSelect(index:int, templateID:int) : void
      {
         index = index;
         templateID = templateID;
         onNumberSelected = function(num:int):void
         {
            SocketManager.Instance.out.sendBeadOpenHole(index,templateID,num);
         };
         var alert:OpenHoleNumAlertFrame = ComponentFactory.Instance.creatComponentByStylename("gemstone.openHoleNumAlertFrame");
         alert.curItemID = templateID;
         alert.initAlert();
         alert.callBack(onNumberSelected);
         LayerManager.Instance.addToLayer(alert,3,true,1);
      }
      
      private function updateBtn() : void
      {
         if(BeadModel.getDrills().length <= 0)
         {
            _stateSelectBtn.setValue(null);
         }
         var _loc1_:* = BeadModel.getDrills().length > 0;
         _stateSelectBtn.mouseEnabled = _loc1_;
         _stateSelectBtn.mouseChildren = _loc1_;
         _stateSelectBtn.filters = BeadModel.getDrills().length > 0?null:ComponentFactory.Instance.creatFilters("grayFilter");
      }
      
      public function startShine(info:ItemTemplateInfo) : void
      {
         var itemInfo:InventoryItemInfo = info as InventoryItemInfo;
         var _loc5_:int = 0;
         var _loc4_:* = _Cells;
         for each(var c in _Cells)
         {
            if(!c.info && info.Property2 == c.StoneType.toString() && c.isOpend)
            {
               if(c.ID < 13)
               {
                  c.startShine();
               }
               else if(beadSystemManager.Instance.judgeLevel(int(itemInfo.Hole1),c.HoleLv))
               {
                  c.startShine();
               }
            }
         }
      }
      
      public function stopShine() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _Cells;
         for each(var c in _Cells)
         {
            c.stopShine();
         }
      }
      
      private function getSelectedHoleIndex() : int
      {
         var vResult:int = -1;
         var _loc4_:int = 0;
         var _loc3_:* = _HoleOpen;
         for each(var c in _HoleOpen)
         {
            if(c.selected)
            {
               vResult = c.ID;
               break;
            }
         }
         return getHoleIndex(vResult);
      }
      
      private function getHoleIndex(pID:int) : int
      {
         var vResult:int = -1;
         switch(int(pID) - 13)
         {
            case 0:
               vResult = 0;
               break;
            case 1:
               vResult = 1;
               break;
            case 2:
               vResult = 2;
               break;
            case 3:
               vResult = 3;
               break;
            case 4:
               vResult = 4;
               break;
            case 5:
               vResult = 5;
         }
         return vResult;
      }
      
      private function initEvent() : void
      {
         beadSystemManager.Instance.addEventListener("lightButton",__LightBtn);
         beadSystemManager.Instance.addEventListener("openBeadHole",__onOpenHole);
         StageReferance.stage.addEventListener("click",__hideStateList);
         PlayerManager.Instance.addEventListener("equip",__beadCellChanged);
         PlayerManager.Instance.Self.PropBag.addEventListener("update",__onPropBagUpdate);
         _openHoleBtn.addEventListener("click",__onOpenHoleClick);
         _stateSelectBtn.addEventListener("click",__stateSelectClick);
         _beadFeedCell.addEventListener("beadCellChanged",__feedCellChanged);
         _beadFeedCell.addEventListener("itemclick",__onFeedCellClick);
         if(_beadEnter)
         {
            _beadEnter.addEventListener("click",__beadEnterClickHandler);
         }
         var _loc3_:int = 0;
         var _loc2_:* = _Cells;
         for each(var o in _Cells)
         {
            o.addEventListener("itemclick",__clickHandler);
            o.addEventListener("doubleclick",__doubleClickHandler);
         }
      }
      
      private function removeEvent() : void
      {
         beadSystemManager.Instance.removeEventListener("lightButton",__LightBtn);
         beadSystemManager.Instance.removeEventListener("openBeadHole",__onOpenHole);
         StageReferance.stage.removeEventListener("click",__hideStateList);
         PlayerManager.Instance.removeEventListener("equip",__beadCellChanged);
         PlayerManager.Instance.Self.PropBag.removeEventListener("update",__onPropBagUpdate);
         _openHoleBtn.removeEventListener("click",__onOpenHoleClick);
         _stateSelectBtn.removeEventListener("click",__stateSelectClick);
         _beadFeedCell.removeEventListener("beadCellChanged",__feedCellChanged);
         _beadFeedCell.removeEventListener("itemclick",__onFeedCellClick);
         if(_beadEnter)
         {
            _beadEnter.removeEventListener("click",__beadEnterClickHandler);
         }
      }
      
      private function __beadEnterClickHandler(evt:MouseEvent) : void
      {
         openBeadAvanceFrame();
      }
      
      private function openBeadAvanceFrame() : void
      {
         _frame = ComponentFactory.Instance.creatComponentByStylename("bag.beadSystem.advanceFrame");
         LayerManager.Instance.addToLayer(_frame,3,true,1,true);
      }
      
      protected function __onPropBagUpdate(event:Event) : void
      {
         updateBtn();
      }
      
      private function __hideStateList(event:MouseEvent) : void
      {
         if(_stateList.parent)
         {
            _stateList.parent.removeChild(_stateList);
         }
      }
      
      private function __onOpenHole(pEvent:BeadEvent) : void
      {
         initHoleExp();
      }
      
      private function initHoleExp() : void
      {
         if(BeadModel.drillInfo.length > 0)
         {
            _HoleOpen[13].HoleExp = BeadModel.drillInfo[131];
            _HoleOpen[14].HoleExp = BeadModel.drillInfo[141];
            _HoleOpen[15].HoleExp = BeadModel.drillInfo[151];
            _HoleOpen[16].HoleExp = BeadModel.drillInfo[161];
            _HoleOpen[17].HoleExp = BeadModel.drillInfo[171];
            _HoleOpen[18].HoleExp = BeadModel.drillInfo[181];
            _HoleOpen[13].HoleLv = BeadModel.drillInfo[132];
            _HoleOpen[14].HoleLv = BeadModel.drillInfo[142];
            _HoleOpen[15].HoleLv = BeadModel.drillInfo[152];
            _HoleOpen[16].HoleLv = BeadModel.drillInfo[162];
            _HoleOpen[17].HoleLv = BeadModel.drillInfo[172];
            _HoleOpen[18].HoleLv = BeadModel.drillInfo[182];
            updateHoleProgress();
         }
      }
      
      private function __LightBtn(pEvent:BeadEvent) : void
      {
         _beadGetView.buttonState(pEvent.CellId);
      }
      
      private function __beadCellChanged(pEvent:Event) : void
      {
         initBeadEquip();
      }
      
      private function updateHoleProgress() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _HoleOpen;
         for each(var c in _HoleOpen)
         {
            if(c.selected)
            {
               if(c.HoleLv > BeadModel.tempHoleLv)
               {
                  c.holeLvUp();
                  BeadModel.tempHoleLv = c.HoleLv;
                  showDrill(c.HoleLv);
               }
               _holeExpBar.setProgress(c.HoleExp,BeadModel.getHoleExpByLv(c.HoleLv));
               _holeExpBar.tipData = c.HoleLv + LanguageMgr.GetTranslation("store.embem.HoleTip.Level") + c.HoleExp + "/" + BeadModel.getHoleExpByLv(c.HoleLv);
               break;
            }
         }
      }
      
      protected function __clickHandler(evt:CellEvent) : void
      {
         SoundManager.instance.play("008");
         var cell:EmbedStoneCell = evt.currentTarget as EmbedStoneCell;
         if(cell.selected)
         {
            cell.dragStart();
            return;
         }
         var _loc6_:int = 0;
         var _loc5_:* = _Cells;
         for each(var o in _Cells)
         {
            if(o.ID < 16)
            {
               if(o.ID == cell.ID)
               {
                  _holeExpBar.setProgress(0);
                  _holeExpBar.tipData = LanguageMgr.GetTranslation("ddt.beadSystem.HoleNoSelect");
                  break;
               }
            }
         }
         var _loc8_:int = 0;
         var _loc7_:* = _HoleOpen;
         for each(var c in _HoleOpen)
         {
            if(c.ID == cell.ID)
            {
               BeadModel.tempHoleLv = c.HoleLv;
               cell.selected = true;
               _holeExpBar.setProgress(c.HoleExp,BeadModel.getHoleExpByLv(c.HoleLv));
               _holeExpBar.tipData = c.HoleLv + LanguageMgr.GetTranslation("store.embem.HoleTip.Level") + c.HoleExp + "/" + BeadModel.getHoleExpByLv(c.HoleLv);
               showDrill(c.HoleLv);
            }
            else
            {
               c.selected = false;
            }
         }
         if(cell.ID < 13)
         {
            cell.dragStart();
         }
      }
      
      private function showDrill(value:int) : void
      {
         var itemID:int = 0;
         switch(int(value))
         {
            case 0:
               itemID = 11035;
               break;
            case 1:
               itemID = 11036;
               break;
            case 2:
               itemID = 11026;
               break;
            case 3:
               itemID = 11027;
               break;
            case 4:
               itemID = 11034;
         }
         var itemInfo:Array = PlayerManager.Instance.Self.PropBag.findItemsByTempleteID(itemID);
         if(itemInfo.length == 0 || value == 5)
         {
            if(value != 5)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.Embed.OpenHole.NoDrill",value + 1));
            }
            return;
         }
         var AllCount:int = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(itemID);
         var drillInfo:DrillItemInfo = new DrillItemInfo();
         drillInfo.itemInfo = itemInfo[0];
         drillInfo.amount = AllCount;
         _stateSelectBtn.setValue(drillInfo);
      }
      
      private function __doubleClickHandler(event:CellEvent) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var cell:EmbedStoneCell = event.data as EmbedStoneCell;
         var info:InventoryItemInfo = cell.info as InventoryItemInfo;
         SocketManager.Instance.out.sendBeadEquip(info.Place,-1);
         return;
         §§push(trace(info));
      }
      
      private function getCellsPoint() : void
      {
         var i:int = 0;
         var point:* = null;
         _pointArray = new Vector.<Point>();
         for(i = 1; i <= 19; )
         {
            point = ComponentFactory.Instance.creatCustomObject("bead.Embedpoint" + i);
            _pointArray.push(point);
            i++;
         }
      }
      
      private function initBeadEquip() : void
      {
         trace("init Bead Equip.......");
         var _loc4_:* = 0;
         var _loc3_:* = _Cells;
         for each(var o in _Cells)
         {
            o.info = null;
         }
         var _loc6_:int = 0;
         var _loc5_:* = _Cells;
         for each(var e in _Cells)
         {
            e.itemInfo = PlayerManager.Instance.Self.BeadBag.getItemAt(e.ID);
            e.info = PlayerManager.Instance.Self.BeadBag.getItemAt(e.ID);
            if(!PlayerManager.Instance.Self.isNewOnceFinish(126) && e.info)
            {
               NewHandContainer.Instance.clearArrowByID(142);
               SocketManager.Instance.out.syncWeakStep(126);
            }
         }
         _loc4_ = PlayerManager.Instance.Self.BeadBag.getItemAt(31);
         _beadFeedCell.itemInfo = _loc4_;
         _beadFeedCell.invenItemInfo = _loc4_;
         _beadFeedCell.info = PlayerManager.Instance.Self.BeadBag.getItemAt(31);
      }
      
      private function __onFeedCellClick(pEvent:CellEvent) : void
      {
         var cell:EmbedUpLevelCell = pEvent.currentTarget as EmbedUpLevelCell;
         if(cell.info)
         {
            cell.dragStart();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         _openHoleBtn.removeEventListener("click",__onOpenHoleClick);
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_progressLevel)
         {
            ObjectUtils.disposeObject(_progressLevel);
         }
         _progressLevel = null;
         if(_holeExpBar)
         {
            ObjectUtils.disposeObject(_holeExpBar);
         }
         _holeExpBar = null;
         if(_beadGetView)
         {
            ObjectUtils.disposeObject(_beadGetView);
         }
         _beadGetView = null;
         if(_openHoleBtn)
         {
            ObjectUtils.disposeObject(_openHoleBtn);
         }
         _openHoleBtn = null;
         if(_stateList)
         {
            ObjectUtils.disposeObject(_stateList);
         }
         _stateList = null;
         if(_stateSelectBtn)
         {
            ObjectUtils.disposeObject(_stateSelectBtn);
         }
         _stateSelectBtn = null;
         if(_beadFeedCell)
         {
            ObjectUtils.disposeObject(_beadFeedCell);
         }
         _beadFeedCell = null;
         if(_beadUpGradeTxt)
         {
            ObjectUtils.disposeObject(_beadUpGradeTxt);
         }
         _beadUpGradeTxt = null;
         if(_beadEnter)
         {
            ObjectUtils.disposeObject(_beadEnter);
         }
         _beadEnter = null;
         _frame = null;
         if(_Cells.length > 0)
         {
            var _loc3_:int = 0;
            var _loc2_:* = _Cells;
            for each(var o in _Cells)
            {
               o.removeEventListener("itemclick",__clickHandler);
               o.removeEventListener("doubleclick",__doubleClickHandler);
               ObjectUtils.disposeObject(o);
            }
         }
         if(_helpButton)
         {
            ObjectUtils.disposeObject(_helpButton);
         }
         _helpButton = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
