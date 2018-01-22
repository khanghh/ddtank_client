package loginDevice
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class LoginDeviceDownView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _downBtn:SimpleBitmapButton;
      
      private var _getRewardBtn:SimpleBitmapButton;
      
      private var _rewardsHBox:HBox;
      
      public function LoginDeviceDownView()
      {
         super();
         _initView();
         _initEvent();
      }
      
      private function _initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("loginDevice.mainView.downDetailsbg");
         addChild(_bg);
         if(LoginDeviceManager.instance().loginType == "3")
         {
            _getRewardBtn = ComponentFactory.Instance.creatComponentByStylename("loginDevice.downView.getRewardBtn");
            addChild(_getRewardBtn);
         }
         else
         {
            _downBtn = ComponentFactory.Instance.creatComponentByStylename("loginDevice.downView.downBtn");
            addChild(_downBtn);
         }
         var _loc2_:Array = LoginDeviceManager.instance().downRewardInfoList;
         if(_loc2_)
         {
            _rewardsHBox = ComponentFactory.Instance.creatComponentByStylename("loginDevice.downView.rewardsHBox");
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
         if(_downBtn)
         {
            _downBtn.addEventListener("click",__downHandler);
         }
         else
         {
            _getRewardBtn.addEventListener("click",__getRewardHandler);
         }
      }
      
      private function _removeEvent() : void
      {
         if(_downBtn)
         {
            _downBtn.removeEventListener("click",__downHandler);
         }
         else
         {
            _getRewardBtn.removeEventListener("click",__getRewardHandler);
         }
      }
      
      private function __downHandler(param1:MouseEvent) : void
      {
         LoginDeviceControl.instance().gotoDownDevice();
      }
      
      private function __getRewardHandler(param1:MouseEvent) : void
      {
         LoginDeviceControl.instance().getDownReward();
      }
      
      public function updateDownView() : void
      {
         if(LoginDeviceManager.instance().isGetDownReward == false)
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
         if(_downBtn)
         {
            ObjectUtils.disposeObject(_downBtn);
            _downBtn = null;
         }
         if(_getRewardBtn)
         {
            ObjectUtils.disposeObject(_getRewardBtn);
            _getRewardBtn = null;
         }
      }
   }
}
