package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class Repute extends Sprite implements Disposeable
   {
      
      public static const LEFT:String = "left";
      
      public static const RIGHT:String = "right";
       
      
      protected var _repute:int;
      
      protected var _level:int;
      
      protected var _reputeTxt:FilterFrameText;
      
      protected var _reputeBg:Bitmap;
      
      protected var _align:String = "right";
      
      protected var dx:int;
      
      public function Repute(param1:int = 0, param2:int = 0){super();}
      
      public function set level(param1:int) : void{}
      
      public function setRepute(param1:int) : void{}
      
      public function set align(param1:String) : void{}
      
      public function dispose() : void{}
   }
}
