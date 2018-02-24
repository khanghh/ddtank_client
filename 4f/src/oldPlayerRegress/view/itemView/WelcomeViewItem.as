package oldPlayerRegress.view.itemView
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class WelcomeViewItem extends Sprite implements Disposeable
   {
       
      
      private var _title:FilterFrameText;
      
      private var _descript:FilterFrameText;
      
      private var _desOffsetHeight:int;
      
      private var _desOffsetWidth:int;
      
      public function WelcomeViewItem(){super();}
      
      private function init() : void{}
      
      public function setData(param1:String, param2:String) : void{}
      
      public function setDesOffset(param1:int = 0, param2:int = 0) : void{}
      
      public function dispose() : void{}
   }
}
