package loginDevice
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   
   public class LoginDeviceMainFrame extends Frame implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _bgbottom:ScaleBitmapImage;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _downBtn:SelectedButton;
      
      private var _rewardBtn:SelectedButton;
      
      private var _downView:LoginDeviceDownView;
      
      private var _rewardView:LoginDeviceRewardView;
      
      public function LoginDeviceMainFrame()
      {
         super();
         escEnable = true;
         titleText = LanguageMgr.GetTranslation("loginDevice.mainFrame.titleTxt");
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("loginDevice.mainFrame.bg.scale9cornerImage");
         addToContent(_bg);
         _bgbottom = ComponentFactory.Instance.creatComponentByStylename("loginDevice.mainFrame.bgbottom.scale9cornerImage");
         addToContent(_bgbottom);
         _btnGroup = new SelectedButtonGroup();
         _rewardBtn = ComponentFactory.Instance.creatComponentByStylename("loginDeviceMainFrame.rewardSelectedBtn");
         addToContent(_rewardBtn);
         _btnGroup.addSelectItem(_rewardBtn);
         if(LoginDeviceManager.instance().isGetDownReward == false)
         {
            _downBtn = ComponentFactory.Instance.creatComponentByStylename("loginDeviceMainFrame.downSelectedBtn");
            addToContent(_downBtn);
            _btnGroup.addSelectItem(_downBtn);
            _btnGroup.selectIndex = 1;
            PositionUtils.setPos(_rewardBtn,"loginDevice.mainFrame.rewardBtn.pos2");
         }
         else
         {
            _btnGroup.selectIndex = 0;
         }
         _showView(_btnGroup.selectIndex);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",_response);
         _btnGroup.addEventListener("change",__selectedChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",_response);
         _btnGroup.removeEventListener("change",__selectedChangeHandler);
      }
      
      private function _response(e:FrameEvent) : void
      {
         if(e.responseCode == 0 || e.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function __selectedChangeHandler(e:Event) : void
      {
         _showView(_btnGroup.selectIndex);
      }
      
      private function _showView(type:int) : void
      {
         SoundManager.instance.play("008");
         switch(int(type))
         {
            case 0:
               if(_rewardView == null)
               {
                  _rewardView = new LoginDeviceRewardView();
                  addToContent(_rewardView);
               }
               else
               {
                  _rewardView.visible = true;
               }
               if(_downView != null)
               {
                  _downView.visible = false;
                  break;
               }
               break;
            case 1:
               if(_downView == null)
               {
                  _downView = new LoginDeviceDownView();
                  addToContent(_downView);
               }
               else
               {
                  _downView.visible = true;
               }
               if(_rewardView != null)
               {
                  _rewardView.visible = false;
               }
         }
      }
      
      public function viewsUpdate() : void
      {
         if(_rewardView)
         {
            _rewardView.updateRewardView();
         }
         if(_downView)
         {
            _downView.updateDownView();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
