package gameCommon.view
{
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import ddt.manager.LanguageMgr;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class ExitHintView extends Frame
   {
       
      
      public function ExitHintView(param1:String, param2:String, param3:Boolean = true, param4:Function = null, param5:Function = null, param6:String = null, param7:String = null, param8:Number = 0)
      {
         super();
      }
      
      public static function show(param1:String, param2:String, param3:Boolean = true, param4:Function = null, param5:Function = null, param6:Boolean = true, param7:String = null, param8:String = null, param9:Number = 0, param10:Boolean = true) : Frame
      {
         var _loc12_:TextFormat = new TextFormat("Arial",12,16711680);
         var _loc11_:TextField = new TextField();
         _loc11_.defaultTextFormat = _loc12_;
         _loc11_.text = LanguageMgr.GetTranslation("tank.view.ExitHint.hint.text");
         _loc11_.autoSize = "left";
         _loc11_.x = 48;
         _loc11_.y = 83;
         var _loc13_:Frame = new ExitHintView(param1,param2,param3,param4,param5,param7,param8,param9);
         LayerManager.Instance.addToLayer(_loc13_,3);
         _loc13_.addChild(_loc11_);
         return _loc13_;
      }
   }
}
