package hall
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.LoaderSavingManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StatisticManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class SaveFileWidow extends Frame
   {
       
      
      private var _okBtn:TextButton;
      
      private var _novice:Bitmap;
      
      private var _npc:Image;
      
      public function SaveFileWidow()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("tips");
         _novice = ComponentFactory.Instance.creatBitmap("asset.hallSaveFile.noviceBG");
         _npc = ComponentFactory.Instance.creatComponentByStylename("hall.womenNPC");
         _okBtn = ComponentFactory.Instance.creatComponentByStylename("saveFile.okBtn");
         _okBtn.text = LanguageMgr.GetTranslation("consortion.takeIn.agreeBtn.text");
         addToContent(_novice);
         addToContent(_npc);
         addToContent(_okBtn);
      }
      
      private function initEvents() : void
      {
         addEventListener("response",_response);
         _okBtn.addEventListener("click",_okClick);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",_response);
         _okBtn.removeEventListener("click",_okClick);
      }
      
      private function _response(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            dispose();
            sendStatInfo("no");
         }
      }
      
      private function _okClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
         LoaderSavingManager.cacheAble = true;
         LoaderSavingManager.saveFilesToLocal();
         sendStatInfo("yes");
      }
      
      private function sendStatInfo(status:String) : void
      {
         if(PathManager.solveParterId() == null)
         {
            return;
         }
         StatisticManager.Instance().startAction("saveFile",status);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,2,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvents();
         super.dispose();
         if(_novice)
         {
            ObjectUtils.disposeObject(_novice);
         }
         _novice = null;
         if(_npc)
         {
            ObjectUtils.disposeObject(_npc);
         }
         _npc = null;
         if(_okBtn)
         {
            ObjectUtils.disposeObject(_okBtn);
         }
         _okBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
