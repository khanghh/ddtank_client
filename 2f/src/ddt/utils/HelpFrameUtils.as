package ddt.utils
{
   import com.pickgliss.events.ComponentEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class HelpFrameUtils
   {
      
      private static var _instance:HelpFrameUtils;
       
      
      public function HelpFrameUtils(){super();}
      
      public static function get Instance() : HelpFrameUtils{return null;}
      
      public function simpleHelpButton(param1:Sprite, param2:String, param3:Object = null, param4:String = "", param5:Object = null, param6:Number = 0, param7:Number = 0, param8:Boolean = true, param9:Boolean = true, param10:Object = null, param11:int = 3) : *{return null;}
      
      private function __helpButtonClick(param1:MouseEvent) : void{}
      
      private function __helpButtonDispose(param1:ComponentEvent) : void{}
      
      public function simpleHelpFrame(param1:String, param2:Object, param3:Number, param4:Number, param5:Boolean = true, param6:Boolean = true, param7:Object = null, param8:int = 3) : BaseAlerFrame{return null;}
      
      private function __helpFrameRespose(param1:FrameEvent) : void{}
   }
}
