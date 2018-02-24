package store
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   
   public class HelpPrompt extends Component
   {
       
      
      private var _bg9Scale:Scale9CornerImage;
      
      public var bg9ScalseStyle:String;
      
      public var contentStyle:String;
      
      private var contentArr:Array;
      
      public function HelpPrompt(){super();}
      
      override protected function onProppertiesUpdate() : void{}
      
      override public function dispose() : void{}
   }
}
