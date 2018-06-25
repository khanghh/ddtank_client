package store.view.fusion
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.bagStore.BagStore;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import store.data.PreviewInfoII;
   
   public class PreviewFrameII extends Frame
   {
       
      
      private var _list:VBox;
      
      private var _okBtn:TextButton;
      
      public function PreviewFrameII()
      {
         super();
         initII();
         initEvents();
      }
      
      private function initII() : void
      {
         titleText = LanguageMgr.GetTranslation("store.view.fusion.PreviewFrame.preview");
         var bg:Bitmap = ComponentFactory.Instance.creatBitmap("asset.store.PreviewFrameBG");
         addToContent(bg);
         _list = new VBox();
         addToContent(_list);
         _okBtn = ComponentFactory.Instance.creatComponentByStylename("store.PreviewFrameEnter");
         _okBtn.text = LanguageMgr.GetTranslation("ok");
         addToContent(_okBtn);
         escEnable = true;
         enterEnable = true;
      }
      
      private function initEvents() : void
      {
         _okBtn.addEventListener("click",_okClick);
         addEventListener("removedFromStage",removeFromStageHandler);
         addEventListener("response",_response);
      }
      
      private function removeEvents() : void
      {
         _okBtn.removeEventListener("click",_okClick);
         removeEventListener("removedFromStage",removeFromStageHandler);
         removeEventListener("response",_response);
      }
      
      private function _okClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         hide();
      }
      
      private function _response(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         hide();
      }
      
      public function set items($list:Array) : void
      {
         var i:int = 0;
         var item:* = null;
         for(i = 0; i < $list.length; )
         {
            item = new PreviewItem();
            item.info = $list[i] as PreviewInfoII;
            _list.addChild(item);
            i++;
         }
      }
      
      public function clearList() : void
      {
         _list.disposeAllChildren();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,2,true);
      }
      
      public function hide() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      override public function dispose() : void
      {
         removeEvents();
         clearList();
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         if(_okBtn)
         {
            ObjectUtils.disposeObject(_okBtn);
         }
         _okBtn = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function removeFromStageHandler(event:Event) : void
      {
         BagStore.instance.reduceTipPanelNumber();
      }
   }
}
