package ddt.view
{
   import com.pickgliss.layout.StageResizeUtils;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.DesktopManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.AssetModuleLoader;
   import ddt.utils.HelperDataModuleLoad;
   import ddt.utils.PositionUtils;
   import feedback.FeedbackManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class DailyButtunBar extends Sprite implements Disposeable
   {
      
      private static var instance:DailyButtunBar;
       
      
      private var _inited:Boolean;
      
      private var _vBox:VBox;
      
      private var _downLoadClientBtn:SimpleBitmapButton;
      
      private var _complainBtn:MovieImage;
      
      private var _eyeBtn:ScaleFrameImage;
      
      private var _hideFlag:Boolean = false;
      
      private var _clickDate:Number = 0;
      
      public function DailyButtunBar()
      {
         super();
         _inited = false;
      }
      
      public static function get Insance() : DailyButtunBar
      {
         if(instance == null)
         {
            instance = new DailyButtunBar();
         }
         return instance;
      }
      
      public function dispose() : void
      {
         removeEvent();
         removeFeedbackBtn();
         removeDownLoadClientBtn();
         _inited = false;
         if(_eyeBtn)
         {
            _eyeBtn.removeEventListener("click",__onEyeClick);
            _eyeBtn.dispose();
            _eyeBtn = null;
         }
         if(_vBox)
         {
            _vBox.dispose();
            _vBox = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function hide() : void
      {
         dispose();
      }
      
      public function initView() : void
      {
         if(_inited)
         {
            return;
         }
         _vBox = ComponentFactory.Instance.creatComponentByStylename("toolbar.rightVBox");
         addChild(_vBox);
         _eyeBtn = ComponentFactory.Instance.creatComponentByStylename("toolbar.eyebtn");
         _eyeBtn.buttonMode = true;
         _eyeBtn.tipData = LanguageMgr.GetTranslation("hall.view.dailyBtn.eyeTipsText2");
         _vBox.addChild(_eyeBtn);
         _eyeBtn.addEventListener("click",__onEyeClick);
         checkFeedbackBtn();
         setEyeBtnFrame(!!_hideFlag?1:2);
         initEvent();
         _inited = true;
      }
      
      protected function __onEyeClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(new Date().time - _clickDate > 1000)
         {
            _clickDate = new Date().time;
            _hideFlag = !_hideFlag;
            SocketManager.Instance.out.sendNewHallPlayerHid(_hideFlag);
         }
      }
      
      public function setEyeBtnFrame(param1:int) : void
      {
         if(_eyeBtn)
         {
            _eyeBtn.setFrame(param1);
            _eyeBtn.tipData = LanguageMgr.GetTranslation("hall.view.dailyBtn.eyeTipsText" + param1);
         }
      }
      
      private function __onActionClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      public function show() : void
      {
         initView();
         PositionUtils.setPos(this,"toolbar.DailyButtunBarPos");
         LayerManager.Instance.addToLayer(this,4,false,0,false);
         StageResizeUtils.Instance.addAutoResize(this);
      }
      
      public function setComplainGlow(param1:Boolean) : void
      {
         if(param1)
         {
            if(_complainBtn)
            {
               _complainBtn.setFrame(2);
            }
         }
         else if(_complainBtn)
         {
            _complainBtn.setFrame(1);
         }
      }
      
      private function __onComplainClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("015");
         _complainBtn.setFrame(1);
         AssetModuleLoader.addModelLoader("ddtfeedback",6);
         AssetModuleLoader.startCodeLoader(__complainShow);
      }
      
      private function __complainShow() : void
      {
         _complainBtn.setFrame(1);
         FeedbackManager.instance.showFeedback();
      }
      
      private function initEvent() : void
      {
         PathManager.getPathInfo().addEventListener("propertychange",__pathInfoChangeHandler);
      }
      
      private function __pathInfoChangeHandler(param1:CEvent) : void
      {
         if(param1.data["FEEDBACK_ENABLE"])
         {
            checkFeedbackBtn();
         }
         else if(param1.data["CLIENT_DOWNLOAD"])
         {
            checkDownLoadClientBtn();
         }
      }
      
      private function checkFeedbackBtn() : void
      {
         if(PathManager.solveFeedbackEnable())
         {
            if(_complainBtn == null)
            {
               _complainBtn = ComponentFactory.Instance.creatComponentByStylename("toolbar.complainbtn");
               _complainBtn.tipData = LanguageMgr.GetTranslation("tank.view.common.BellowStripViewII.customerService");
               _complainBtn.setFrame(1);
               _vBox.addChild(_complainBtn);
               _complainBtn.buttonMode = true;
               _complainBtn.addEventListener("click",__onComplainClick);
               new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.creatFeedbackInfoLoader],function():void
               {
                  if(FeedbackManager.instance.feedbackReplyData)
                  {
                     if(FeedbackManager.instance.feedbackReplyData.length <= 0)
                     {
                        setComplainGlow(false);
                     }
                     else
                     {
                        setComplainGlow(true);
                     }
                  }
               });
            }
         }
         else
         {
            removeFeedbackBtn();
         }
      }
      
      private function removeFeedbackBtn() : void
      {
         if(_complainBtn)
         {
            _complainBtn.removeEventListener("click",__onComplainClick);
            ObjectUtils.disposeObject(_complainBtn);
            _complainBtn = null;
            if(_vBox)
            {
               _vBox.arrange();
            }
         }
      }
      
      private function checkDownLoadClientBtn() : void
      {
         if(DesktopManager.Instance.landersAwardFlag || DesktopManager.Instance.isDesktop)
         {
            removeDownLoadClientBtn();
         }
         else if(_downLoadClientBtn == null)
         {
            if(PathManager.solveClientDownloadPath() != "")
            {
               _downLoadClientBtn = ComponentFactory.Instance.creatComponentByStylename("core.hall.clientDownloadBtn");
               _downLoadClientBtn.tipData = LanguageMgr.GetTranslation("tank.view.common.BellowStripViewII.downLoadClient");
               _downLoadClientBtn.addEventListener("click",__onActionClick);
               _vBox.addChild(_downLoadClientBtn);
            }
            else
            {
               removeDownLoadClientBtn();
            }
         }
      }
      
      private function removeDownLoadClientBtn() : void
      {
         if(_downLoadClientBtn)
         {
            _downLoadClientBtn.removeEventListener("click",__onActionClick);
            ObjectUtils.disposeObject(_downLoadClientBtn);
            _downLoadClientBtn = null;
            if(_vBox)
            {
               _vBox.arrange();
            }
         }
      }
      
      private function removeEvent() : void
      {
         PathManager.getPathInfo().removeEventListener("propertychange",__pathInfoChangeHandler);
      }
      
      public function set hideFlag(param1:Boolean) : void
      {
         _hideFlag = param1;
         setEyeBtnFrame(!!_hideFlag?1:2);
      }
      
      public function get hideFlag() : Boolean
      {
         return _hideFlag;
      }
   }
}
