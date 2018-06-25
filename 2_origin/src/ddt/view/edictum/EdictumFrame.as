package ddt.view.edictum
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   
   public class EdictumFrame extends BaseAlerFrame
   {
       
      
      private var _panel:ScrollPanel;
      
      private var _titleTxt:FilterFrameText;
      
      private var _contenTxt:FilterFrameText;
      
      public function EdictumFrame()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         var alerInfo:AlertInfo = new AlertInfo();
         alerInfo.submitLabel = LanguageMgr.GetTranslation("ok");
         alerInfo.showCancel = false;
         info = alerInfo;
         var bg:Scale9CornerImage = ComponentFactory.Instance.creatComponentByStylename("edictum.edictumBGI");
         var title:Bitmap = ComponentFactory.Instance.creatBitmap("asset.coreIcon.EdictumTitle");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("edictum.edictumTitle");
         _contenTxt = ComponentFactory.Instance.creatComponentByStylename("edictum.edictumContent");
         _panel = ComponentFactory.Instance.creatComponentByStylename("edictum.edictumPanel");
         _panel.setView(_contenTxt);
         _panel.invalidateViewport();
         addToContent(bg);
         addToContent(title);
         addToContent(_titleTxt);
         addToContent(_panel);
      }
      
      private function initEvents() : void
      {
         addEventListener("response",__response);
      }
      
      private function removeEvents() : void
      {
         addEventListener("response",__response);
      }
      
      private function __response(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         ObjectUtils.disposeObject(this);
      }
      
      public function set data(value:Object) : void
      {
         _titleTxt.text = value["Title"];
         _contenTxt.htmlText = value["Text"];
         _panel.invalidateViewport();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      override public function dispose() : void
      {
         removeEvents();
         if(_panel)
         {
            ObjectUtils.disposeObject(_panel);
         }
         _panel = null;
         if(_titleTxt)
         {
            ObjectUtils.disposeObject(_titleTxt);
         }
         _titleTxt = null;
         if(_contenTxt)
         {
            ObjectUtils.disposeObject(_contenTxt);
         }
         _contenTxt = null;
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
