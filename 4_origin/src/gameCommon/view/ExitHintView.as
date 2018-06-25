package gameCommon.view
{
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import ddt.manager.LanguageMgr;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class ExitHintView extends Frame
   {
       
      
      public function ExitHintView(title:String, msg:String, model:Boolean = true, callback:Function = null, cancelback:Function = null, confirmLabel:String = null, cancelLabels:String = null, frameWidth:Number = 0)
      {
         super();
      }
      
      public static function show(title:String, msg:String, model:Boolean = true, callback:Function = null, cancelback:Function = null, autoClear:Boolean = true, confirmLabel:String = null, cancelLabel:String = null, frameWidth:Number = 0, isSetFocus:Boolean = true) : Frame
      {
         var format:TextFormat = new TextFormat("Arial",12,16711680);
         var hint:TextField = new TextField();
         hint.defaultTextFormat = format;
         hint.text = LanguageMgr.GetTranslation("tank.view.ExitHint.hint.text");
         hint.autoSize = "left";
         hint.x = 48;
         hint.y = 83;
         var dialog:Frame = new ExitHintView(title,msg,model,callback,cancelback,confirmLabel,cancelLabel,frameWidth);
         LayerManager.Instance.addToLayer(dialog,3);
         dialog.addChild(hint);
         return dialog;
      }
   }
}
