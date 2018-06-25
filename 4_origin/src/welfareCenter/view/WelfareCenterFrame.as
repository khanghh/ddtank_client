package welfareCenter.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import invite.InviteManager;
   import welfareCenter.WelfareCenterManager;
   import welfareCenter.callBackLotteryDraw.CallBackLotteryDrawManager;
   import welfareCenter.callBackLotteryDraw.view.CallBackLotteryDrawFrame;
   import welfareCenter.icon.WelfareCenterItem;
   import welfareCenter.icon.WelfareCenterItemTime;
   
   public class WelfareCenterFrame extends Frame
   {
       
      
      private var _currentType:int = -1;
      
      private var _bg:ScaleBitmapImage;
      
      private var _content:Sprite;
      
      private var _itemList:Vector.<WelfareCenterItem>;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _vBox:VBox;
      
      private var _backFundView:CallBackFundView;
      
      private var _backLotteryView:CallBackLotteryDrawFrame;
      
      private var _gradeGiftView:OldPlayerGradeGiftView;
      
      public function WelfareCenterFrame()
      {
         super();
      }
      
      public function show() : void
      {
         InviteManager.Instance.enabled = false;
         LayerManager.Instance.addToLayer(this,3,true,1);
         WelfareCenterManager.instance.addEventListener("change",__onCheckItemShine);
         __onCheckItemShine(null);
      }
      
      override protected function onFrameClose() : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
      }
      
      override protected function init() : void
      {
         _itemList = new Vector.<WelfareCenterItem>();
         _bg = ComponentFactory.Instance.creatComponentByStylename("welfareCenter.frameBg");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("welfareCenter.frame.vBox");
         _content = new Sprite();
         initItem();
         super.init();
         titleText = LanguageMgr.GetTranslation("ddt.welfareCenterFrame.title");
         updateView((_itemList[0] as WelfareCenterItem).type);
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         addToContent(_bg);
         addToContent(_vBox);
         addToContent(_content);
      }
      
      private function initItem() : void
      {
         var backFund:* = null;
         var backLottery:* = null;
         var gradeGift:* = null;
         _btnGroup = new SelectedButtonGroup();
         if(WelfareCenterManager.instance.getitemIsOpen(0))
         {
            backFund = new WelfareCenterItem(0);
            _vBox.addChild(backFund);
            backFund.addEventListener("click",__onClickItem);
            _itemList.push(backFund);
            _btnGroup.addSelectItem(backFund);
         }
         if(WelfareCenterManager.instance.getitemIsOpen(1))
         {
            backLottery = new WelfareCenterItemTime(1);
            _vBox.addChild(backLottery);
            backLottery.addEventListener("click",__onClickItem);
            _itemList.push(backLottery);
            _btnGroup.addSelectItem(backLottery);
            CallBackLotteryDrawManager.instance.addEventListener("event_open_frame",onOpenView);
            CallBackLotteryDrawManager.instance.addEventListener("event_zero_fresh",onZeroFresh);
         }
         if(WelfareCenterManager.instance.getitemIsOpen(2))
         {
            gradeGift = new WelfareCenterItem(2);
            _vBox.addChild(gradeGift);
            gradeGift.addEventListener("click",__onClickItem);
            _itemList.push(gradeGift);
            _btnGroup.addSelectItem(gradeGift);
         }
         _btnGroup.selectIndex = 0;
      }
      
      public function updateView($type:int) : void
      {
         if(_currentType == $type)
         {
            return;
         }
         _currentType = $type;
         if($type == 0)
         {
            if(_backFundView == null)
            {
               _backFundView = new CallBackFundView();
               PositionUtils.setPos(_backFundView,"welfareCenter.backFundViewPos");
               _content.addChild(_backFundView);
            }
            if(_backFundView)
            {
               _backFundView.visible = true;
            }
            if(_backLotteryView)
            {
               _backLotteryView.visible = false;
            }
            if(_gradeGiftView)
            {
               _gradeGiftView.visible = false;
            }
            ObjectUtils.disposeObject(_backLotteryView);
            _backLotteryView = null;
         }
         else if($type == 1)
         {
            CallBackLotteryDrawManager.instance.queryLotteryGoods(0);
         }
         else if($type == 2)
         {
            if(_gradeGiftView == null)
            {
               _gradeGiftView = new OldPlayerGradeGiftView();
               PositionUtils.setPos(_gradeGiftView,"welfareCenter.gradeGiftViewPos");
               _content.addChild(_gradeGiftView);
            }
            if(_backFundView)
            {
               _backFundView.visible = false;
            }
            if(_backLotteryView)
            {
               _backLotteryView.visible = false;
            }
            if(_gradeGiftView)
            {
               _gradeGiftView.visible = true;
            }
            ObjectUtils.disposeObject(_backLotteryView);
            _backLotteryView = null;
         }
      }
      
      protected function onOpenView(event:Event) : void
      {
         if(CallBackLotteryDrawManager.instance.type == 0 && _currentType == 1)
         {
            ObjectUtils.disposeObject(_backLotteryView);
            _backLotteryView = new CallBackLotteryDrawFrame();
            PositionUtils.setPos(_backLotteryView,"welfareCenter.backLotteryViewPos");
            _content.addChild(_backLotteryView);
            if(_backFundView)
            {
               _backFundView.visible = false;
            }
            if(_gradeGiftView)
            {
               _gradeGiftView.visible = false;
            }
         }
      }
      
      private function onZeroFresh(evt:Event) : void
      {
         if(_backLotteryView)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("callbacklotterdraw.zeroFresh"));
         }
         if(_backFundView)
         {
            updateView(0);
         }
         ObjectUtils.disposeObject(_backLotteryView);
         _backLotteryView = null;
      }
      
      private function __onClickItem(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var item:WelfareCenterItem = e.currentTarget as WelfareCenterItem;
         item.isShine = false;
         if(WelfareCenterManager.instance.getitemIsOpen(item.type))
         {
            if(item.canClick)
            {
               updateView(item.type);
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.welfareCenter.gift.waitActivity"));
            }
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.welfareCenter.gift.activityEnd"));
            item.removeEventListener("click",__onClickItem);
            _itemList.splice(_itemList.indexOf(item),1);
            _vBox.removeChild(item);
            ObjectUtils.disposeObject(item);
         }
      }
      
      private function __onCheckItemShine(e:Event = null) : void
      {
      }
      
      override public function dispose() : void
      {
         var item:* = null;
         InviteManager.Instance.enabled = true;
         WelfareCenterManager.instance.removeEventListener("change",__onCheckItemShine);
         CallBackLotteryDrawManager.instance.removeEventListener("event_open_frame",onOpenView);
         CallBackLotteryDrawManager.instance.removeEventListener("event_zero_fresh",onZeroFresh);
         while(_itemList.length)
         {
            item = _itemList.pop() as WelfareCenterItem;
            item.removeEventListener("click",__onClickItem);
         }
         _btnGroup.dispose();
         _vBox.dispose();
         _vBox = null;
         ObjectUtils.disposeAllChildren(_content);
         super.dispose();
         _itemList = null;
         _bg = null;
         _content = null;
         _backFundView = null;
         _backLotteryView = null;
         _gradeGiftView = null;
         _btnGroup = null;
      }
   }
}
