package quest
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class BubbleItem extends Sprite implements Disposeable
   {
       
      
      private var _typeText:FilterFrameText;
      
      private var _infoText:FilterFrameText;
      
      private var _stateText:FilterFrameText;
      
      public function BubbleItem(){super();}
      
      private function _init() : void{}
      
      public function setTextInfo(param1:String, param2:String, param3:String) : void{}
      
      public function dispose() : void{}
   }
}
