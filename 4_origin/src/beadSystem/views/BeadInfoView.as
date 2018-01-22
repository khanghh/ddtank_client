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
         var _loc10_:int = 0;
         var _loc7_:* = null;
         _Cells = new DictionaryData();
         _bg = ComponentFactory.Instance.creatBitmap("beadSystem.info.bg");
         getCellsPoint();
         addChild(_bg);
         var _loc8_:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[1,1]);
         _loc8_.x = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint1")).x;
         _loc8_.y = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint1")).y;
         _loc8_.StoneType = 1;
         addChild(_loc8_);
         _Cells.add(1,_loc8_);
         var _loc11_:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[2,2]);
         _loc11_.x = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint2")).x;
         _loc11_.y = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint2")).y;
         _loc11_.StoneType = 2;
         addChild(_loc11_);
         _Cells.add(2,_loc11_);
         var _loc9_:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[3,2]);
         _loc9_.x = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint3")).x;
         _loc9_.y = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint3")).y;
         _loc9_.StoneType = 2;
         addChild(_loc9_);
         _Cells.add(3,_loc9_);
         _loc10_ = 4;
         while(_loc10_ <= 12)
         {
            _loc7_ = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[_loc10_,3]);
            _loc7_.StoneType = 3;
            _loc7_.x = _pointArray[_loc10_ - 1].x;
            _loc7_.y = _pointArray[_loc10_ - 1].y;
            addChild(_loc7_);
            _Cells.add(_loc10_,_loc7_);
            _loc10_++;
         }
         var _loc3_:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[13,3]);
         _loc3_.x = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint13")).x;
         _loc3_.y = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint13")).y;
         _loc3_.StoneType = 3;
         addChild(_loc3_);
         _Cells.add(13,_loc3_);
         _HoleOpen.add(13,_loc3_);
         var _loc4_:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[14,3]);
         _loc4_.x = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint14")).x;
         _loc4_.y = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint14")).y;
         _loc4_.StoneType = 3;
         addChild(_loc4_);
         _Cells.add(14,_loc4_);
         _HoleOpen.add(14,_loc4_);
         var _loc1_:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[15,3]);
         _loc1_.x = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint15")).x;
         _loc1_.y = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint15")).y;
         _loc1_.StoneType = 3;
         addChild(_loc1_);
         _Cells.add(15,_loc1_);
         _HoleOpen.add(15,_loc1_);
         var _loc2_:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[16,3]);
         _loc2_.x = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint16")).x;
         _loc2_.y = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint16")).y;
         _loc2_.StoneType = 3;
         addChild(_loc2_);
         _Cells.add(16,_loc2_);
         _HoleOpen.add(16,_loc2_);
         var _loc6_:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[17,3]);
         _loc6_.x = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint17")).x;
         _loc6_.y = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint17")).y;
         _loc6_.StoneType = 3;
         addChild(_loc6_);
         _Cells.add(17,_loc6_);
         _HoleOpen.add(17,_loc6_);
         var _loc5_:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[18,3]);
         _loc5_.x = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint18")).x;
         _loc5_.y = Point(ComponentFactory.Instance.creatCustomObject("bead.Embedpoint18")).y;
         _loc5_.StoneType = 3;
         addChild(_loc5_);
         _Cells.add(18,_loc5_);
         _HoleOpen.add(18,_loc5_);
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
      
      override public function set visible(param1:Boolean) : void
      {
         if(this.visible)
         {
            _beadGetView.removeTimer();
         }
         .super.visible = param1;
      }
      
      private function loadStateList() : void
      {
         _stateList.dataList = BeadModel.getDrillsIgnoreBindState().list.sort(drillSortFun);
      }
      
      private function __stateSelectClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         param1.stopImmediatePropagation();
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
      
      private function drillSortFun(param1:DrillItemInfo, param2:DrillItemInfo) : int
      {
         return param1.itemInfo.Level - param2.itemInfo.Level;
      }
      
      private function __feedCellChanged(param1:BeadEvent) : void
      {
         var _loc2_:EmbedUpLevelCell = param1.currentTarget as EmbedUpLevelCell;
         if(_loc2_.info)
         {
            _progressLevel.currentExp = _loc2_.invenItemInfo.Hole2;
            if(_loc2_.invenItemInfo.Hole1 < _max)
            {
               _progressLevel.upLevelExp = ServerConfigManager.instance.getBeadUpgradeExp()[_loc2_.invenItemInfo.Hole1 + 1];
            }
            _progressLevel.intProgress(_loc2_.invenItemInfo);
         }
         else
         {
            _progressLevel.resetProgress();
         }
      }
      
      private function __onOpenHoleClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:int = getSelectedHoleIndex();
         if(_loc2_ == -1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.tipHoleNotSelected"));
            return;
         }
         var _loc5_:int = 0;
         var _loc4_:* = _HoleOpen;
         for each(var _loc3_ in _HoleOpen)
         {
            if(_loc3_.selected)
            {
               if(_loc3_.HoleLv == int(LanguageMgr.GetTranslation("ddt.beadSystem.MaxHoleLevel")))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.MaxHoleLevelText"));
               }
               else if(_loc2_ >= 0 && _stateSelectBtn.DrillItem)
               {
                  if(_loc3_.HoleLv == _stateSelectBtn.DrillItem.Level - 1)
                  {
                     if(PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_stateSelectBtn.DrillItem.TemplateID) > 0)
                     {
                        toShowNumberSelect(_loc2_,_stateSelectBtn.DrillItem.TemplateID);
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
      
      private function toShowNumberSelect(param1:int, param2:int) : void
      {
         index = param1;
         templateID = param2;
         onNumberSelected = function(param1:int):void
         {
            SocketManager.Instance.out.sendBeadOpenHole(index,templateID,param1);
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
      
      public function startShine(param1:ItemTemplateInfo) : void
      {
         var _loc3_:InventoryItemInfo = param1 as InventoryItemInfo;
         var _loc5_:int = 0;
         var _loc4_:* = _Cells;
         for each(var _loc2_ in _Cells)
         {
            if(!_loc2_.info && param1.Property2 == _loc2_.StoneType.toString() && _loc2_.isOpend)
            {
               if(_loc2_.ID < 13)
               {
                  _loc2_.startShine();
               }
               else if(beadSystemManager.Instance.judgeLevel(int(_loc3_.Hole1),_loc2_.HoleLv))
               {
                  _loc2_.startShine();
               }
            }
         }
      }
      
      public function stopShine() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _Cells;
         for each(var _loc1_ in _Cells)
         {
            _loc1_.stopShine();
         }
      }
      
      private function getSelectedHoleIndex() : int
      {
         var _loc1_:int = -1;
         var _loc4_:int = 0;
         var _loc3_:* = _HoleOpen;
         for each(var _loc2_ in _HoleOpen)
         {
            if(_loc2_.selected)
            {
               _loc1_ = _loc2_.ID;
               break;
            }
         }
         return getHoleIndex(_loc1_);
      }
      
      private function getHoleIndex(param1:int) : int
      {
         var _loc2_:int = -1;
         switch(int(param1) - 13)
         {
            case 0:
               _loc2_ = 0;
               break;
            case 1:
               _loc2_ = 1;
               break;
            case 2:
               _loc2_ = 2;
               break;
            case 3:
               _loc2_ = 3;
               break;
            case 4:
               _loc2_ = 4;
               break;
            case 5:
               _loc2_ = 5;
         }
         return _loc2_;
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
         for each(var _loc1_ in _Cells)
         {
            _loc1_.addEventListener("itemclick",__clickHandler);
            _loc1_.addEventListener("doubleclick",__doubleClickHandler);
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
      
      private function __beadEnterClickHandler(param1:MouseEvent) : void
      {
         openBeadAvanceFrame();
      }
      
      private function openBeadAvanceFrame() : void
      {
         _frame = ComponentFactory.Instance.creatComponentByStylename("bag.beadSystem.advanceFrame");
         LayerManager.Instance.addToLayer(_frame,3,true,1,true);
      }
      
      protected function __onPropBagUpdate(param1:Event) : void
      {
         updateBtn();
      }
      
      private function __hideStateList(param1:MouseEvent) : void
      {
         if(_stateList.parent)
         {
            _stateList.parent.removeChild(_stateList);
         }
      }
      
      private function __onOpenHole(param1:BeadEvent) : void
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
      
      private function __LightBtn(param1:BeadEvent) : void
      {
         _beadGetView.buttonState(param1.CellId);
      }
      
      private function __beadCellChanged(param1:Event) : void
      {
         initBeadEquip();
      }
      
      private function updateHoleProgress() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _HoleOpen;
         for each(var _loc1_ in _HoleOpen)
         {
            if(_loc1_.selected)
            {
               if(_loc1_.HoleLv > BeadModel.tempHoleLv)
               {
                  _loc1_.holeLvUp();
                  BeadModel.tempHoleLv = _loc1_.HoleLv;
                  showDrill(_loc1_.HoleLv);
               }
               _holeExpBar.setProgress(_loc1_.HoleExp,BeadModel.getHoleExpByLv(_loc1_.HoleLv));
               _holeExpBar.tipData = _loc1_.HoleLv + LanguageMgr.GetTranslation("store.embem.HoleTip.Level") + _loc1_.HoleExp + "/" + BeadModel.getHoleExpByLv(_loc1_.HoleLv);
               break;
            }
         }
      }
      
      protected function __clickHandler(param1:CellEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc3_:EmbedStoneCell = param1.currentTarget as EmbedStoneCell;
         if(_loc3_.selected)
         {
            _loc3_.dragStart();
            return;
         }
         var _loc6_:int = 0;
         var _loc5_:* = _Cells;
         for each(var _loc4_ in _Cells)
         {
            if(_loc4_.ID < 16)
            {
               if(_loc4_.ID == _loc3_.ID)
               {
                  _holeExpBar.setProgress(0);
                  _holeExpBar.tipData = LanguageMgr.GetTranslation("ddt.beadSystem.HoleNoSelect");
                  break;
               }
            }
         }
         var _loc8_:int = 0;
         var _loc7_:* = _HoleOpen;
         for each(var _loc2_ in _HoleOpen)
         {
            if(_loc2_.ID == _loc3_.ID)
            {
               BeadModel.tempHoleLv = _loc2_.HoleLv;
               _loc3_.selected = true;
               _holeExpBar.setProgress(_loc2_.HoleExp,BeadModel.getHoleExpByLv(_loc2_.HoleLv));
               _holeExpBar.tipData = _loc2_.HoleLv + LanguageMgr.GetTranslation("store.embem.HoleTip.Level") + _loc2_.HoleExp + "/" + BeadModel.getHoleExpByLv(_loc2_.HoleLv);
               showDrill(_loc2_.HoleLv);
            }
            else
            {
               _loc2_.selected = false;
            }
         }
         if(_loc3_.ID < 13)
         {
            _loc3_.dragStart();
         }
      }
      
      private function showDrill(param1:int) : void
      {
         var _loc2_:int = 0;
         switch(int(param1))
         {
            case 0:
               _loc2_ = 11035;
               break;
            case 1:
               _loc2_ = 11036;
               break;
            case 2:
               _loc2_ = 11026;
               break;
            case 3:
               _loc2_ = 11027;
               break;
            case 4:
               _loc2_ = 11034;
         }
         var _loc4_:Array = PlayerManager.Instance.Self.PropBag.findItemsByTempleteID(_loc2_);
         if(_loc4_.length == 0 || param1 == 5)
         {
            if(param1 != 5)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.Embed.OpenHole.NoDrill",param1 + 1));
            }
            return;
         }
         var _loc3_:int = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_loc2_);
         var _loc5_:DrillItemInfo = new DrillItemInfo();
         _loc5_.itemInfo = _loc4_[0];
         _loc5_.amount = _loc3_;
         _stateSelectBtn.setValue(_loc5_);
      }
      
      private function __doubleClickHandler(param1:CellEvent) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:EmbedStoneCell = param1.data as EmbedStoneCell;
         var _loc3_:InventoryItemInfo = _loc2_.info as InventoryItemInfo;
         SocketManager.Instance.out.sendBeadEquip(_loc3_.Place,-1);
         return;
         §§push(trace(_loc3_));
      }
      
      private function getCellsPoint() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _pointArray = new Vector.<Point>();
         _loc2_ = 1;
         while(_loc2_ <= 19)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("bead.Embedpoint" + _loc2_);
            _pointArray.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initBeadEquip() : void
      {
         trace("init Bead Equip.......");
         var _loc4_:* = 0;
         var _loc3_:* = _Cells;
         for each(var _loc2_ in _Cells)
         {
            _loc2_.info = null;
         }
         var _loc6_:int = 0;
         var _loc5_:* = _Cells;
         for each(var _loc1_ in _Cells)
         {
            _loc1_.itemInfo = PlayerManager.Instance.Self.BeadBag.getItemAt(_loc1_.ID);
            _loc1_.info = PlayerManager.Instance.Self.BeadBag.getItemAt(_loc1_.ID);
            if(!PlayerManager.Instance.Self.isNewOnceFinish(126) && _loc1_.info)
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
      
      private function __onFeedCellClick(param1:CellEvent) : void
      {
         var _loc2_:EmbedUpLevelCell = param1.currentTarget as EmbedUpLevelCell;
         if(_loc2_.info)
         {
            _loc2_.dragStart();
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
            for each(var _loc1_ in _Cells)
            {
               _loc1_.removeEventListener("itemclick",__clickHandler);
               _loc1_.removeEventListener("doubleclick",__doubleClickHandler);
               ObjectUtils.disposeObject(_loc1_);
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
