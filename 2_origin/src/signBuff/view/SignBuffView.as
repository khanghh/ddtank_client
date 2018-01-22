package signBuff.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   
   public class SignBuffView extends Frame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _signBtn:SelectedButton;
      
      private var _powerBtn:SelectedButton;
      
      private var _signView:SignView;
      
      private var _powerView:PowerView;
      
      public function SignBuffView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("ddt.hall.signBuff.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("signBuff.mainFrame.bg.scale9cornerImage");
         addToContent(_bg);
         _btnGroup = new SelectedButtonGroup();
         _signBtn = ComponentFactory.Instance.creatComponentByStylename("hall.signBuff.signBtn");
         addToContent(_signBtn);
         _powerBtn = ComponentFactory.Instance.creatComponentByStylename("hall.signBuff.powerBtn");
         addToContent(_powerBtn);
         _btnGroup.addSelectItem(_signBtn);
         _btnGroup.addSelectItem(_powerBtn);
         _btnGroup.selectIndex = 0;
         _showView(_btnGroup.selectIndex);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _btnGroup.addEventListener("change",__selectedChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _btnGroup.removeEventListener("change",__selectedChangeHandler);
      }
      
      private function __selectedChangeHandler(param1:Event) : void
      {
         _showView(_btnGroup.selectIndex);
      }
      
      private function _showView(param1:int) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1))
         {
            case 0:
               if(_signView == null)
               {
                  _signView = new SignView();
                  addToContent(_signView);
               }
               else
               {
                  _signView.visible = true;
               }
               if(_powerView != null)
               {
                  _powerView.visible = false;
               }
               break;
            case 1:
               if(_powerView == null)
               {
                  _powerView = new PowerView();
                  addToContent(_powerView);
               }
               else
               {
                  _powerView.visible = true;
               }
               if(_signView != null)
               {
                  _signView.visible = false;
                  break;
               }
         }
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
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
