package auctionHouse.view
{
   import bagAndInfo.bag.BagView;
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CellEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import mark.MarkMgr;
   import mark.event.MarkEvent;
   import playerDress.PlayerDressControl;
   import playerDress.event.PlayerDressEvent;
   
   public class AuctionBagView extends BagView
   {
      
      public static var MARKBAG:int = 100;
       
      
      protected var _markSelectedBtn:SelectedButton;
      
      protected var _tabBtn5:Sprite;
      
      protected var _auctionMarkList:AuctionMarkListView;
      
      private var _rankCombo:ComboBox = null;
      
      private var _nextBtn:SimpleBitmapButton;
      
      private var _preBtn:SimpleBitmapButton;
      
      private var _pageTxtBg:Bitmap;
      
      private var _pageTxt:FilterFrameText;
      
      private var pageBox:Sprite;
      
      private var _currentPage:int = 1;
      
      private var _totalPage:int = 3;
      
      public function AuctionBagView()
      {
         super();
         PlayerDressControl.instance.showBind = false;
      }
      
      override protected function initBackGround() : void
      {
         super.initBackGround();
         ObjectUtils.disposeObject(_equipSelectedBtn);
         _equipSelectedBtn = null;
         _equipSelectedBtn = ComponentFactory.Instance.creatComponentByStylename("bagView.equipTabBtn2");
         _equipSelectedBtn.mouseEnabled = false;
         _equipSelectedBtn.mouseChildren = false;
         _equipSelectedBtn.selected = true;
         addChild(_equipSelectedBtn);
         ObjectUtils.disposeObject(_propSelectedBtn);
         _propSelectedBtn = null;
         _propSelectedBtn = ComponentFactory.Instance.creatComponentByStylename("bagView.propTabBtn2");
         _propSelectedBtn.mouseEnabled = false;
         _propSelectedBtn.mouseChildren = false;
         addChild(_propSelectedBtn);
         ObjectUtils.disposeObject(_beadSelectedBtn);
         _beadSelectedBtn = null;
         _beadSelectedBtn = ComponentFactory.Instance.creatComponentByStylename("bagView.beadTabBtn2");
         _beadSelectedBtn.mouseEnabled = false;
         _beadSelectedBtn.mouseChildren = false;
         addChild(_beadSelectedBtn);
         ObjectUtils.disposeObject(_dressSelectedBtn);
         _dressSelectedBtn = null;
         _dressSelectedBtn = ComponentFactory.Instance.creatComponentByStylename("bagView.dressTabBtn2");
         _dressSelectedBtn.mouseEnabled = false;
         _dressSelectedBtn.mouseChildren = false;
         addChild(_dressSelectedBtn);
         _markSelectedBtn = ComponentFactory.Instance.creatComponentByStylename("bagView.markTabBtn2");
         _markSelectedBtn.mouseEnabled = false;
         _markSelectedBtn.mouseChildren = false;
         addChild(_markSelectedBtn);
         bagLockBtn.visible = false;
      }
      
      override protected function initTabButtons() : void
      {
         super.initTabButtons();
         removeChild(_tabBtn1);
         _tabBtn1 = new Sprite();
         _tabBtn1.graphics.beginFill(255,1);
         _tabBtn1.graphics.drawRoundRect(349,45,50,68,15,15);
         _tabBtn1.graphics.endFill();
         _tabBtn1.alpha = 0;
         _tabBtn1.buttonMode = true;
         addChild(_tabBtn1);
         removeChild(_tabBtn2);
         _tabBtn2 = new Sprite();
         _tabBtn2.graphics.beginFill(255,1);
         _tabBtn2.graphics.drawRoundRect(350,131,50,68,15,15);
         _tabBtn2.graphics.endFill();
         _tabBtn2.alpha = 0;
         _tabBtn2.buttonMode = true;
         addChild(_tabBtn2);
         removeChild(_tabBtn3);
         _tabBtn3 = new Sprite();
         _tabBtn3.graphics.beginFill(255,1);
         _tabBtn3.graphics.drawRoundRect(351,219,50,68,15,15);
         _tabBtn3.graphics.endFill();
         _tabBtn3.alpha = 0;
         _tabBtn3.buttonMode = true;
         addChild(_tabBtn3);
         removeChild(_tabBtn4);
         _tabBtn4 = new Sprite();
         _tabBtn4.graphics.beginFill(255,1);
         _tabBtn4.graphics.drawRoundRect(351,302,50,68,15,15);
         _tabBtn4.graphics.endFill();
         _tabBtn4.alpha = 0;
         _tabBtn4.buttonMode = true;
         addChild(_tabBtn4);
         _tabBtn5 = new Sprite();
         _tabBtn5.graphics.beginFill(255,1);
         _tabBtn5.graphics.drawRoundRect(351,391,50,68,15,15);
         _tabBtn5.graphics.endFill();
         _tabBtn5.alpha = 0;
         _tabBtn5.buttonMode = true;
         _tabBtn5.addEventListener("click",__itemtabBtnClick);
         addChild(_tabBtn5);
      }
      
      override protected function __itemtabBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = event.currentTarget;
         if(_tabBtn1 !== _loc2_)
         {
            if(_tabBtn2 !== _loc2_)
            {
               if(_tabBtn3 !== _loc2_)
               {
                  if(_tabBtn4 !== _loc2_)
                  {
                     if(_tabBtn5 === _loc2_)
                     {
                        setBagType(100);
                        _rankCombo.visible = true;
                        pageBox.visible = true;
                        _auctionMarkList.visible = true;
                        refreshSelectedButton(5);
                     }
                  }
                  else
                  {
                     setBagType(8);
                     refreshSelectedButton(4);
                  }
               }
               else
               {
                  if(PlayerManager.Instance.Self.Grade < 16)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.giftSystem.openBeadBtn.text",16));
                     return;
                  }
                  if(_bagType == 21)
                  {
                     return;
                  }
                  setBagType(21);
                  refreshSelectedButton(3);
               }
            }
            else
            {
               if(_bagType == 1 || _bagType == 5)
               {
                  return;
               }
               setBagType(!!_isScreenFood?5:1);
               refreshSelectedButton(2);
            }
         }
         else
         {
            if(_bagType == 0)
            {
               return;
            }
            setBagType(0);
            refreshSelectedButton(1);
         }
      }
      
      override protected function refreshSelectedButton(tag:int) : void
      {
         if(tag == 5)
         {
            _markSelectedBtn.x = 328;
            _markSelectedBtn.y = 374;
         }
         else
         {
            _markSelectedBtn.x = 351;
            _markSelectedBtn.y = 382;
         }
         if(_equipSelectedBtn)
         {
            _equipSelectedBtn.selected = tag == 1;
         }
         if(_propSelectedBtn)
         {
            _propSelectedBtn.selected = tag == 2;
         }
         if(_beadSelectedBtn)
         {
            _beadSelectedBtn.selected = tag == 3;
         }
         if(_dressSelectedBtn)
         {
            _dressSelectedBtn.selected = tag == 4;
         }
         if(_markSelectedBtn)
         {
            _markSelectedBtn.selected = tag == 5;
         }
      }
      
      override protected function initBagList() : void
      {
         _equiplist = new AuctionBagEquipListView(0);
         _proplist = new AuctionBagListView(1);
         _beadList = new AuctionBeadListView(21,32,80);
         _beadList2 = new AuctionBeadListView(21,81,129);
         _beadList3 = new AuctionBeadListView(21,130,178);
         _auctionMarkList = new AuctionMarkListView(MARKBAG,0,42,7);
         var point:Point = ComponentFactory.Instance.creatCustomObject("markBagViewlist.pos");
         _auctionMarkList.x = point.x;
         _auctionMarkList.y = point.y;
         _auctionMarkList.setMarkDic(_currentPage);
         var _loc2_:* = 14;
         _beadList3.x = _loc2_;
         _loc2_ = _loc2_;
         _beadList2.x = _loc2_;
         _loc2_ = _loc2_;
         _beadList.x = _loc2_;
         _loc2_ = _loc2_;
         _proplist.x = _loc2_;
         _equiplist.x = _loc2_;
         _auctionMarkList.visible = false;
         _auctionMarkList.addEventListener("itemclick",__cellClick);
         _loc2_ = 47;
         _beadList3.y = _loc2_;
         _loc2_ = _loc2_;
         _beadList2.y = _loc2_;
         _loc2_ = _loc2_;
         _beadList.y = _loc2_;
         _loc2_ = _loc2_;
         _proplist.y = _loc2_;
         _equiplist.y = _loc2_;
         _loc2_ = 330;
         _beadList3.width = _loc2_;
         _loc2_ = _loc2_;
         _beadList2.width = _loc2_;
         _loc2_ = _loc2_;
         _beadList.width = _loc2_;
         _loc2_ = _loc2_;
         _proplist.width = _loc2_;
         _equiplist.width = _loc2_;
         _loc2_ = 320;
         _beadList3.height = _loc2_;
         _loc2_ = _loc2_;
         _beadList2.height = _loc2_;
         _loc2_ = _loc2_;
         _beadList.height = _loc2_;
         _loc2_ = _loc2_;
         _proplist.height = _loc2_;
         _equiplist.height = _loc2_;
         _proplist.visible = false;
         _loc2_ = false;
         _beadList3.visible = _loc2_;
         _loc2_ = _loc2_;
         _beadList2.visible = _loc2_;
         _beadList.visible = _loc2_;
         _lists = [_equiplist,_proplist,_beadList,_beadList2,_beadList3];
         _currentList = _equiplist;
         addChild(_equiplist);
         addChild(_proplist);
         addChild(_beadList);
         addChild(_beadList2);
         addChild(_beadList3);
         addChild(_auctionMarkList);
         initMarkSelectComboBox();
         initMarkPage();
         MarkMgr.inst.addEventListener("updateChips",__onUpdataMarkBag);
      }
      
      private function __onUpdataMarkBag(e:MarkEvent) : void
      {
         _auctionMarkList.setMarkDic(_currentPage);
      }
      
      private function initMarkPage() : void
      {
         pageBox = new Sprite();
         addChild(pageBox);
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("markBagView.page.nextBtn");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("markBagView.page.preBtn");
         _pageTxtBg = ComponentFactory.Instance.creatBitmap("asset.markBagView.pageTxtBg");
         pageBox.addChild(_nextBtn);
         pageBox.addChild(_preBtn);
         pageBox.addChild(_pageTxtBg);
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("markBagView.pageTxt");
         pageBox.addChild(_pageTxt);
         _pageTxt.text = _currentPage.toString();
         pageBox.visible = false;
         _nextBtn.addEventListener("click",changePage);
         _preBtn.addEventListener("click",changePage);
      }
      
      private function changePage(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var tmp:SimpleBitmapButton = event.currentTarget as SimpleBitmapButton;
         var _loc3_:* = tmp;
         if(_nextBtn !== _loc3_)
         {
            if(_preBtn === _loc3_)
            {
               _currentPage = Number(_currentPage) - 1;
               if(_currentPage < 1)
               {
                  _currentPage = _totalPage;
               }
            }
         }
         else
         {
            _currentPage = Number(_currentPage) + 1;
            if(_currentPage > _totalPage)
            {
               _currentPage = 1;
            }
         }
         _pageTxt.text = _currentPage.toString();
         _auctionMarkList.setMarkDic(_currentPage);
      }
      
      private function initMarkSelectComboBox() : void
      {
         var i:int = 0;
         _rankCombo = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.markBagView.selectedComboBox");
         addChild(_rankCombo);
         _rankCombo.beginChanges();
         _rankCombo.listPanel.vectorListModel.clear();
         var rankStrs:Array = [LanguageMgr.GetTranslation("mark.type1"),LanguageMgr.GetTranslation("mark.type2"),LanguageMgr.GetTranslation("mark.type3"),LanguageMgr.GetTranslation("mark.type4"),LanguageMgr.GetTranslation("mark.type5"),LanguageMgr.GetTranslation("mark.type6")];
         for(i = 0; i < rankStrs.length; )
         {
            _rankCombo.listPanel.vectorListModel.append(rankStrs[i]);
            i++;
         }
         _rankCombo.commitChanges();
         _rankCombo.currentSelectedIndex = 0;
         _rankCombo.listPanel.list.addEventListener("listItemClick",itemClickHander);
         _rankCombo.visible = false;
      }
      
      private function itemClickHander(event:ListItemEvent) : void
      {
         var _rankType:int = event.index;
         switch(int(_rankType))
         {
            case 0:
               _auctionMarkList.type = 1003;
               break;
            case 1:
               _auctionMarkList.type = 1004;
               break;
            case 2:
               _auctionMarkList.type = 1001;
               break;
            case 3:
               _auctionMarkList.type = 1002;
               break;
            case 4:
               _auctionMarkList.type = 1005;
               break;
            case 5:
               _auctionMarkList.type = 1006;
         }
         _auctionMarkList.setMarkDic(_currentPage);
      }
      
      override protected function set_breakBtn_enable() : void
      {
         if(_breakBtn)
         {
            _breakBtn.enable = false;
            _breakBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         if(_sellBtn)
         {
            _sellBtn.enable = false;
            _sellBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         if(_keySortBtn)
         {
            _keySortBtn.enable = false;
            _keySortBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         if(_continueBtn)
         {
            _continueBtn.enable = false;
            _continueBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
      }
      
      override protected function showDressBagView(event:PlayerDressEvent) : void
      {
         super.showDressBagView(event);
      }
      
      override protected function adjustEvent() : void
      {
      }
      
      override protected function __cellOpen(evt:Event) : void
      {
      }
      
      override protected function __cellClick(evt:CellEvent) : void
      {
         var cell:* = null;
         var info:* = null;
         if(!_sellBtn.isActive)
         {
            evt.stopImmediatePropagation();
            cell = evt.data as BaseCell;
            if(cell)
            {
               info = cell.info as InventoryItemInfo;
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
      }
      
      override protected function __cellDoubleClick(evt:CellEvent) : void
      {
      }
      
      override public function setBagType(type:int) : void
      {
         if(type != MARKBAG)
         {
            _auctionMarkList.visible = false;
            _rankCombo.visible = false;
            pageBox.visible = false;
         }
         super.setBagType(type);
         if(type == 21)
         {
            adjustBeadBagPage(true);
         }
      }
      
      override public function dispose() : void
      {
         PlayerDressControl.instance.showBind = true;
         MarkMgr.inst.removeEventListener("updateChips",__onUpdataMarkBag);
         if(_rankCombo)
         {
            _rankCombo.listPanel.list.removeEventListener("listItemClick",itemClickHander);
            ObjectUtils.disposeObject(_rankCombo);
            _rankCombo = null;
         }
         if(_tabBtn5)
         {
            _tabBtn5.removeEventListener("click",__itemtabBtnClick);
         }
         if(_auctionMarkList)
         {
            _auctionMarkList.removeEventListener("itemclick",__cellClick);
         }
         ObjectUtils.disposeObject(_tabBtn5);
         _tabBtn5 = null;
         ObjectUtils.disposeObject(_markSelectedBtn);
         _markSelectedBtn = null;
         ObjectUtils.disposeObject(_auctionMarkList);
         _auctionMarkList = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_pageTxtBg);
         _pageTxtBg = null;
         ObjectUtils.disposeObject(_pageTxt);
         _pageTxt = null;
         ObjectUtils.disposeObject(pageBox);
         pageBox = null;
         super.dispose();
      }
   }
}
