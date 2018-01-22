package consortion.view.selfConsortia
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import consortion.ConsortionModelManager;
   import consortion.data.ConsortiaDutyInfo;
   import consortion.event.ConsortionEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   
   public class ConsortionJobManageFrame extends Frame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _textBG:ScaleBitmapImage;
      
      private var _cancel:TextButton;
      
      private var _list:VBox;
      
      private var _items:Vector.<JobManageItem>;
      
      private var _jobManager:FilterFrameText;
      
      private var _limits:FilterFrameText;
      
      private var _textArea:FilterFrameText;
      
      private var _dottedline:MutipleImage;
      
      public function ConsortionJobManageFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         escEnable = true;
         disposeChildren = true;
         titleText = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaRightsFrame.titleText");
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortion.jobManage.bg");
         _dottedline = ComponentFactory.Instance.creatComponentByStylename("consortion.dottedline");
         _textBG = ComponentFactory.Instance.creatComponentByStylename("consortion.ConsortionJobManageFrame.textAreaBG");
         _jobManager = ComponentFactory.Instance.creatComponentByStylename("consortion.jobManageText");
         _jobManager.text = LanguageMgr.GetTranslation("consortion.ConsortionJobManageFrame.jobManageText");
         _limits = ComponentFactory.Instance.creatComponentByStylename("consortion.limitsText");
         _limits.text = LanguageMgr.GetTranslation("consortion.ConsortionJobManageFrame.limitsText");
         _textArea = ComponentFactory.Instance.creatComponentByStylename("ConsortionJobManageFrame.limitsText");
         _list = ComponentFactory.Instance.creatComponentByStylename("consortion.jobManage.list");
         _cancel = ComponentFactory.Instance.creatComponentByStylename("consortion.jobManage.cancel");
         addToContent(_bg);
         addToContent(_dottedline);
         addToContent(_textBG);
         addToContent(_jobManager);
         addToContent(_limits);
         addToContent(_textArea);
         addToContent(_list);
         addToContent(_cancel);
         _cancel.text = LanguageMgr.GetTranslation("close");
         _items = new Vector.<JobManageItem>(5);
         setDataList(ConsortionModelManager.Instance.model.dutyList);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _cancel.addEventListener("click",__cancelHandler);
         ConsortionModelManager.Instance.model.addEventListener("dutyListChange",__dutyListChange);
      }
      
      private function removeEvent() : void
      {
         var _loc1_:int = 0;
         removeEventListener("response",__responseHandler);
         _cancel.removeEventListener("click",__cancelHandler);
         ConsortionModelManager.Instance.model.removeEventListener("dutyListChange",__dutyListChange);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            if(_items[_loc1_])
            {
               _items[_loc1_].removeEventListener("click",__itemClickHandler);
            }
            _loc1_++;
         }
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function __cancelHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      private function __dutyListChange(param1:ConsortionEvent) : void
      {
         setDataList(ConsortionModelManager.Instance.model.dutyList);
      }
      
      private function setDataList(param1:Vector.<ConsortiaDutyInfo>) : void
      {
         var _loc2_:int = 0;
         clearList();
         if(param1)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.length)
            {
               _items[_loc2_] = new JobManageItem();
               _items[_loc2_].dutyInfo = param1[_loc2_];
               _items[_loc2_].name = String(_loc2_);
               _items[_loc2_].addEventListener("click",__itemClickHandler);
               _list.addChild(_items[_loc2_]);
               _loc2_++;
            }
         }
         _textArea.text = LanguageMgr.GetTranslation("tank.ConsortionJobManageFrame.limitsText.text");
      }
      
      private function clearList() : void
      {
         var _loc1_:int = 0;
         _list.disposeAllChildren();
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _items[_loc1_] = null;
            _loc1_++;
         }
      }
      
      private function __itemClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            if(param1.currentTarget != _items[_loc2_])
            {
               _items[_loc2_].selected = false;
               _items[_loc2_].editable = false;
            }
            else
            {
               _items[_loc2_].selected = true;
               _textArea.text = setText(_loc2_ + 1);
            }
            _loc2_++;
         }
      }
      
      private function setText(param1:int) : String
      {
         var _loc2_:String = "";
         switch(int(param1) - 1)
         {
            case 0:
               _loc2_ = LanguageMgr.GetTranslation("tank.ConsortionJobManageFrame.limitsText.text1");
               break;
            case 1:
               _loc2_ = LanguageMgr.GetTranslation("tank.ConsortionJobManageFrame.limitsText.text2");
               break;
            case 2:
               _loc2_ = LanguageMgr.GetTranslation("tank.ConsortionJobManageFrame.limitsText.text3");
               break;
            case 3:
               _loc2_ = LanguageMgr.GetTranslation("tank.ConsortionJobManageFrame.limitsText.text4");
               break;
            case 4:
               _loc2_ = LanguageMgr.GetTranslation("tank.ConsortionJobManageFrame.limitsText.text4");
         }
         return _loc2_;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         clearList();
         super.dispose();
         _bg = null;
         _dottedline = null;
         _textBG = null;
         _jobManager = null;
         _limits = null;
         _textArea = null;
         _cancel = null;
         _list = null;
         _items = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
