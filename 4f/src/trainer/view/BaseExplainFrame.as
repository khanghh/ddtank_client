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
      
      public function BaseExplainFrame(){super();}
      
      private function initView() : void{}
      
      private function __clickHandler(param1:MouseEvent) : void{}
      
      private function __keyDown(param1:KeyboardEvent) : void{}
      
      public function dispose() : void{}
   }
}
