package homeTemple.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import homeTemple.HomeTempleController;
   import homeTemple.data.HomeTempleModel;
   
   public class HomeTempleTextValue extends Sprite implements Disposeable
   {
       
      
      private var _propertyVec:Vector.<FilterFrameText>;
      
      private var _propertyOffVec:Vector.<FilterFrameText>;
      
      private var _propertyPosVec:Array;
      
      public function HomeTempleTextValue(){super();}
      
      private function initView() : void{}
      
      public function setPropertyValue(param1:Boolean = false) : void{}
      
      private function setInfo(param1:Array, param2:Array) : void{}
      
      public function dispose() : void{}
   }
}
