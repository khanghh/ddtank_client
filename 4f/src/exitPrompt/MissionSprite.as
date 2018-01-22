package exitPrompt
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.TiledImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class MissionSprite extends Sprite implements Disposeable
   {
       
      
      public var oldHeight:int;
      
      private const BG_X:int = 4;
      
      public const BG_Y:int = -25;
      
      private const BG_WIDTH:int = 290;
      
      private var _arr:Array;
      
      public function MissionSprite(param1:Array){super();}
      
      private function _init(param1:Array) : void{}
      
      public function get content() : Array{return null;}
      
      public function dispose() : void{}
   }
}
