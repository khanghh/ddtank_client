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
      
      private function onShopInfoBack(param1:Event) : void
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
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc7_:int = 0;
         var _loc1_:* = null;
         var _loc3_:* = null;
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"core.helpButtonCircle",{
            "x":647,
            "y":36
         },LanguageMgr.GetTranslation("store.view.HelpButtonText"),"Demonchiyou.help",438,550);
         _loc7_ = 1;
         while(_loc7_ < 5)
         {
            _loc5_ = UICreatShortcut.creatAndAdd("demonChiYou.rewardBox" + _loc7_,_container);
            _loc2_ = new BagCell(1);
            _loc2_.alpha = 0;
            _loc2_.setContentSize(70,70);
            _loc2_.info = ItemManager.Instance.getTemplateById(_model.rewardBoxIDArr[_loc7_ - 1]);
            PositionUtils.setPos(_loc2_,_loc5_);
            _container.addChild(_loc2_);
            _loc7_++;
         }
         var _loc6_:Array = _model.rankInfo.rankArr;
         var _loc4_:Array = [];
         _loc7_ = 0;
         while(_loc7_ < 3)
         {
            if(_loc7_ < _loc6_.length)
            {
               _loc1_ = _loc6_[_loc7_];
               _loc4_[_loc7_] = _loc1_["Name"];
            }
            else
            {
               _loc4_[_loc7_] = LanguageMgr.GetTranslation("tank.room.RoomIIPlayerItem.new");
            }
            _loc7_++;
         }
         _consortiaNameTf1 = UICreatShortcut.creatTextAndAdd("demonChiYou.consortiaNameTf1",_loc4_[0],_container);
         _consortiaNameTf2 = UICreatShortcut.creatTextAndAdd("demonChiYou.consortiaNameTf2",_loc4_[1],_container);
         _consortiaNameTf3 = UICreatShortcut.creatTextAndAdd("demonChiYou.consortiaNameTf3",_loc4_[2],_container);
         _leftTimeImage = UICreatShortcut.creatAndAdd("demonChiYou.leftTimeImage",_container);
         _leftTimeImageW = _leftTimeImage.width;
         _leftTimeTf = UICreatShortcut.creatTextAndAdd("demonChiYou.leftTimeTf","30" + LanguageMgr.GetTranslation("second"),_container);
         UICreatShortcut.creatTextAndAdd("demonChiYou.rollTipTf",LanguageMgr.GetTranslation("demonChiYou.rollTip"),_container);
         _itemArr = [];
         _loc7_ = 0;
         while(_loc7_ < 9)
         {
            _loc3_ = new RewardSelectItem(_loc7_);
            _loc3_.x = 24 + 221 * (_loc7_ % 3);
            _loc3_.y = 235 + 83 * (int(_loc7_ / 3));
            _itemArr.push(_loc3_);
            _container.addChild(_loc3_);
            _loc7_++;
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
      
      private function onUpdateLeftTime(param1:TimerEvent) : void
      {
         var _loc2_:int = _leftSec - _leftSec * _leftTimeTimer.currentCount / _leftTimeTimer.repeatCount;
         _leftTimeImage.width = _leftTimeImageW * _loc2_ / 30;
         _leftTimeTf.text = _loc2_ + LanguageMgr.GetTranslation("second");
         _model.leftSelectSec = _loc2_;
      }
      
      private function onCompleteLeftTime(param1:TimerEvent) : void
      {
         _leftTimeTimer.stop();
         DemonChiYouController.instance.disposeRewardSelectFrame();
      }
      
      private function responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
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
