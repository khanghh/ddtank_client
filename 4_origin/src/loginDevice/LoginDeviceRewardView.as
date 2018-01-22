package loginDevice
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class LoginDeviceRewardView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _getRewardBtn:SimpleBitmapButton;
      
      private var _rewardsHBox:HBox;
      
      public function LoginDeviceRewardView()
      {
         super();
         _initView();
         _initEvent();
      }
      
      private function _initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("loginDevice.mainView.rewardDetailsbg");
         addChild(_bg);
         _getRewardBtn = ComponentFactory.Instance.creatComponentByStylename("loginDevice.downView.getRewardBtn");
         addChild(_getRewardBtn);
         if(LoginDeviceManager.instance().isGetDailyReward)
         {
            _getRewardBtn.enable = false;
         }
         var _loc2_:Array = LoginDeviceManager.instance().dailyRewardInfoList;
         if(_loc2_)
         {
            _rewardsHBox = ComponentFactory.Instance.creatComponentByStylename("loginDevice.dailyView.rewardsHBox");
            addChild(_rewardsHBox);
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc1_ = LoginDeviceManager.instance().createCell(_loc2_[_loc3_]);
               _rewardsHBox.addChild(_loc1_);
               _loc3_++;
            }
         }
      }
      
      private function _initEvent() : void
      {
         _getRewardBtn.addEventListener("click",__getRewardHandler);
      }
      
      private function _removeEvent() : void
      {
         _getRewardBtn.removeEventListener("click",__getRewardHandler);
      }
      
      private function __getRewardHandler(param1:MouseEvent) : void
      {
         if(LoginDeviceManager.instance().loginTypeUnCheck == "3")
         {
            LoginDeviceControl.instance().getDailyReward();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("loginDeviceReward.NoTip"));
         }
      }
      
      public function updateRewardView() : void
      {
         if(LoginDeviceManager.instance().isGetDailyReward == false)
         {
            _getRewardBtn.enable = true;
         }
         else
         {
            _getRewardBtn.enable = false;
         }
      }
      
      public function dispose() : void
      {
         _removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_getRewardBtn)
         {
            ObjectUtils.disposeObject(_getRewardBtn);
            _getRewardBtn = null;
         }
      }
   }
}
