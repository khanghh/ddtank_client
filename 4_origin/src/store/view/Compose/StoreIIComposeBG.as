package store.view.Compose
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyFrame;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.quest.QuestInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.view.common.BuyItemButton;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import quest.TaskManager;
   import store.IStoreViewBG;
   import store.ShowSuccessRate;
   import store.StoneCell;
   import store.StoreCell;
   import store.StoreDragInArea;
   import store.view.ConsortiaRateManager;
   import store.view.StoneCellFrame;
   import store.view.shortcutBuy.ShortcutBuyFrame;
   import store.view.strength.MySmithLevel;
   import trainer.controller.NewHandQueue;
   import trainer.controller.WeakGuildManager;
   import trainer.data.Step;
   import trainer.view.NewHandContainer;
   
   public class StoreIIComposeBG extends Sprite implements IStoreViewBG
   {
      
      private static const ITEMS:Array = [11004,11008,11012,11016];
      
      public static const COMPOSE_TOP:int = 50;
       
      
      private var _area:StoreDragInArea;
      
      private var _items:Array;
      
      private var _bg:MutipleImage;
      
      private var _luckyStoneCell:StoneCellFrame;
      
      private var _strengthStoneCell:StoneCellFrame;
      
      private var _equipmentCell:StoneCellFrame;
      
      private var _compose_btn:BaseButton;
      
      private var _compose_btn_shineEffect:IEffect;
      
      private var _composeHelp:BaseButton;
      
      private var cpsArr:MutipleImage;
      
      private var _cBuyluckyBtn:BuyItemButton;
      
      private var _buyStoneBtn:TextButton;
      
      private var _composeTitle:Bitmap;
      
      private var _pointArray:Vector.<Point>;
      
      private var _showSuccessRate:ShowSuccessRate;
      
      private var _consortiaSmith:MySmithLevel;
      
      public var composeRate:Array;
      
      public function StoreIIComposeBG()
      {
         composeRate = [0.8,0.5,0.3,0.1,0.05];
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         var _loc6_:int = 0;
         var _loc3_:* = null;
         _items = [];
         _composeTitle = ComponentFactory.Instance.creatBitmap("asset.ddtstore.ComposeTitle");
         addChild(_composeTitle);
         _luckyStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreIIComposeBG.LuckySymbolCell");
         _luckyStoneCell.label = LanguageMgr.GetTranslation("store.Strength.GoodPanelText.LuckySymbol");
         addChild(_luckyStoneCell);
         _strengthStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreIIComposeBG.StrengthenStoneCell");
         _strengthStoneCell.label = LanguageMgr.GetTranslation("store.Compose.ComposeStone");
         addChild(_strengthStoneCell);
         _equipmentCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreIIComposeBG.EquipmentCell");
         _equipmentCell.label = LanguageMgr.GetTranslation("store.Strength.StrengthenEquipmentCellText");
         addChild(_equipmentCell);
         _compose_btn = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIComposeBG.ComposeBtn");
         _compose_btn_shineEffect = EffectManager.Instance.creatEffect(4,_compose_btn,{"color":"gold"});
         addChild(_compose_btn);
         _composeHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"ddtstore.HelpButton",null,LanguageMgr.GetTranslation("store.StoreIIComposeBG.say"),"ddtstore.HelpFrame.ComposeText",404,484);
         cpsArr = ComponentFactory.Instance.creatComponentByStylename("ddtstore.ArrowHeadComposeTip");
         addChild(cpsArr);
         _cBuyluckyBtn = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIComposeBG.BuyLuckyComposeBtn");
         _cBuyluckyBtn.text = LanguageMgr.GetTranslation("store.Strength.BuyButtonText");
         _cBuyluckyBtn.setup(11018,2,true);
         addChild(_cBuyluckyBtn);
         _buyStoneBtn = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIComposeBG.BuyComposeStoneBtn");
         _buyStoneBtn.text = LanguageMgr.GetTranslation("store.Strength.BuyButtonText");
         addChild(_buyStoneBtn);
         _consortiaSmith = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreIIStrengthBG.MySmithLevel");
         addChild(_consortiaSmith);
         getCellsPoint();
         _loc6_ = 0;
         while(_loc6_ < 3)
         {
            if(_loc6_ == 0)
            {
               _loc3_ = new ComposeStoneCell(["3"],_loc6_);
            }
            else if(_loc6_ == 1)
            {
               _loc3_ = new ComposeItemCell(_loc6_);
            }
            else if(_loc6_ == 2)
            {
               _loc3_ = new ComposeStoneCell(["1"],_loc6_);
            }
            _loc3_.x = _pointArray[_loc6_].x;
            _loc3_.y = _pointArray[_loc6_].y;
            _loc3_.addEventListener("change",__itemInfoChange);
            addChild(_loc3_);
            _items.push(_loc3_);
            _loc6_++;
         }
         _area = new StoreDragInArea(_items);
         addChildAt(_area,0);
         hide();
         hideArr();
         _showSuccessRate = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreIIStrengthBG.ShowSuccessRate");
         var _loc4_:String = LanguageMgr.GetTranslation("store.StoreIIComposeBG.ComposeStonStrip");
         var _loc1_:String = LanguageMgr.GetTranslation("store.StoreIIComposeBG.LuckSignStrip");
         var _loc2_:String = LanguageMgr.GetTranslation("store.StoreIIComposeBG.ConsortiaAddStrip");
         var _loc5_:String = LanguageMgr.GetTranslation("store.StoreIIComposeBG.noVIPAllNumStrip");
         if(PlayerManager.Instance.Self.ConsortiaID == 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("tank.view.store.consortiaRateI");
         }
         _showSuccessRate.showAllTips(_loc4_,_loc1_,_loc2_,_loc5_);
         addChild(_showSuccessRate);
      }
      
      private function getCellsPoint() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _pointArray = new Vector.<Point>();
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreIIComposeBG.Composepoint" + _loc2_);
            _pointArray.push(_loc1_);
            _loc2_++;
         }
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
                  if(_loc2_.info == null)
                  {
                     if((_loc2_ as StoneCell).types.indexOf(_loc3_.Property1) > -1 && _loc3_.CategoryID == 11)
                     {
                        SocketManager.Instance.out.sendMoveGoods(_loc3_.BagType,_loc3_.Place,12,_loc2_.index,_loc3_.Count,true);
                        return;
                     }
                  }
               }
               else if(_loc2_ is ComposeItemCell)
               {
                  if(_loc3_.getRemainDate() <= 0)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.AccessoryDragInArea.overdue"));
                  }
                  else
                  {
                     if(_loc3_.AgilityCompose == 50 && _loc3_.DefendCompose == 50 && _loc3_.AttackCompose == 50 && _loc3_.LuckCompose == 50)
                     {
                        MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.ComposeItemCell.up"));
                        return;
                     }
                     if(param1.info.CanCompose)
                     {
                        SocketManager.Instance.out.sendMoveGoods(_loc3_.BagType,_loc3_.Place,12,_loc2_.index,_loc3_.Count,true);
                        return;
                     }
                  }
               }
            }
         }
         if(EquipType.isComposeStone(_loc3_) || _loc3_.CategoryID == 11 && _loc3_.Property1 == "7" || _loc3_.CategoryID == 11 && _loc3_.Property1 == "3")
         {
            var _loc9_:int = 0;
            var _loc8_:* = _items;
            for each(_loc2_ in _items)
            {
               if(_loc2_ is StoneCell && (_loc2_ as StoneCell).types.indexOf(_loc3_.Property1) > -1 && _loc3_.CategoryID == 11)
               {
                  SocketManager.Instance.out.sendMoveGoods(_loc3_.BagType,_loc3_.Place,12,_loc2_.index,_loc3_.Count,true);
                  return;
               }
            }
         }
      }
      
      public function startShine(param1:int) : void
      {
         if(param1 != 3)
         {
            _items[param1].startShine();
         }
      }
      
      public function refreshData(param1:Dictionary) : void
      {
         var _loc2_:* = 0;
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for(_loc2_ in param1)
         {
            if(_loc2_ < _items.length)
            {
               _items[_loc2_].info = PlayerManager.Instance.Self.StoreBag.items[_loc2_];
            }
         }
      }
      
      public function updateData() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _items[_loc1_].info = PlayerManager.Instance.Self.StoreBag.items[_loc1_];
            _loc1_++;
         }
      }
      
      public function stopShine() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _items[_loc1_].stopShine();
            _loc1_++;
         }
      }
      
      private function initEvent() : void
      {
         _compose_btn.addEventListener("click",__composeClick);
         _buyStoneBtn.addEventListener("click",__buyStone);
         ConsortiaRateManager.instance.addEventListener("loadComplete_consortia",_consortiaLoadComplete);
      }
      
      private function userGuide() : void
      {
         var _loc1_:* = null;
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(75))
         {
            _loc1_ = TaskManager.instance.getQuestByID(566);
            if(TaskManager.instance.isAvailableQuest(_loc1_,true) && !_loc1_.isCompleted)
            {
               NewHandQueue.Instance.push(new Step(72,exeWeaponTip,preWeaponTip,finWeaponTip));
               NewHandQueue.Instance.push(new Step(73,exeStoneTip,preStoneTip,finStoneTip));
            }
            TaskManager.instance.checkSendRequestAddQuestDic();
         }
      }
      
      private function preWeaponTip() : void
      {
         NewHandContainer.Instance.showArrow(13,0,"trainer.comWeaponArrowPos","asset.trainer.txtWeaponTip","trainer.comWeaponTipPos",LayerManager.Instance.getLayerByType(2));
      }
      
      private function exeWeaponTip() : Boolean
      {
         return _items[1].info;
      }
      
      private function finWeaponTip() : void
      {
         NoviceDataManager.instance.saveNoviceData(870,PathManager.userName(),PathManager.solveRequestPath());
         NewHandContainer.Instance.clearArrowByID(13);
      }
      
      private function preStoneTip() : void
      {
         NewHandContainer.Instance.showArrow(13,360,"trainer.comStoneArrowPos","asset.trainer.txtComStoneTip","trainer.comStoneTipPos",LayerManager.Instance.getLayerByType(2));
      }
      
      private function exeStoneTip() : Boolean
      {
         return _items[2].info;
      }
      
      private function finStoneTip() : void
      {
         NoviceDataManager.instance.saveNoviceData(880,PathManager.userName(),PathManager.solveRequestPath());
         disposeUserGuide();
         showArr();
      }
      
      private function disposeUserGuide() : void
      {
         if(NewHandContainer.Instance.hasArrow(13))
         {
            NewHandContainer.Instance.clearArrowByID(13);
            NewHandQueue.Instance.dispose();
         }
      }
      
      private function __buyStone(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         param1.stopImmediatePropagation();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:ShortcutBuyFrame = ComponentFactory.Instance.creatComponentByStylename("ddtstore.ShortcutBuyFrame");
         _loc2_.show(ITEMS,false,LanguageMgr.GetTranslation("store.view.Compose.buyCompose"),2);
      }
      
      private function showArr() : void
      {
         NewHandContainer.Instance.clearArrowByID(13);
         cpsArr.visible = true;
         _compose_btn_shineEffect.play();
      }
      
      private function hideArr() : void
      {
         cpsArr.visible = false;
         _compose_btn_shineEffect.stop();
      }
      
      public function get area() : Array
      {
         return this._items;
      }
      
      private function __composeClick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         param1.stopImmediatePropagation();
         SoundManager.instance.play("008");
         if(_showDontClickTip())
         {
            return;
         }
         if(checkTipBindType())
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("store.StoreIIComposeBG.use"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
            _loc2_.addEventListener("response",_responseI);
         }
         else
         {
            hideArr();
            sendSocket();
         }
      }
      
      private function _responseV(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_responseV);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
            _loc2_.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
            _loc2_.itemID = 11233;
            LayerManager.Instance.addToLayer(_loc2_,2,true,1);
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function _responseI(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = BaseAlerFrame(param1.currentTarget);
         _loc2_.removeEventListener("response",_responseI);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            sendSocket();
         }
         ObjectUtils.disposeObject(param1.target);
      }
      
      private function sendSocket() : void
      {
         var _loc1_:Boolean = false;
         if(PlayerManager.Instance.Self.ConsortiaID != 0 && ConsortiaRateManager.instance.rate > 0)
         {
            _loc1_ = true;
         }
         SocketManager.Instance.out.sendItemCompose(_loc1_);
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(75))
         {
            NoviceDataManager.instance.saveNoviceData(890,PathManager.userName(),PathManager.solveRequestPath());
            SocketManager.Instance.out.syncWeakStep(75);
         }
      }
      
      private function checkTipBindType() : Boolean
      {
         if(_items[1].itemInfo && _items[1].itemInfo.IsBinds)
         {
            return false;
         }
         if(_items[0].itemInfo && _items[0].itemInfo.IsBinds)
         {
            return true;
         }
         if(_items[2].itemInfo && _items[2].itemInfo.IsBinds)
         {
            return true;
         }
         return false;
      }
      
      private function __itemInfoChange(param1:Event) : void
      {
         if(getCountRate() <= 0)
         {
         }
         getCountRateI();
      }
      
      private function _showDontClickTip() : Boolean
      {
         if(_items[1].info == null && _items[2].info == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.showTips.compose.dontCompose"));
            return true;
         }
         if(_items[1].info == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.showTips.compose.dontComposeI"));
            return true;
         }
         if(_items[2].info == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.showTips.compose.dontComposeII"));
            return true;
         }
         return false;
      }
      
      private function getCountRate() : Number
      {
         var _loc1_:* = 0;
         if(_items[1] == null || _items[1].info == null)
         {
            return _loc1_;
         }
         if(_items[2] != null && _items[2].info != null)
         {
            _loc1_ = Number(composeRate[_items[2].info.Quality - 1] * 100);
         }
         if(_loc1_ > 0 && _items[0] != null && _items[0].info != null)
         {
            _loc1_ = Number((1 + _items[0].info.Property2 / 100) * _loc1_);
         }
         _loc1_ = Number(_loc1_ * (1 + 0.1 * ConsortiaRateManager.instance.rate));
         _loc1_ = Number(Math.floor(_loc1_ * 10) / 10);
         _loc1_ = Number(_loc1_ > 100?100:Number(_loc1_));
         return _loc1_;
      }
      
      private function getCountRateI() : void
      {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         if(_items[1] == null || _items[1].info == null)
         {
            _showSuccessRate.showAllNum(_loc3_,_loc4_,_loc1_,_loc2_);
            return;
         }
         if(_items[2] != null && _items[2].info != null)
         {
            _loc3_ = Number(composeRate[_items[2].info.Quality - 1] * 100);
         }
         if(_loc3_ > 0 && _items[0] != null && _items[0].info != null)
         {
            _loc4_ = Number(_items[0].info.Property2 / 100 * _loc3_);
         }
         _loc1_ = Number(_loc3_ * (0.1 * ConsortiaRateManager.instance.rate));
         _loc2_ = Number(_loc3_ + _loc4_ + _loc1_);
         _loc3_ = Number(Math.floor(_loc3_ * 10) / 10);
         _loc4_ = Number(Math.floor(_loc4_ * 10) / 10);
         _loc1_ = Number(Math.floor(_loc1_ * 10) / 10);
         _loc2_ = Number(Math.floor(_loc2_ * 10) / 10);
         _loc3_ = Number(_loc3_ > 100?100:Number(_loc3_));
         _loc4_ = Number(_loc4_ > 100?100:Number(_loc4_));
         _loc1_ = Number(_loc1_ > 100?100:Number(_loc1_));
         _loc2_ = Number(_loc2_ > 100?100:Number(_loc2_));
         _showSuccessRate.showAllNum(_loc3_,_loc4_,_loc1_,_loc2_);
      }
      
      public function consortiaRate() : void
      {
         ConsortiaRateManager.instance.reset();
      }
      
      private function _consortiaLoadComplete(param1:Event) : void
      {
         __itemInfoChange(null);
      }
      
      public function show() : void
      {
         this.visible = true;
         _consortiaLoadComplete(null);
         consortiaRate();
         updateData();
         if(WeakGuildManager.Instance.switchUserGuide)
         {
            userGuide();
         }
      }
      
      public function hide() : void
      {
         this.visible = false;
         if(NewHandContainer.Instance.hasArrow(13))
         {
            NoviceDataManager.instance.saveNoviceData(860,PathManager.userName(),PathManager.solveRequestPath());
         }
         hideArr();
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         disposeUserGuide();
         _loc1_ = 0;
         while(_loc1_ < _items.length)
         {
            _items[_loc1_].removeEventListener("change",__itemInfoChange);
            _items[_loc1_].dispose();
            _items[_loc1_] = null;
            _loc1_++;
         }
         _items = null;
         _compose_btn.removeEventListener("click",__composeClick);
         ConsortiaRateManager.instance.removeEventListener("loadComplete_consortia",_consortiaLoadComplete);
         EffectManager.Instance.removeEffect(_compose_btn_shineEffect);
         if(_area)
         {
            _area.dispose();
         }
         _area = null;
         _pointArray = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_luckyStoneCell)
         {
            ObjectUtils.disposeObject(_luckyStoneCell);
         }
         _luckyStoneCell = null;
         if(_strengthStoneCell)
         {
            ObjectUtils.disposeObject(_strengthStoneCell);
         }
         _strengthStoneCell = null;
         if(_compose_btn)
         {
            ObjectUtils.disposeObject(_compose_btn);
         }
         _compose_btn = null;
         if(_composeHelp)
         {
            ObjectUtils.disposeObject(_composeHelp);
         }
         _composeHelp = null;
         if(cpsArr)
         {
            ObjectUtils.disposeObject(cpsArr);
         }
         cpsArr = null;
         if(_cBuyluckyBtn)
         {
            ObjectUtils.disposeObject(_cBuyluckyBtn);
         }
         _cBuyluckyBtn = null;
         if(_buyStoneBtn)
         {
            ObjectUtils.disposeObject(_buyStoneBtn);
         }
         _buyStoneBtn = null;
         if(_consortiaSmith)
         {
            ObjectUtils.disposeObject(_consortiaSmith);
         }
         _consortiaSmith = null;
         if(_consortiaSmith)
         {
            ObjectUtils.disposeObject(_consortiaSmith);
         }
         _consortiaSmith = null;
         if(_showSuccessRate)
         {
            ObjectUtils.disposeObject(_showSuccessRate);
         }
         _showSuccessRate = null;
         if(_equipmentCell)
         {
            ObjectUtils.disposeObject(_equipmentCell);
         }
         _equipmentCell = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
