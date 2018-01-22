package store.view.fusion
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyFrame;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import quest.TaskManager;
   import store.IStoreViewBG;
   import store.StoreCell;
   import store.StoreDragInArea;
   import store.StrengthDataManager;
   import store.data.PreviewInfoII;
   import store.events.StoreIIEvent;
   import store.view.shortcutBuy.ShortcutBuyFrame;
   import trainer.controller.NewHandQueue;
   import trainer.controller.WeakGuildManager;
   import trainer.data.Step;
   import trainer.view.NewHandContainer;
   
   public class StoreIIFusionBG extends Sprite implements IStoreViewBG
   {
      
      private static const ITEMS:Array = [11301,11302,11303,11304,11201,11202,11203,11204];
      
      private static const ZOMM:Number = 0.75;
      
      public static var lastIndexFusion:int = -1;
       
      
      private var _area:StoreDragInArea;
      
      private var _items:Array;
      
      private var _accessoryFrameII:AccessoryFrameII;
      
      private var _fusion_btn:BaseButton;
      
      private var _fusion_btn_shineEffect:IEffect;
      
      private var _fusionHelp:BaseButton;
      
      private var fusionArr:MutipleImage;
      
      private var gold_txt:FilterFrameText;
      
      private var _goldIcon:Image;
      
      private var _goodName:FilterFrameText;
      
      private var _goodRate:FilterFrameText;
      
      private var _autoFusion:Boolean;
      
      private var _autoSelect:Boolean;
      
      private var _autoCheck:SelectedCheckButton;
      
      private var _pointArray:Vector.<Point>;
      
      private var _gold:int = 400;
      
      private var _maxCell:int = 0;
      
      private var _ckAutoSplit:SelectedCheckButton;
      
      private var _isAutoSplit:Boolean = false;
      
      private var _bg:Image;
      
      private var _fusionTitle:Bitmap;
      
      private var _goldTipText:FilterFrameText;
      
      private var _previewPanelBg:Image;
      
      private var _previewNameLabel:FilterFrameText;
      
      private var _previewRateLabel:FilterFrameText;
      
      private var _windowTime:int;
      
      private var _itemsPreview:Array;
      
      private var _alertBand:Boolean = false;
      
      public function StoreIIFusionBG()
      {
         super();
         init();
         initEvent();
      }
      
      public static function autoSplitSend(param1:int, param2:int, param3:int, param4:String, param5:int, param6:Boolean = false, param7:IStoreViewBG = null) : void
      {
         var _loc10_:Array = getAutoSplitSendParam(param4,param5);
         var _loc8_:int = 0;
         var _loc9_:Array = param4.split(",");
         if(_loc9_.length == 4)
         {
            if(_loc10_)
            {
               clearFusion(param7);
               _loc8_ = 0;
               while(_loc8_ < _loc10_.length)
               {
                  if(_loc10_[_loc8_] > 0)
                  {
                     SocketManager.Instance.out.sendMoveGoods(param1,param2,param3,_loc8_ + 1,_loc10_[_loc8_],param6);
                  }
                  _loc8_++;
               }
            }
         }
         else if(_loc10_)
         {
            clearFusion(param7,_loc9_);
            _loc8_ = 0;
            while(_loc8_ < _loc10_.length)
            {
               if(_loc10_[_loc8_] > 0)
               {
                  SocketManager.Instance.out.sendMoveGoods(param1,param2,param3,_loc9_[_loc8_],_loc10_[_loc8_],param6);
               }
               _loc8_++;
            }
         }
         lastIndexFusion = -1;
      }
      
      public static function getRemainIndexByEmpty(param1:int, param2:IStoreViewBG) : String
      {
         var _loc5_:* = null;
         var _loc6_:int = 0;
         if(param1 >= 4)
         {
            return "1,2,3,4";
         }
         var _loc3_:String = "";
         var _loc4_:Array = [];
         if(param2 is StoreIIFusionBG)
         {
            _loc6_ = 1;
            while(_loc6_ < 5)
            {
               _loc5_ = (param2 as StoreIIFusionBG).area[_loc6_];
               if(!_loc5_.info)
               {
                  _loc4_.push(_loc5_.index);
               }
               _loc6_++;
            }
            switch(int(param1) - 2)
            {
               case 0:
                  _loc3_ = _loc4_.concat(findDiff(_loc4_)).slice(0,param1).splice(",");
                  break;
               case 1:
                  _loc3_ = _loc4_.concat(findDiff(_loc4_)).slice(0,param1).splice(",");
            }
         }
         return _loc3_;
      }
      
      private static function findDiff(param1:Array) : Array
      {
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc5_:Array = [];
         _loc2_ = 1;
         while(_loc2_ < 5)
         {
            _loc3_ = false;
            _loc4_ = 0;
            while(_loc4_ < param1.length)
            {
               if(_loc2_ == int(param1[_loc4_]))
               {
                  _loc3_ = true;
               }
               _loc4_++;
            }
            if(!_loc3_)
            {
               _loc5_.push(_loc2_);
            }
            _loc2_++;
         }
         return _loc5_;
      }
      
      private static function getAutoSplitSendParam(param1:String, param2:int) : Array
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:Array = [];
         var _loc5_:Array = param1.split(",");
         if(_loc5_ && param2 >= 1)
         {
            _loc3_ = param2 % _loc5_.length;
            _loc4_ = param2 / _loc5_.length;
            _loc7_ = 0;
            while(_loc7_ < _loc5_.length)
            {
               _loc3_--;
               _loc6_.push(_loc4_ + getRemainCellNumber(_loc3_));
               _loc7_++;
            }
         }
         return _loc6_;
      }
      
      private static function getRemainCellNumber(param1:int) : int
      {
         return param1 > 0?1:0;
      }
      
      private static function clearFusion(param1:IStoreViewBG, param2:Array = null) : void
      {
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         if(!param2)
         {
            _loc5_ = 1;
            while(_loc5_ < 5)
            {
               _loc4_ = (param1 as StoreIIFusionBG).area[_loc5_];
               if(_loc4_.info)
               {
                  SocketManager.Instance.out.sendMoveGoods(12,_loc4_.index,_loc4_.itemBagType,-1);
               }
               _loc5_++;
            }
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < param2.length)
         {
            _loc5_ = 1;
            while(_loc5_ < 5)
            {
               _loc4_ = (param1 as StoreIIFusionBG).area[_loc5_];
               if(_loc4_.info && _loc4_.index == int(param2[_loc3_]))
               {
                  SocketManager.Instance.out.sendMoveGoods(12,_loc4_.index,_loc4_.itemBagType,-1);
                  break;
               }
               _loc5_++;
            }
            _loc3_++;
         }
      }
      
      public function get isAutoSplit() : Boolean
      {
         return _isAutoSplit;
      }
      
      private function init() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIFusionBG.FusionBg");
         addChild(_bg);
         _fusionTitle = ComponentFactory.Instance.creatBitmap("asset.ddtstore.FusionTitle");
         addChild(_fusionTitle);
         _previewPanelBg = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIFusionBG.PreviewPanelBg");
         addChild(_previewPanelBg);
         _previewNameLabel = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIFusionBG.PreviewPanelNameLabel");
         _previewNameLabel.text = LanguageMgr.GetTranslation("store.view.fusion.StoreIIFusionBG.PreviewNameLabelText");
         addChild(_previewNameLabel);
         _previewRateLabel = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIFusionBG.PreviewPanelRateLabel");
         _previewRateLabel.text = LanguageMgr.GetTranslation("store.view.fusion.StoreIIFusionBG.PreviewRateLabelText");
         addChild(_previewRateLabel);
         _items = [];
         getCellsPoint();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            if(_loc2_ == 0)
            {
               _loc1_ = new FusionItemCellII(_loc2_);
            }
            else if(_loc2_ == 5)
            {
               _loc1_ = new FusionItemCell(_loc2_);
               var _loc3_:* = 0.75;
               _loc1_.scaleY = _loc3_;
               _loc1_.scaleX = _loc3_;
               FusionItemCell(_loc1_).mouseEvt = false;
               FusionItemCell(_loc1_).bgVisible = false;
            }
            else
            {
               _loc1_ = new FusionItemCell(_loc2_);
            }
            _loc1_.x = _pointArray[_loc2_].x;
            _loc1_.y = _pointArray[_loc2_].y;
            addChild(_loc1_);
            if(_loc2_ != 5)
            {
               _loc1_.addEventListener("change",__itemInfoChange);
            }
            _items.push(_loc1_);
            _loc2_++;
         }
         _accessoryFrameII = new AccessoryFrameII();
         _area = new StoreDragInArea(_items);
         addChildAt(_area,0);
         _fusion_btn = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIFusionBG.FusionBtn");
         _fusion_btn_shineEffect = EffectManager.Instance.creatEffect(4,_fusion_btn,{"color":"gold"});
         addChild(_fusion_btn);
         _fusionHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"ddtstore.HelpButton",null,LanguageMgr.GetTranslation("store.view.fusion.StoreIIFusionBG.say"),"ddtstore.HelpFrame.FusionText",404,484);
         fusionArr = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIFusionBG.ArrowHeadFusionTip");
         addChild(fusionArr);
         _goldTipText = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIFusionBG.NeedMoneyTipText");
         _goldTipText.text = LanguageMgr.GetTranslation("store.view.fusion.StoreIIFusionBG.NeedMoneyTipText");
         addChild(_goldTipText);
         gold_txt = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIFusionBG.NeedMoneyText");
         addChild(gold_txt);
         _goldIcon = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIFusionBG.GoldIcon");
         addChild(_goldIcon);
         _goodName = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIFusionBG.PreviewNameText");
         addChild(_goodName);
         _goodRate = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIFusionBG.PreviewSucessRateText");
         addChild(_goodRate);
         _autoCheck = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIFusionBG.ContinuousFusionCheckButton");
         addChild(_autoCheck);
         _ckAutoSplit = ComponentFactory.Instance.creat("ddtstore.StoreIIFusionBG.SellLeftAlerAutoSplitCk");
         _ckAutoSplit.text = LanguageMgr.GetTranslation("store.fusion.autoSplit");
         addChild(_ckAutoSplit);
         _ckAutoSplit.selected = _isAutoSplit;
         hideArr();
         hide();
      }
      
      private function initEvent() : void
      {
         _fusion_btn.addEventListener("click",__fusionClick);
         _accessoryFrameII.addEventListener("itemclick",__accessoryItemClick);
         _autoCheck.addEventListener("select",__selectedChanged);
         _ckAutoSplit.addEventListener("select",__autoSplit);
         SocketManager.Instance.addEventListener(PkgEvent.format(76),__upPreview);
         StrengthDataManager.instance.addEventListener("fusionFinish",__fusionFinish);
      }
      
      private function removeEvents() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _items.length)
         {
            _items[_loc1_].removeEventListener("change",__itemInfoChange);
            _items[_loc1_].dispose();
            _loc1_++;
         }
         _fusion_btn.removeEventListener("click",__fusionClick);
         _accessoryFrameII.removeEventListener("itemclick",__accessoryItemClick);
         _autoCheck.removeEventListener("select",__selectedChanged);
         SocketManager.Instance.removeEventListener(PkgEvent.format(76),__upPreview);
         StrengthDataManager.instance.removeEventListener("fusionFinish",__fusionFinish);
         if(_ckAutoSplit)
         {
            _ckAutoSplit.removeEventListener("select",__autoSplit);
         }
      }
      
      private function userGuide() : void
      {
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(88) && TaskManager.instance.isAchieved(TaskManager.instance.getQuestByID(351)))
         {
            NewHandQueue.Instance.push(new Step(74,exeItemTip,preItemTip,finItemTip));
         }
      }
      
      private function preItemTip() : void
      {
         NewHandContainer.Instance.showArrow(15,0,"trainer.fusItemArrowPos","asset.trainer.txtFusItemTip","trainer.fusItemTipPos");
      }
      
      private function exeItemTip() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(checkItemEmpty() >= 4)
         {
            _loc1_ = PlayerManager.Instance.Self.StoreBag.items[1].FusionType;
            _loc2_ = 2;
            while(_loc2_ <= 4)
            {
               if(_loc1_ != PlayerManager.Instance.Self.StoreBag.items[_loc2_].FusionType)
               {
                  return false;
               }
               _loc2_++;
            }
            return true;
         }
         return false;
      }
      
      private function finItemTip() : void
      {
         disposeUserGuide();
      }
      
      private function disposeUserGuide() : void
      {
         NewHandContainer.Instance.clearArrowByID(15);
         NewHandQueue.Instance.dispose();
      }
      
      private function getCellsPoint() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _pointArray = new Vector.<Point>();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreIIFusionBG.Fusionpoint" + _loc2_);
            _pointArray.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function __buyBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         param1.stopImmediatePropagation();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:ShortcutBuyFrame = ComponentFactory.Instance.creatCustomObject("ddtstore.ShortcutBuyFrame");
         _loc2_.show(ITEMS,true,LanguageMgr.GetTranslation("store.view.fusion.buyFormula"),4);
      }
      
      public function dragDrop(param1:BagCell) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(param1 == null)
         {
            return;
         }
         if(_accessoryFrameII.containsItem(param1.itemInfo))
         {
            return;
         }
         var _loc4_:InventoryItemInfo = param1.info as InventoryItemInfo;
         var _loc6_:int = 0;
         var _loc5_:* = _items;
         for each(_loc2_ in _items)
         {
            if(_loc2_.info == _loc4_)
            {
               _loc2_.info = null;
               param1.locked = false;
               return;
            }
         }
         _loc3_ = 1;
         while(_loc3_ < 5)
         {
            _loc2_ = _items[_loc3_];
            if(_loc2_ is FusionItemCell)
            {
               if(_loc4_.getRemainDate() <= 0)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.AccessoryDragInArea.overdue"));
               }
               else if(_loc4_.FusionType != 0 && _loc4_.FusionRate != 0)
               {
                  if(_items[1].info != null && _items[2].info != null && _items[3].info != null && _items[4].info != null)
                  {
                     __moveGoods(_loc4_,1);
                     return;
                  }
                  if(_loc2_.info == null)
                  {
                     __moveGoods(_loc4_,_loc2_.index);
                     return;
                  }
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.AccessoryItemCell.fusion"));
                  return;
               }
            }
            _loc3_++;
         }
      }
      
      private function __moveGoods(param1:InventoryItemInfo, param2:int) : void
      {
         var _loc3_:* = null;
         if(StrengthDataManager.instance.autoFusion)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.fusion.donMoveGoods"));
            return;
         }
         if(param1.Count > 1 && !_isAutoSplit)
         {
            _loc3_ = ComponentFactory.Instance.creat("ddtstore.FusionSelectNumAlertFrame");
            _loc3_.goodsinfo = param1;
            _loc3_.index = param2;
            _loc3_.show(param1.Count);
            _loc3_.addEventListener("sell",_alerSell);
            _loc3_.addEventListener("notsell",_alerNotSell);
         }
         else if(param1.Count > 1 && _isAutoSplit)
         {
            autoSplitSend(param1.BagType,param1.Place,12,getRemainIndexByEmpty(param1.Count,this),param1.Count,true,this);
         }
         else
         {
            SocketManager.Instance.out.sendMoveGoods(param1.BagType,param1.Place,12,param2,param1.Count,true);
         }
      }
      
      private function _alerSell(param1:FusionSelectEvent) : void
      {
         var _loc2_:FusionSelectNumAlertFrame = param1.currentTarget as FusionSelectNumAlertFrame;
         SocketManager.Instance.out.sendMoveGoods(param1.info.BagType,param1.info.Place,12,param1.index,param1.sellCount,true);
         _loc2_.removeEventListener("sell",_alerSell);
         _loc2_.removeEventListener("notsell",_alerNotSell);
         _loc2_.dispose();
         if(_loc2_ && _loc2_.parent)
         {
            removeChild(_loc2_);
         }
         _loc2_ = null;
      }
      
      private function _alerNotSell(param1:FusionSelectEvent) : void
      {
         var _loc2_:FusionSelectNumAlertFrame = param1.currentTarget as FusionSelectNumAlertFrame;
         _loc2_.removeEventListener("sell",_alerSell);
         _loc2_.removeEventListener("notsell",_alerNotSell);
         _loc2_.dispose();
         if(_loc2_ && _loc2_.parent)
         {
            removeChild(_loc2_);
         }
         _loc2_ = null;
      }
      
      private function _showDontClickTip() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = checkItemEmpty();
         if(_loc4_ == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.showTips.fusion.noEquip"));
            return true;
         }
         if(_loc4_ < 4)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.showTips.fusion.notEnoughStone"));
            return true;
         }
         if(_loc4_ == 4)
         {
            _loc1_ = PlayerManager.Instance.Self.StoreBag.items[1].FusionType;
            _loc2_ = 5;
            _loc5_ = 2;
            while(_loc5_ < _loc2_)
            {
               if(_loc1_ != PlayerManager.Instance.Self.StoreBag.items[_loc5_].FusionType)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.showTips.fusion.notSameStone"));
                  return true;
               }
               _loc5_++;
            }
            _loc3_ = 2;
            while(_loc3_ < _loc2_)
            {
               if(_items[1].info.TemplateID != _items[_loc3_].info.TemplateID)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.showTips.fusion.notSameLevelStone"));
                  return true;
               }
               _loc3_++;
            }
         }
         return false;
      }
      
      private function showIt() : void
      {
         showArr();
      }
      
      public function get area() : Array
      {
         return this._items;
      }
      
      public function refreshData(param1:Dictionary) : void
      {
         var _loc3_:* = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:* = param1;
         for(_loc3_ in param1)
         {
            if(_loc3_ < 5)
            {
               _items[_loc3_].info = PlayerManager.Instance.Self.StoreBag.items[_loc3_];
            }
            else
            {
               _accessoryFrameII.setItemInfo(_loc3_,PlayerManager.Instance.Self.StoreBag.items[_loc3_]);
            }
         }
         if(_items[1].info != null && _items[2].info != null && _items[3].info != null && _items[4].info != null)
         {
            if(_items[0].info != null)
            {
               SocketManager.Instance.out.sendMoveGoods(12,FusionItemCellII(_items[0]).index,FusionItemCellII(_items[0]).itemBagType,-1);
            }
            __previewRequest();
            _loc2_ = PlayerManager.Instance.Self.StoreBag.items[1].FusionType;
            _loc4_ = 5;
            _loc6_ = 2;
            while(_loc6_ < _loc4_)
            {
               if(_loc2_ != PlayerManager.Instance.Self.StoreBag.items[_loc6_].FusionType)
               {
                  _clearPreview();
               }
               _loc6_++;
            }
         }
         else
         {
            _clearPreview();
            autoFusion = false;
         }
      }
      
      private function __fusionFinish(param1:Event) : void
      {
         if(_items[1].info != null && _items[2].info != null && _items[3].info != null && _items[4].info != null)
         {
            __checkAuto();
         }
         else
         {
            _clearPreview();
            autoFusion = false;
         }
      }
      
      private function __checkAuto() : void
      {
         if(autoFusion)
         {
            auto = function():void
            {
               checkfunsion();
            };
            _windowTime = setTimeout(auto,1000);
         }
      }
      
      public function updateData() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _items[_loc2_].info = PlayerManager.Instance.Self.StoreBag.items[_loc2_];
            _loc2_++;
         }
         _loc1_ = 5;
         while(_loc1_ < 11)
         {
            _accessoryFrameII.setItemInfo(_loc1_,PlayerManager.Instance.Self.StoreBag.items[_loc1_ + 5]);
            _loc1_++;
         }
      }
      
      public function startShine(param1:int) : void
      {
         _items[param1].startShine();
      }
      
      public function stopShine() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _items[_loc1_].stopShine();
            _loc1_++;
         }
      }
      
      private function showArr() : void
      {
         if(autoFusion)
         {
            return;
         }
         fusionArr.visible = true;
         _fusion_btn_shineEffect.play();
      }
      
      private function hideArr() : void
      {
         fusionArr.visible = false;
         _fusion_btn_shineEffect.stop();
      }
      
      public function show() : void
      {
         this.visible = true;
         updateData();
         if(WeakGuildManager.Instance.switchUserGuide)
         {
            userGuide();
         }
      }
      
      public function hide() : void
      {
         autoFusion = false;
         this.visible = false;
         _accessoryFrameII.hide();
         disposeUserGuide();
      }
      
      private function __upPreview(param1:PkgEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         hideArr();
         var _loc3_:int = param1.pkg.readInt();
         _itemsPreview = [];
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc6_ = new PreviewInfoII();
            _loc6_.data(param1.pkg.readInt(),param1.pkg.readInt());
            _loc6_.rate = param1.pkg.readInt();
            _itemsPreview.push(_loc6_);
            _loc7_++;
         }
         _loc2_ = param1.pkg.readBoolean();
         _loc5_ = 0;
         while(_loc5_ < _itemsPreview.length)
         {
            _loc4_ = _itemsPreview[_loc5_] as PreviewInfoII;
            _loc4_.info.IsBinds = _loc2_;
            _loc5_++;
         }
         _showPreview();
         showArr();
      }
      
      private function _showPreview() : void
      {
         _items[5].info = _itemsPreview[0].info;
         _goodName.text = String(_itemsPreview[0].info.Name);
         _goodRate.text = _itemsPreview[0].rate <= 5?LanguageMgr.GetTranslation("store.fusion.preview.LowRate"):String(_itemsPreview[0].rate) + "%";
      }
      
      private function _clearPreview() : void
      {
         _items[5].info = null;
         _goodName.text = "";
         _goodRate.text = "0%";
      }
      
      private function __accessoryItemClick(param1:StoreIIEvent) : void
      {
         gold_txt.text = String((checkItemEmpty() + _accessoryFrameII.getCount()) * _gold);
      }
      
      private function __itemInfoChange(param1:Event) : void
      {
         var _loc2_:int = 0;
         _loc2_ = checkItemEmpty();
         gold_txt.text = String((_loc2_ + _accessoryFrameII.getCount()) * _gold);
         _clearPreview();
         hideArr();
      }
      
      private function checkItemEmpty() : int
      {
         var _loc1_:int = 0;
         if(PlayerManager.Instance.Self.StoreBag.items[1] != null)
         {
            _loc1_++;
         }
         if(PlayerManager.Instance.Self.StoreBag.items[2] != null)
         {
            _loc1_++;
         }
         if(PlayerManager.Instance.Self.StoreBag.items[3] != null)
         {
            _loc1_++;
         }
         if(PlayerManager.Instance.Self.StoreBag.items[4] != null)
         {
            _loc1_++;
         }
         return _loc1_;
      }
      
      private function isAllBinds() : int
      {
         var _loc1_:int = 0;
         if(_items[1].info != null && _items[1].info.IsBinds)
         {
            _loc1_++;
         }
         if(_items[2].info != null && _items[2].info.IsBinds)
         {
            _loc1_++;
         }
         if(_items[3].info != null && _items[3].info.IsBinds)
         {
            _loc1_++;
         }
         if(_items[4].info != null && _items[4].info.IsBinds)
         {
            _loc1_++;
         }
         return _loc1_;
      }
      
      private function __fusionClick(param1:MouseEvent) : void
      {
         if(param1 != null)
         {
            param1.stopImmediatePropagation();
         }
         SoundManager.instance.play("008");
         _alertBand = false;
         checkfunsion();
      }
      
      private function checkfunsion() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(_showDontClickTip())
         {
            return;
         }
         if(PlayerManager.Instance.Self.Gold < (_accessoryFrameII.getCount() + 4) * _gold)
         {
            autoFusion = false;
            _loc1_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.view.GoldInadequate"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            _loc1_.moveEnable = false;
            _loc1_.addEventListener("response",_responseV);
            return;
         }
         if(isAllBinds() != 0 && isAllBinds() != 4 && !_alertBand)
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("store.view.fusion.StoreIIFusionBG.use"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
            _loc2_.addEventListener("response",_response);
            _alertBand = true;
            return;
         }
         if(this._accessoryFrameII.isBinds && isAllBinds() != 4)
         {
            _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("store.view.fusion.StoreIIFusionBG.use"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
            _loc3_.addEventListener("response",_response);
            return;
         }
         sendFusionRequest();
      }
      
      private function _responseV(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_responseV);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            okFastPurchaseGold();
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function okFastPurchaseGold() : void
      {
         var _loc1_:QuickBuyFrame = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
         _loc1_.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
         _loc1_.itemID = 11233;
         LayerManager.Instance.addToLayer(_loc1_,2,true,1);
      }
      
      private function _response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = BaseAlerFrame(param1.currentTarget);
         _loc2_.removeEventListener("response",_response);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            sendFusionRequest();
         }
         ObjectUtils.disposeObject(param1.target);
      }
      
      private function testingSXJ() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:Boolean = false;
         _loc2_ = 0;
         while(_loc2_ < _items.length)
         {
            if(EquipType.isRongLing(_items[_loc2_].info))
            {
               _loc1_ = true;
               break;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function sendFusionRequest() : void
      {
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(88))
         {
            SocketManager.Instance.out.syncWeakStep(88);
         }
         if(autoSelect)
         {
            autoFusion = true;
            _fusion_btn.enable = true;
            hideArr();
         }
      }
      
      private function __previewRequest() : void
      {
      }
      
      private function __selectedChanged(param1:Event) : void
      {
         SoundManager.instance.play("008");
         autoSelect = _autoCheck.selected;
         if(autoSelect == false)
         {
            autoFusion = false;
         }
      }
      
      private function __autoSplit(param1:Event) : void
      {
         SoundManager.instance.play("008");
         _isAutoSplit = _ckAutoSplit.selected;
         StoreIIFusionBG.lastIndexFusion = -1;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
         _autoSelect = param1;
      }
      
      public function get autoSelect() : Boolean
      {
         return _autoSelect;
      }
      
      public function set autoFusion(param1:Boolean) : void
      {
         _autoFusion = param1;
         StrengthDataManager.instance.autoFusion = _autoFusion;
         if(!_autoFusion)
         {
            _fusion_btn.enable = true;
            clearTimeout(_windowTime);
            if(_items[5].info != null)
            {
               showArr();
            }
         }
      }
      
      public function get autoFusion() : Boolean
      {
         return _autoFusion;
      }
      
      public function dispose() : void
      {
         EffectManager.Instance.removeEffect(_fusion_btn_shineEffect);
         StoreIIFusionBG.lastIndexFusion = -1;
         removeEvents();
         disposeUserGuide();
         clearTimeout(_windowTime);
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_fusionTitle)
         {
            ObjectUtils.disposeObject(_fusionTitle);
         }
         _fusionTitle = null;
         if(_previewPanelBg)
         {
            ObjectUtils.disposeObject(_previewPanelBg);
         }
         _previewPanelBg = null;
         if(_previewNameLabel)
         {
            ObjectUtils.disposeObject(_previewNameLabel);
         }
         _previewNameLabel = null;
         if(_previewRateLabel)
         {
            ObjectUtils.disposeObject(_previewRateLabel);
         }
         _previewRateLabel = null;
         if(_area)
         {
            ObjectUtils.disposeObject(_area);
         }
         _area = null;
         if(_accessoryFrameII)
         {
            ObjectUtils.disposeObject(_accessoryFrameII);
         }
         _accessoryFrameII = null;
         if(_fusion_btn)
         {
            ObjectUtils.disposeObject(_fusion_btn);
         }
         _fusion_btn = null;
         if(_fusionHelp)
         {
            ObjectUtils.disposeObject(_fusionHelp);
         }
         _fusionHelp = null;
         if(fusionArr)
         {
            ObjectUtils.disposeObject(fusionArr);
         }
         fusionArr = null;
         if(_goldTipText)
         {
            ObjectUtils.disposeObject(_goldTipText);
         }
         _goldTipText = null;
         if(gold_txt)
         {
            ObjectUtils.disposeObject(gold_txt);
         }
         gold_txt = null;
         if(_goldIcon)
         {
            ObjectUtils.disposeObject(_goldIcon);
         }
         _goldIcon = null;
         if(_goodName)
         {
            ObjectUtils.disposeObject(_goodName);
         }
         _goodName = null;
         if(_goodRate)
         {
            ObjectUtils.disposeObject(_goodRate);
         }
         _goodRate = null;
         if(_autoCheck)
         {
            ObjectUtils.disposeObject(_autoCheck);
         }
         _autoCheck = null;
         if(_ckAutoSplit)
         {
            ObjectUtils.disposeObject(_ckAutoSplit);
            _ckAutoSplit = null;
         }
         _pointArray = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
