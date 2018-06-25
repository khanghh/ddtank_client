package demonChiYou.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import demonChiYou.DemonChiYouController;
   import demonChiYou.DemonChiYouManager;
   import demonChiYou.DemonChiYouModel;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class DemonChiYouRewardSelectFrame extends Frame
   {
       
      
      private var _btnHelp:BaseButton;
      
      private var _mgr:DemonChiYouManager;
      
      private var _model:DemonChiYouModel;
      
      private var _consortiaNameTf1:FilterFrameText;
      
      private var _consortiaNameTf2:FilterFrameText;
      
      private var _consortiaNameTf3:FilterFrameText;
      
      private var _leftTimeImage:Image;
      
      private var _leftTimeTf:FilterFrameText;
      
      private var _itemArr:Array;
      
      private var _leftTimeTimer:Timer;
      
      private var _leftTimeImageW:int;
      
      private var _leftSec:int;
      
      public function DemonChiYouRewardSelectFrame()
      {
         super();
         _mgr = DemonChiYouManager.instance;
         _model = _mgr.model;
         addEventListener("response",responseHandler);
         DemonChiYouManager.instance.addEventListener("event_shop_info_back",onShopInfoBack);
         SocketManager.Instance.out.getDemonChiYouShopInfo();
      }
      
      private function onShopInfoBack(evt:Event) : void
      {
         if(_model.leftSelectSec > 0)
         {
            initView();
            initEvent();
            _leftSec = _model.leftSelectSec;
            _leftTimeTimer = new Timer(200,Math.round(_leftSec * 1000 / 200));
            _leftTimeTimer.addEventListener("timer",onUpdateLeftTime);
            _leftTimeTimer.addEventListener("timerComplete",onCompleteLeftTime);
            _leftTimeTimer.start();
            onUpdateLeftTime(null);
         }
         else
         {
            DemonChiYouController.instance.disposeRewardSelectFrame();
         }
      }
      
      private function initView() : void
      {
         var rewardBox:* = null;
         var bagCell:* = null;
         var i:int = 0;
         var rankItem:* = null;
         var item:* = null;
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"core.helpButtonCircle",{
            "x":647,
            "y":36
         },LanguageMgr.GetTranslation("store.view.HelpButtonText"),"Demonchiyou.help",438,550);
         for(i = 1; i < 5; )
         {
            rewardBox = UICreatShortcut.creatAndAdd("demonChiYou.rewardBox" + i,_container);
            bagCell = new BagCell(1);
            bagCell.alpha = 0;
            bagCell.setContentSize(70,70);
            bagCell.info = ItemManager.Instance.getTemplateById(_model.rewardBoxIDArr[i - 1]);
            PositionUtils.setPos(bagCell,rewardBox);
            _container.addChild(bagCell);
            i++;
         }
         var rankArr:Array = _model.rankInfo.rankArr;
         var consortiaNameArr:Array = [];
         for(i = 0; i < 3; )
         {
            if(i < rankArr.length)
            {
               rankItem = rankArr[i];
               consortiaNameArr[i] = rankItem["Name"];
            }
            else
            {
               consortiaNameArr[i] = LanguageMgr.GetTranslation("tank.room.RoomIIPlayerItem.new");
            }
            i++;
         }
         _consortiaNameTf1 = UICreatShortcut.creatTextAndAdd("demonChiYou.consortiaNameTf1",consortiaNameArr[0],_container);
         _consortiaNameTf2 = UICreatShortcut.creatTextAndAdd("demonChiYou.consortiaNameTf2",consortiaNameArr[1],_container);
         _consortiaNameTf3 = UICreatShortcut.creatTextAndAdd("demonChiYou.consortiaNameTf3",consortiaNameArr[2],_container);
         _leftTimeImage = UICreatShortcut.creatAndAdd("demonChiYou.leftTimeImage",_container);
         _leftTimeImageW = _leftTimeImage.width;
         _leftTimeTf = UICreatShortcut.creatTextAndAdd("demonChiYou.leftTimeTf","30" + LanguageMgr.GetTranslation("second"),_container);
         UICreatShortcut.creatTextAndAdd("demonChiYou.rollTipTf",LanguageMgr.GetTranslation("demonChiYou.rollTip"),_container);
         _itemArr = [];
         for(i = 0; i < 9; )
         {
            item = new RewardSelectItem(i);
            item.x = 24 + 221 * (i % 3);
            item.y = 235 + 83 * (int(i / 3));
            _itemArr.push(item);
            _container.addChild(item);
            i++;
         }
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",responseHandler);
         _leftTimeTimer && _leftTimeTimer.removeEventListener("timer",onUpdateLeftTime);
         _leftTimeTimer && _leftTimeTimer.removeEventListener("timerComplete",onCompleteLeftTime);
         DemonChiYouManager.instance.removeEventListener("event_shop_info_back",onShopInfoBack);
      }
      
      private function onUpdateLeftTime(evt:TimerEvent) : void
      {
         var leftTimeSec:int = _leftSec - _leftSec * _leftTimeTimer.currentCount / _leftTimeTimer.repeatCount;
         _leftTimeImage.width = _leftTimeImageW * leftTimeSec / 30;
         _leftTimeTf.text = leftTimeSec + LanguageMgr.GetTranslation("second");
         _model.leftSelectSec = leftTimeSec;
      }
      
      private function onCompleteLeftTime(evt:TimerEvent) : void
      {
         _leftTimeTimer.stop();
         DemonChiYouController.instance.disposeRewardSelectFrame();
      }
      
      private function responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.playButtonSound();
            DemonChiYouController.instance.disposeRewardSelectFrame();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         _btnHelp = null;
         _mgr = null;
         _model = null;
         _consortiaNameTf1 = null;
         _consortiaNameTf2 = null;
         _consortiaNameTf3 = null;
         _leftTimeImage = null;
         _leftTimeTf = null;
         _itemArr = null;
         _leftTimeTimer && _leftTimeTimer.stop();
         _leftTimeTimer = null;
      }
   }
}
