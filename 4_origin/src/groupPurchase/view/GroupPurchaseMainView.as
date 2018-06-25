package groupPurchase.view
{
   import com.pickgliss.events.ComponentEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import groupPurchase.GroupPurchaseControl;
   import groupPurchase.GroupPurchaseManager;
   import wonderfulActivity.WonderfulActivityControl;
   import wonderfulActivity.WonderfulFrame;
   import wonderfulActivity.views.IRightView;
   
   public class GroupPurchaseMainView extends Sprite implements Disposeable, IRightView
   {
       
      
      private var _bg:Bitmap;
      
      private var _topBg:Bitmap;
      
      private var _rankBtn:SimpleBitmapButton;
      
      private var _countDownTxt:FilterFrameText;
      
      private var _curDiscountTxt:FilterFrameText;
      
      private var _nextDiscountTxt:FilterFrameText;
      
      private var _nextNeedNumTxt:FilterFrameText;
      
      private var _totalNumTxt:FilterFrameText;
      
      private var _myNumTxt:FilterFrameText;
      
      private var _curRebateTxt:FilterFrameText;
      
      private var _nextRebateTxt:FilterFrameText;
      
      private var _miniNeedNum:FilterFrameText;
      
      private var _shopItemCell:GroupPurchaseShopCell;
      
      private var _rankFrame:GroupPurchaseRankFrame;
      
      private var _recordWonderfulFramePos:Point;
      
      private var _helpBtn:BaseButton;
      
      private var _endTime:Date;
      
      private var _timer:Timer;
      
      private var _timer2:Timer;
      
      private var _awardView:GroupPurchaseAwardView;
      
      public function GroupPurchaseMainView()
      {
         _recordWonderfulFramePos = new Point();
         super();
         GroupPurchaseControl.instance.loadResModule(initThis);
      }
      
      private function initThis() : void
      {
         PositionUtils.setPos(this,"groupPurchase.mainViewPos");
         initView();
         initEvent();
         initCountDown();
         initRefreshData();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.groupPurchase.bg");
         _topBg = ComponentFactory.Instance.creatBitmap("asset.groupPurchase.topBg");
         _countDownTxt = ComponentFactory.Instance.creatComponentByStylename("groupPurchase.countDownTxt");
         _curDiscountTxt = ComponentFactory.Instance.creatComponentByStylename("groupPurchase.countDownTxt");
         PositionUtils.setPos(_curDiscountTxt,"groupPurchase.curDiscountTxtPos");
         _nextDiscountTxt = ComponentFactory.Instance.creatComponentByStylename("groupPurchase.countDownTxt");
         PositionUtils.setPos(_nextDiscountTxt,"groupPurchase.nextDiscountTxtPos");
         _nextNeedNumTxt = ComponentFactory.Instance.creatComponentByStylename("groupPurchase.nextNeedNumTxt");
         _totalNumTxt = ComponentFactory.Instance.creatComponentByStylename("groupPurchase.totalNumTxt");
         _myNumTxt = ComponentFactory.Instance.creatComponentByStylename("groupPurchase.totalNumTxt");
         PositionUtils.setPos(_myNumTxt,"groupPurchase.myNumTxtPos");
         _curRebateTxt = ComponentFactory.Instance.creatComponentByStylename("groupPurchase.totalNumTxt");
         PositionUtils.setPos(_curRebateTxt,"groupPurchase.curRebatePos");
         _nextRebateTxt = ComponentFactory.Instance.creatComponentByStylename("groupPurchase.totalNumTxt");
         PositionUtils.setPos(_nextRebateTxt,"groupPurchase.nextRebatePos");
         _miniNeedNum = ComponentFactory.Instance.creatComponentByStylename("groupPurchase.miniNeedNumTxt");
         _miniNeedNum.text = LanguageMgr.GetTranslation("ddt.groupPurchase.miniNeedNumTxt",GroupPurchaseManager.instance.miniNeedNum);
         _shopItemCell = new GroupPurchaseShopCell();
         PositionUtils.setPos(_shopItemCell,"groupPurchase.shopItemCellPos");
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(null,"groupPurchase.HelpButton",null,LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.groupPurchase.helpPromptTxt",404,484);
         _rankBtn = ComponentFactory.Instance.creatComponentByStylename("groupPurchase.rankBtn");
         _awardView = new GroupPurchaseAwardView();
         addChild(_bg);
         addChild(_topBg);
         addChild(_countDownTxt);
         addChild(_curDiscountTxt);
         addChild(_nextDiscountTxt);
         addChild(_nextNeedNumTxt);
         addChild(_totalNumTxt);
         addChild(_myNumTxt);
         addChild(_curRebateTxt);
         addChild(_nextRebateTxt);
         addChild(_miniNeedNum);
         addChild(_shopItemCell);
         addChild(_awardView);
         addChild(_helpBtn);
         addChild(_rankBtn);
      }
      
      private function initEvent() : void
      {
         _rankBtn.addEventListener("click",rankBtnClickHandler,false,0,true);
         GroupPurchaseManager.instance.addEventListener("GROUP_PURCHASE_REFRESH_DATA",refreshView);
      }
      
      private function initCountDown() : void
      {
         _endTime = GroupPurchaseManager.instance.endTime;
         _timer = new Timer(1000);
         _timer.addEventListener("timer",refreshCountDownTime,false,0,true);
         _timer.start();
         refreshCountDownTime(null);
      }
      
      private function initRefreshData() : void
      {
         _timer2 = new Timer(getRefreshDelay());
         _timer2.addEventListener("timer",requestRefreshData,false,0,true);
         _timer2.start();
         SocketManager.Instance.out.sendGroupPurchaseRefreshData();
      }
      
      private function requestRefreshData(event:TimerEvent) : void
      {
         SocketManager.Instance.out.sendGroupPurchaseRefreshData();
         _timer2.delay = getRefreshDelay();
      }
      
      private function getRefreshDelay() : int
      {
         var differ:Number = (_endTime.getTime() - TimeManager.Instance.Now().getTime()) / 1000;
         if(differ > 3600)
         {
            return 180000;
         }
         return 15000;
      }
      
      private function rankBtnClickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var tmpFrame:WonderfulFrame = WonderfulActivityControl.Instance.frame;
         if(!_rankFrame)
         {
            _rankFrame = ComponentFactory.Instance.creatComponentByStylename("GroupPurchaseRankFrame");
            _rankFrame.addEventListener("dispose",rankFrameDisposeHandler,false,0,true);
            LayerManager.Instance.addToLayer(_rankFrame,2,false);
            _recordWonderfulFramePos.x = 7;
            _recordWonderfulFramePos.y = 27;
            PositionUtils.setPos(_rankFrame,"groupPurchase.rankFramePos");
         }
         else
         {
            ObjectUtils.disposeObject(_rankFrame);
         }
      }
      
      private function rankFrameDisposeHandler(event:ComponentEvent) : void
      {
         _rankFrame.removeEventListener("dispose",rankFrameDisposeHandler);
         _rankFrame = null;
      }
      
      private function refreshView(event:Event) : void
      {
         var viewData:Array = GroupPurchaseManager.instance.viewData;
         _curDiscountTxt.text = viewData[0] + "%";
         if(viewData[1] == -1)
         {
            _nextDiscountTxt.text = LanguageMgr.GetTranslation("ddt.groupPurchase.discountHighestTxt");
         }
         else
         {
            _nextDiscountTxt.text = viewData[1] + "%";
         }
         if(viewData[2] == -1)
         {
            _nextNeedNumTxt.text = "";
         }
         else
         {
            _nextNeedNumTxt.text = LanguageMgr.GetTranslation("ddt.groupPurchase.nextNeedNumTxt",viewData[2]);
         }
         _totalNumTxt.text = viewData[3];
         _myNumTxt.text = viewData[4];
         _curRebateTxt.text = viewData[5];
         _nextRebateTxt.text = viewData[6];
      }
      
      private function refreshCountDownTime(event:TimerEvent) : void
      {
         _countDownTxt.text = TimeManager.Instance.getMaxRemainDateStr(_endTime);
      }
      
      public function init() : void
      {
      }
      
      public function content() : Sprite
      {
         return this;
      }
      
      public function setState(type:int, id:int) : void
      {
      }
      
      private function removeEvent() : void
      {
         if(_rankBtn)
         {
            _rankBtn.removeEventListener("click",rankBtnClickHandler);
         }
         GroupPurchaseManager.instance.removeEventListener("GROUP_PURCHASE_REFRESH_DATA",refreshView);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_timer)
         {
            _timer.removeEventListener("timer",refreshCountDownTime);
            _timer.stop();
         }
         _timer = null;
         if(_timer2)
         {
            _timer2.removeEventListener("timer",requestRefreshData);
            _timer2.stop();
         }
         _timer2 = null;
         _recordWonderfulFramePos = null;
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _topBg = null;
         _countDownTxt = null;
         _curDiscountTxt = null;
         _nextDiscountTxt = null;
         _nextNeedNumTxt = null;
         _totalNumTxt = null;
         _myNumTxt = null;
         _curRebateTxt = null;
         _nextRebateTxt = null;
         _miniNeedNum = null;
         _shopItemCell = null;
         _helpBtn = null;
         _rankBtn = null;
         _awardView = null;
         if(_rankFrame)
         {
            _rankFrame.removeEventListener("dispose",rankFrameDisposeHandler);
            ObjectUtils.disposeObject(_rankFrame);
         }
         _rankFrame = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
