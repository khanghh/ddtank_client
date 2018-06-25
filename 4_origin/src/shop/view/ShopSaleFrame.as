package shop.view
{
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import road7th.comm.PackageIn;
   import road7th.utils.DateUtils;
   import shop.ShopEvent;
   import shop.manager.ShopSaleManager;
   
   public class ShopSaleFrame extends Frame
   {
      
      private static const CELL_COUNT:int = 9;
      
      private static const MIN_PAGE:int = 1;
       
      
      private var _bg:Bitmap;
      
      private var _currentPage:int = 1;
      
      private var _maxPage:int;
      
      private var _timeText:FilterFrameText;
      
      private var _firstPage:BaseButton;
      
      private var _prePageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _endPageBtn:BaseButton;
      
      private var _currentPageTxt:FilterFrameText;
      
      private var currentPage:int = 1;
      
      private var _currentPageTxtBg:Scale9CornerImage;
      
      private var _cellGroup:SelectedButtonGroup;
      
      private var _cellList:Vector.<ShopSaleItemCell>;
      
      private var _cellContainer:Sprite;
      
      private var _moneyText:FilterFrameText;
      
      private var _surplusTime:Number;
      
      private var _timer:Timer;
      
      public function ShopSaleFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         var i:int = 0;
         super.init();
         titleText = LanguageMgr.GetTranslation("asset.ddtshop.saleShopTitle");
         _bg = UICreatShortcut.creatAndAdd("asset.ddtshop.SaleBg",_container);
         _moneyText = UICreatShortcut.creatTextAndAdd("ddtshop.saleFrameMoneyText",PlayerManager.Instance.Self.Money.toString(),_container);
         _timeText = UICreatShortcut.creatAndAdd("ddtshop.view.saleTimeText",_container);
         _firstPage = UICreatShortcut.creatAndAdd("ddtshop.BtnFirstPage",_container);
         PositionUtils.setPos(_firstPage,"ddtshop.firstPagePos");
         _prePageBtn = UICreatShortcut.creatAndAdd("ddtshop.BtnPrePage",_container);
         PositionUtils.setPos(_prePageBtn,"ddtshop.prePageBtnPos");
         _nextPageBtn = UICreatShortcut.creatAndAdd("ddtshop.BtnNextPage",_container);
         PositionUtils.setPos(_nextPageBtn,"ddtshop.nextPageBtnPos");
         _endPageBtn = UICreatShortcut.creatAndAdd("ddtshop.BtnEndPage",_container);
         PositionUtils.setPos(_endPageBtn,"ddtshop.endPageBtnPos");
         _currentPageTxtBg = UICreatShortcut.creatAndAdd("ddtshop.CurrentPageInput",_container);
         PositionUtils.setPos(_currentPageTxtBg,"ddtshop.currentPageTxtBgPos");
         _currentPageTxt = UICreatShortcut.creatAndAdd("ddtshop.CurrentPage",_container);
         PositionUtils.setPos(_currentPageTxt,"ddtshop.currentPageTxtPagePos");
         _cellList = new Vector.<ShopSaleItemCell>(9);
         _cellContainer = new Sprite();
         PositionUtils.setPos(_cellContainer,"ddtshop.cellContainerPos");
         addToContent(_cellContainer);
         _cellGroup = new SelectedButtonGroup();
         for(i = 0; i < 9; )
         {
            _cellList[i] = new ShopSaleItemCell();
            _cellList[i].x = (_cellList[i].width + 11) * (int(i % 3));
            _cellList[i].y = (_cellList[i].height + 11) * (int(i / 3));
            _cellGroup.addSelectItem(_cellList[i]);
            _cellContainer.addChild(_cellList[i]);
            i++;
         }
         initEvent();
         updateSaleGoods();
         setTimeView();
      }
      
      private function __pageBtnClick(e:MouseEvent) : void
      {
         var _loc2_:* = e.currentTarget;
         if(_firstPage !== _loc2_)
         {
            if(_prePageBtn !== _loc2_)
            {
               if(_nextPageBtn !== _loc2_)
               {
                  if(_endPageBtn === _loc2_)
                  {
                     if(_currentPage != _maxPage)
                     {
                        _currentPage = _maxPage;
                        updateSaleGoods();
                     }
                  }
               }
               else
               {
                  _currentPage = _currentPage + 1;
                  if(_currentPage + 1 > _maxPage)
                  {
                     _currentPage = 1;
                  }
                  updateSaleGoods();
               }
            }
            else
            {
               _currentPage = _currentPage - 1;
               if(_currentPage - 1 < 1)
               {
                  _currentPage = _maxPage;
               }
               updateSaleGoods();
            }
         }
         else if(_currentPage != 1)
         {
            _currentPage = 1;
            updateSaleGoods();
         }
      }
      
      public function updateSaleGoods() : void
      {
         var i:int = 0;
         if(!ShopSaleManager.Instance.isOpen)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("asset.ddtshop.saleActivityFinish"));
            activityEnd();
            return;
         }
         _maxPage = int(Math.ceil(ShopSaleManager.Instance.shopSaleList.length / 9));
         _currentPageTxt.text = _currentPage + "/" + _maxPage;
         var list:Vector.<ShopItemInfo> = ShopManager.Instance.getValidSortedGoodsByList(ShopSaleManager.Instance.shopSaleList,_currentPage,9);
         for(i = 0; i < 9; )
         {
            if(list.length > i)
            {
               _cellList[i].info = list[i];
            }
            else
            {
               _cellList[i].info = null;
            }
            i++;
         }
         SocketManager.Instance.out.sendUpdateGoodsCount();
      }
      
      private function setTimeView() : void
      {
         if(ShopSaleManager.Instance.isOpen)
         {
            _surplusTime = (DateUtils.decodeDated(_cellList[0].info.EndDate).time - TimeManager.Instance.Now().time) / 1000;
            _timeText.text = LanguageMgr.GetTranslation("asset.ddtshop.surplusTime",transSecond(_surplusTime));
            if(_surplusTime <= 0)
            {
               return;
            }
            _timer = new Timer(1000);
            _timer.addEventListener("timer",__onUpdateTime);
            _timer.start();
         }
      }
      
      private function __onUpdateTime(e:TimerEvent) : void
      {
         _surplusTime = Number(_surplusTime) - 1;
         if(_surplusTime > 0)
         {
            _timeText.text = LanguageMgr.GetTranslation("asset.ddtshop.surplusTime",transSecond(_surplusTime));
         }
         else if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__onUpdateTime);
            _timer = null;
            activityEnd();
         }
      }
      
      private function activityEnd() : void
      {
         ShopSaleManager.Instance.removeEnterIcon();
         var _loc3_:int = 0;
         var _loc2_:* = _cellList;
         for each(var list in _cellList)
         {
            list.limitNum = 0;
         }
      }
      
      private function transSecond(num:Number) : String
      {
         var hour:int = Math.floor(num / 3600);
         if(hour > 24)
         {
            return String(Math.ceil(hour / 24)) + LanguageMgr.GetTranslation("day");
         }
         var minite:int = Math.floor((num - hour * 3600) / 60);
         var second:int = num - hour * 3600 - minite * 60;
         return (String("0" + hour)).substr(-2) + ":" + (String("0" + minite)).substr(-2) + ":" + (String("0" + second)).substr(-2);
      }
      
      private function __onUpdateMoney(e:PlayerPropertyEvent) : void
      {
         if(e.changedProperties["Money"])
         {
            _moneyText.text = PlayerManager.Instance.Self.Money.toString();
         }
      }
      
      private function __updataLimitAreaCountHandler(evt:ShopEvent) : void
      {
         updateSaleGoods();
      }
      
      private function __onUpdateLimitCount(e:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var j:int = 0;
         var pkg:PackageIn = e.pkg;
         var length:int = pkg.readInt();
         var tempID:int = 0;
         var count:int = 0;
         if(length > 0)
         {
            for(i = 0; i < length; )
            {
               tempID = pkg.readInt();
               count = pkg.readInt();
               for(j = 0; j < 9; )
               {
                  if(_cellList[j].info && tempID == _cellList[j].info.TemplateID)
                  {
                     _cellList[j].limitNum = _cellList[j].info.LimitPersonalCount - count;
                  }
                  j++;
               }
               i++;
            }
         }
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(478),__onUpdateLimitCount);
         _firstPage.addEventListener("click",__pageBtnClick);
         _prePageBtn.addEventListener("click",__pageBtnClick);
         _nextPageBtn.addEventListener("click",__pageBtnClick);
         _endPageBtn.addEventListener("click",__pageBtnClick);
         PlayerManager.Instance.Self.addEventListener("propertychange",__onUpdateMoney);
         ShopManager.Instance.addEventListener("updataLimitAreaCount",__updataLimitAreaCountHandler);
      }
      
      private function removeEvent() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(478),__onUpdateLimitCount);
         _firstPage.removeEventListener("click",__pageBtnClick);
         _prePageBtn.removeEventListener("click",__pageBtnClick);
         _nextPageBtn.removeEventListener("click",__pageBtnClick);
         _endPageBtn.removeEventListener("click",__pageBtnClick);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__onUpdateMoney);
         ShopManager.Instance.removeEventListener("updataLimitAreaCount",__updataLimitAreaCountHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ShopSaleManager.Instance.goodsBuyMaxNum = 0;
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__onUpdateTime);
            _timer = null;
         }
         while(_cellList.length)
         {
            _cellList.pop();
         }
         _cellList = null;
         _cellGroup.dispose();
         _cellGroup = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_moneyText);
         _moneyText = null;
         ObjectUtils.disposeObject(_timeText);
         _timeText = null;
         ObjectUtils.disposeObject(_firstPage);
         _firstPage = null;
         ObjectUtils.disposeObject(_prePageBtn);
         _prePageBtn = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         ObjectUtils.disposeObject(_endPageBtn);
         _endPageBtn = null;
         super.dispose();
      }
   }
}
