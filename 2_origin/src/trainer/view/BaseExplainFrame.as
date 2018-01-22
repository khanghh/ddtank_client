package trainer.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import org.aswing.KeyboardManager;
   
   public class BaseExplainFrame extends Sprite implements Disposeable
   {
      
      public static const EXPLAIN_ENTER:String = "explainEnter";
       
      
      private var _bg:Bitmap;
      
      private var _bg1:MutipleImage;
      
      private var _bg2:MutipleImage;
      
      private var _bg3:ScaleBitmapImage;
      
      private var _bmpTitle:Bitmap;
      
      private var _btnEnter:BaseButton;
      
      public function BaseExplainFrame()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.core.bigbg");
         addChild(_bg);
         _bg1 = ComponentFactory.Instance.creat("trainer.explain.bg1");
         addChild(_bg1);
         _bg2 = ComponentFactory.Instance.creat("trainer.explain.bg2");
         addChild(_bg2);
         _bmpTitle = ComponentFactory.Instance.creatBitmap("asset.explain.title");
         addChild(_bmpTitle);
         _btnEnter = ComponentFactory.Instance.creat("trainer.explain.btnEnter");
         _btnEnter.addEventListener("click",__clickHandler);
         addChild(_btnEnter);
         KeyboardManager.getInstance().addEventListener("keyDown",__keyDown,false,1000);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         _btnEnter.removeEventListener("click",__clickHandler);
         dispatchEvent(new Event("explainEnter"));
         SoundManager.instance.play("008");
      }
      
      private function __keyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            KeyboardManager.getInstance().removeEventListener("keyDown",__keyDown,false);
            __clickHandler(null);
         }
      }
      
      public function dispose() : void
      {
         KeyboardManager.getInstance().removeEventListener("keyDown",__keyDown,false);
         _btnEnter.removeEventListener("click",__clickHandler);
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _bg1 = null;
         _bg2 = null;
         _bg3 = null;
         _bmpTitle = null;
         _btnEnter = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
