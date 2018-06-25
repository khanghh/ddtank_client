package texpSystem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.tip.ITip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.BagEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.view.tips.GoodTipInfo;
   import flash.geom.Point;
   import morn.core.handlers.Handler;
   import quest.TaskManager;
   import shop.view.NewShopMultiBugleView;
   import texpSystem.TexpEvent;
   import texpSystem.controller.TexpManager;
   import texpSystem.data.TexpInfo;
   import texpSystem.view.mornui.TexpMainViewUI;
   import trainer.view.NewHandContainer;
   
   public class TexpMainView extends TexpMainViewUI
   {
       
      
      private var _texpCell:TexpCell;
      
      private var _currentType:int = -1;
      
      private var _btnHelp:BaseButton;
      
      private var _allInjectSCB:SelectedCheckButton;
      
      public function TexpMainView()
      {
         super();
         TexpTipsView;
         texpGuide();
      }
      
      override protected function initialize() : void
      {
         var i:int = 0;
         super.initialize();
         texpBtn.clickHandler = new Handler(__onClickTexp);
         viewTab.selectHandler = new Handler(__onSelectTabView);
         tabList0.selectHandler = new Handler(__onSelectPropertyBtn);
         tabList1.selectHandler = new Handler(__onSelectPropertyBtn);
         buyTexpBtn0.clickHandler = new Handler(__onClickBuyTexp,[40002]);
         buyTexpBtn1.clickHandler = new Handler(__onClickBuyTexp,[40008]);
         buyTexpBtn0.tipData = getGoodTipInfo(40002);
         buyTexpBtn1.tipData = getGoodTipInfo(40008);
         _texpCell = ComponentFactory.Instance.creatCustomObject("texpSystem.texpCell");
         addChild(_texpCell);
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"texpSystem.btnHelp",null,LanguageMgr.GetTranslation("texpSystem.view.TexpView.helpTitle"),"texpSystem.help.content",408,488);
         _allInjectSCB = ComponentFactory.Instance.creatComponentByStylename("texpSystem.allInjectSCB");
         addChild(_allInjectSCB);
         _allInjectSCB.selected = true;
         var wx:Array = [0,1,2,3,4,5,6];
         var nx:Array = [7,8,9,10,11,12,13];
         for(i = 0; i < 7; )
         {
            (tabList0.getChildByName("item" + i) as ITip).tipData = LanguageMgr.GetTranslation("texpSystem.view.TexpView.texpTip",TexpManager.Instance.getName(wx[i]));
            (tabList1.getChildByName("item" + i) as ITip).tipData = LanguageMgr.GetTranslation("texpSystem.view.TexpView.texpTip",TexpManager.Instance.getName(nx[i]));
            i++;
         }
         PlayerManager.Instance.Self.StoreBag.addEventListener("update",__onUpdateStoreBag);
         PlayerManager.Instance.Self.addEventListener("propertychange",__onPlayerPropertyEventHander);
         TexpManager.Instance.addEventListener("texpproperty",__onChange);
         updateLevelLabel();
         updateTexpLimitTxt();
         viewTab.selectedIndex = 0;
      }
      
      private function texpGuide() : void
      {
         if(!PlayerManager.Instance.Self.isNewOnceFinish(124))
         {
            if(PlayerManager.Instance.Self.Grade == 13 && TaskManager.instance.isAchieved(TaskManager.instance.getQuestByID(7)))
            {
               NewHandContainer.Instance.hideGuideCover();
               NewHandContainer.Instance.showArrow(140,45,localToGlobal(new Point(347,235)),"asset.trainer.txtTexpGuide","guide.texp.txtPos",LayerManager.Instance.getLayerByType(2));
            }
         }
      }
      
      public function clearInfo() : void
      {
         SocketManager.Instance.out.sendClearStoreBag();
         _texpCell.info = null;
      }
      
      public function startShine() : void
      {
         _texpCell.startShine();
      }
      
      public function stopShine() : void
      {
         _texpCell.stopShine();
      }
      
      private function updateLevelLabel() : void
      {
         var i:int = 0;
         var index:int = 0;
         var info:* = null;
         var startIndex:int = viewTab.selectedIndex == 0?0:7;
         for(i = 0; i < 7; )
         {
            index = startIndex + i;
            info = TexpManager.Instance.getInfo(index,TexpManager.Instance.getExp(index));
            this["levelLabel" + i].text = LanguageMgr.GetTranslation("ddt.cardSystem.CardEquipView.levelText") + info.lv.toString();
            i++;
         }
      }
      
      private function __onClickBuyTexp(type:int) : void
      {
         SoundManager.instance.playButtonSound();
      }
      
      private function __onChange(evt:TexpEvent) : void
      {
         updateView();
      }
      
      private function __onPlayerPropertyEventHander(e:PlayerPropertyEvent) : void
      {
         updateTexpLimitTxt();
         updateLevelLabel();
      }
      
      private function updateTexpLimitTxt() : void
      {
         var count:int = 0;
         var addTexpCount:int = 0;
         if(TexpManager.Instance.isXiuLianDaShi(PlayerManager.Instance.Self.buffInfo))
         {
            addTexpCount = 5;
         }
         else
         {
            addTexpCount = 0;
         }
         var total:int = (PlayerManager.Instance.Self.Grade + addTexpCount) * 2;
         var _loc5_:* = TexpManager.Instance.texpType;
         if(20 !== _loc5_)
         {
            if(53 !== _loc5_)
            {
               if(78 === _loc5_)
               {
                  count = PlayerManager.Instance.Self.nsTexpCount;
               }
            }
            else
            {
               count = PlayerManager.Instance.Self.magicTexpCount;
            }
         }
         else
         {
            count = PlayerManager.Instance.Self.texpCount;
         }
         var limit:int = total - count;
         totalNum.count = total;
         usableNum.count = limit;
      }
      
      private function __onUpdateStoreBag(evt:BagEvent) : void
      {
         var place:* = 0;
         var itemInfo:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = evt.changedSlots;
         for(place in evt.changedSlots)
         {
            if(place == 0)
            {
               itemInfo = PlayerManager.Instance.Self.StoreBag.items[0];
               if(itemInfo && (itemInfo.CategoryID == 20 || itemInfo.CategoryID == 53 || itemInfo.CategoryID == 78))
               {
                  _texpCell.info = itemInfo;
               }
               else
               {
                  _texpCell.info = null;
               }
            }
         }
      }
      
      private function updateView() : void
      {
         var currentExp:Number = NaN;
         var rate:Number = NaN;
         var info:TexpInfo = TexpManager.Instance.getInfo(_currentType,TexpManager.Instance.getExp(_currentType));
         _texpCell.texpInfo = info;
         propertyImage.index = _currentType;
         levelLabel.text = info.lv.toString();
         effectLabel.text = info.currEffect.toString();
         nextEffectLabel.text = info.upEffect.toString();
         if(info.upExp != 0)
         {
            currentExp = info.currExp / info.upExp * 100;
            rate = currentExp / 100 > 1?1:Number(currentExp / 100);
            progressLabel.text = Math.floor(rate * 10000) / 100 + "%";
            progress.value = rate;
         }
         else
         {
            progress.value = 0;
            progressLabel.text = "0%";
         }
         progress.tipData = info.currExp + "/" + info.upExp;
         updateTexpLimitTxt();
      }
      
      private function __onSelectTabView(selectedIndex:int) : void
      {
         SoundManager.instance.playButtonSound();
         tabViewBg.index = selectedIndex;
         if(selectedIndex == 0)
         {
            if(tabList0.selectedIndex != 0)
            {
               tabList0.selectedIndex = 0;
            }
            else
            {
               __onSelectPropertyBtn(0);
            }
            var _loc2_:Boolean = false;
            buyTexpBtn1.visible = _loc2_;
            tabList1.visible = _loc2_;
            _loc2_ = true;
            buyTexpBtn0.visible = _loc2_;
            tabList0.visible = _loc2_;
         }
         else
         {
            if(tabList1.selectedIndex != 0)
            {
               tabList1.selectedIndex = 0;
            }
            else
            {
               __onSelectPropertyBtn(0);
            }
            _loc2_ = false;
            buyTexpBtn0.visible = _loc2_;
            tabList0.visible = _loc2_;
            _loc2_ = true;
            buyTexpBtn1.visible = _loc2_;
            tabList1.visible = _loc2_;
         }
         updateLevelLabel();
      }
      
      private function __onSelectPropertyBtn(index:int) : void
      {
         SoundManager.instance.playButtonSound();
         var realIndex:* = index;
         if(viewTab.selectedIndex == 0)
         {
            if(index == 5 || index == 6)
            {
               TexpManager.Instance.texpType = 53;
            }
            else
            {
               TexpManager.Instance.texpType = 20;
            }
         }
         else
         {
            realIndex = int(index + 7);
            TexpManager.Instance.texpType = 78;
         }
         if(_currentType == realIndex)
         {
            return;
         }
         _currentType = realIndex;
         updateView();
      }
      
      private function __onClickTexp() : void
      {
         var addTexpCount:int = 0;
         SoundManager.instance.playButtonSound();
         var info:InventoryItemInfo = _texpCell.info as InventoryItemInfo;
         if(info && info.CategoryID == TexpManager.Instance.texpType)
         {
            addTexpCount = 0;
            if(TexpManager.Instance.isXiuLianDaShi(PlayerManager.Instance.Self.buffInfo))
            {
               addTexpCount = 5;
            }
            else
            {
               addTexpCount = 0;
            }
            if(TexpManager.Instance.texpType == 53)
            {
               if(PlayerManager.Instance.Self.magicTexpCount >= (PlayerManager.Instance.Self.Grade + addTexpCount) * 2)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TexpCell.magicTexpCountToplimit"));
                  return;
               }
            }
            else if(TexpManager.Instance.texpType == 20)
            {
               if(PlayerManager.Instance.Self.texpCount >= (PlayerManager.Instance.Self.Grade + addTexpCount) * 2)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TexpCell.texpCountToplimit"));
                  return;
               }
            }
            else if(TexpManager.Instance.texpType == 78)
            {
               if(PlayerManager.Instance.Self.nsTexpCount >= (PlayerManager.Instance.Self.Grade + addTexpCount) * 2)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TexpCell.nsTexpCountToplimit"));
                  return;
               }
            }
            if(_currentType == -1)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TexpCell.selectType"));
               return;
            }
            if(TexpManager.Instance.getLv(TexpManager.Instance.getExp(_currentType)) >= PlayerManager.Instance.Self.Grade + 5)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TexpCell.lvToplimit"));
               return;
            }
            SocketManager.Instance.out.sendTexp(_currentType,info.TemplateID,!!_allInjectSCB.selected?info.Count:1,info.Place);
            NewHandContainer.Instance.hideGuideCover();
            if(!PlayerManager.Instance.Self.isNewOnceFinish(124))
            {
               NewHandContainer.Instance.clearArrowByID(140);
               SocketManager.Instance.out.syncWeakStep(124);
            }
            return;
         }
         if(TexpManager.Instance.texpType == 53)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TextCell.magicTexpTips"));
            return;
         }
         if(TexpManager.Instance.texpType == 20)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TextCell.texpTips"));
            return;
         }
         if(TexpManager.Instance.texpType == 78)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TextCell.nsTexpTips"));
            return;
         }
      }
      
      private function getGoodTipInfo(itemID:int) : GoodTipInfo
      {
         var goodInfo:GoodTipInfo = new GoodTipInfo();
         goodInfo.itemInfo = ItemManager.Instance.getTemplateById(itemID);
         goodInfo.isBalanceTip = false;
         goodInfo.typeIsSecond = false;
         return goodInfo;
      }
      
      override public function dispose() : void
      {
         clearInfo();
         PlayerManager.Instance.Self.StoreBag.removeEventListener("update",__onUpdateStoreBag);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__onPlayerPropertyEventHander);
         TexpManager.Instance.removeEventListener("texpproperty",__onChange);
         ObjectUtils.disposeObject(_btnHelp);
         _btnHelp = null;
         ObjectUtils.disposeObject(_allInjectSCB);
         _allInjectSCB = null;
         ObjectUtils.disposeObject(_texpCell);
         _texpCell = null;
         super.dispose();
      }
   }
}
