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
         var _loc1_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.store.PreviewFrameBG");
         addToContent(_loc1_);
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
      
      private function _okClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         hide();
      }
      
      private function _response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         hide();
      }
      
      public function set items(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = new PreviewItem();
            _loc2_.info = param1[_loc3_] as PreviewInfoII;
            _list.addChild(_loc2_);
            _loc3_++;
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
      
      private function removeFromStageHandler(param1:Event) : void
      {
         BagStore.instance.reduceTipPanelNumber();
      }
   }
}
