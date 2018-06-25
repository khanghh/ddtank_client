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
         var i:int = 0;
         removeEventListener("response",__responseHandler);
         _cancel.removeEventListener("click",__cancelHandler);
         ConsortionModelManager.Instance.model.removeEventListener("dutyListChange",__dutyListChange);
         for(i = 0; i < 5; )
         {
            if(_items[i])
            {
               _items[i].removeEventListener("click",__itemClickHandler);
            }
            i++;
         }
      }
      
      private function __responseHandler(event:FrameEvent) : void
      {
         if(event.responseCode == 0 || event.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function __cancelHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      private function __dutyListChange(event:ConsortionEvent) : void
      {
         setDataList(ConsortionModelManager.Instance.model.dutyList);
      }
      
      private function setDataList(list:Vector.<ConsortiaDutyInfo>) : void
      {
         var i:int = 0;
         clearList();
         if(list)
         {
            for(i = 0; i < list.length; )
            {
               _items[i] = new JobManageItem();
               _items[i].dutyInfo = list[i];
               _items[i].name = String(i);
               _items[i].addEventListener("click",__itemClickHandler);
               _list.addChild(_items[i]);
               i++;
            }
         }
         _textArea.text = LanguageMgr.GetTranslation("tank.ConsortionJobManageFrame.limitsText.text");
      }
      
      private function clearList() : void
      {
         var i:int = 0;
         _list.disposeAllChildren();
         for(i = 0; i < 5; )
         {
            _items[i] = null;
            i++;
         }
      }
      
      private function __itemClickHandler(event:MouseEvent) : void
      {
         var i:int = 0;
         for(i = 0; i < 5; )
         {
            if(event.currentTarget != _items[i])
            {
               _items[i].selected = false;
               _items[i].editable = false;
            }
            else
            {
               _items[i].selected = true;
               _textArea.text = setText(i + 1);
            }
            i++;
         }
      }
      
      private function setText(type:int) : String
      {
         var str:String = "";
         switch(int(type) - 1)
         {
            case 0:
               str = LanguageMgr.GetTranslation("tank.ConsortionJobManageFrame.limitsText.text1");
               break;
            case 1:
               str = LanguageMgr.GetTranslation("tank.ConsortionJobManageFrame.limitsText.text2");
               break;
            case 2:
               str = LanguageMgr.GetTranslation("tank.ConsortionJobManageFrame.limitsText.text3");
               break;
            case 3:
               str = LanguageMgr.GetTranslation("tank.ConsortionJobManageFrame.limitsText.text4");
               break;
            case 4:
               str = LanguageMgr.GetTranslation("tank.ConsortionJobManageFrame.limitsText.text4");
         }
         return str;
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
