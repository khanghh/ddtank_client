package cardSystem.view.cardCollect
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   
   public class CardCollectView extends Frame implements Disposeable
   {
       
      
      private var _bigBG:ScaleBitmapImage;
      
      private var _BG:MutipleImage;
      
      private var _collectBag:CollectBagView;
      
      private var _preview:CollectPreview;
      
      private var _bg1:MutipleImage;
      
      public function CardCollectView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         escEnable = true;
         titleText = LanguageMgr.GetTranslation("ddt.cardSystem.cardCollectView.title");
         _bigBG = ComponentFactory.Instance.creatComponentByStylename("cardCollectView.BG");
         _BG = ComponentFactory.Instance.creatComponentByStylename("cardCollectView.BG1");
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("CollectPreview.BG2");
         _preview = ComponentFactory.Instance.creatCustomObject("CollectPreview");
         _collectBag = ComponentFactory.Instance.creatCustomObject("collectBagView");
         addToContent(_bigBG);
         addToContent(_BG);
         addToContent(_bg1);
         addToContent(_collectBag);
         addToContent(_preview);
         __selectedHandler(null);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _collectBag.addEventListener("selected",__selectedHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _collectBag.removeEventListener("selected",__selectedHandler);
      }
      
      protected function __selectedHandler(param1:Event) : void
      {
         _preview.info = _collectBag.currentItemSetsInfo;
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         _BG = null;
         _bg1 = null;
         _bigBG = null;
         _collectBag = null;
         _preview = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
