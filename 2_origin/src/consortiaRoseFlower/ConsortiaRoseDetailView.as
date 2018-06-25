package consortiaRoseFlower
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import org.aswing.KeyboardManager;
   
   public class ConsortiaRoseDetailView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _close:SimpleBitmapButton;
      
      private var _detailTxt:FilterFrameText;
      
      public function ConsortiaRoseDetailView(canClose:Boolean, consortiaName:String, nickName:String)
      {
         super();
         _bg = ComponentFactory.Instance.creatBitmap("ast.rose.bg");
         addChild(_bg);
         if(canClose)
         {
            _close = ComponentFactory.Instance.creat("rose.closeBtn");
            addChild(_close);
            _close.addEventListener("click",onCloseClick);
            KeyboardManager.getInstance().addEventListener("keyDown",onKeyDown);
         }
         _detailTxt = ComponentFactory.Instance.creat("rose.detailTxt");
         _detailTxt.text = LanguageMgr.GetTranslation("consortia.roseFlower.Tip",consortiaName,nickName);
         addChild(_detailTxt);
      }
      
      protected function onKeyDown(e:KeyboardEvent) : void
      {
         if(e.keyCode == 27)
         {
            closeRose();
         }
      }
      
      protected function onCloseClick(event:MouseEvent) : void
      {
         closeRose();
      }
      
      private function closeRose() : void
      {
         ObjectUtils.disposeObject(this);
         dispatchEvent(new CEvent("close_rose"));
      }
      
      public function dispose() : void
      {
         if(_close != null)
         {
            _close.removeEventListener("click",onCloseClick);
            ObjectUtils.disposeObject(_close);
            _close = null;
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         KeyboardManager.getInstance().removeEventListener("keyDown",onKeyDown);
         ObjectUtils.disposeObject(_detailTxt);
         _detailTxt = null;
      }
   }
}
