package cardSystem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.geom.Matrix;
   
   public class CardPropress extends Component
   {
       
      
      private var _thuck:Component;
      
      private var _graphics_thuck:BitmapData;
      
      private var _propgressLabel:FilterFrameText;
      
      private var _value:Number = 0;
      
      private var _max:Number = 100;
      
      public function CardPropress(){super();}
      
      private function initView() : void{}
      
      public function setProgress(param1:Number, param2:Number) : void{}
      
      private function drawProgress() : void{}
      
      public function set labelText(param1:String) : void{}
      
      override public function dispose() : void{}
   }
}
