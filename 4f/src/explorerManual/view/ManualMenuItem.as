package explorerManual.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   
   public class ManualMenuItem extends SelectedButton
   {
       
      
      private var _chapter:int;
      
      private var _isHaveNewDebris:Boolean = false;
      
      private var _icon:MovieClip;
      
      public function ManualMenuItem(){super();}
      
      public function get isHaveNewDebris() : Boolean{return false;}
      
      public function set isHaveNewDebris(param1:Boolean) : void{}
      
      public function get chapter() : int{return 0;}
      
      public function set chapter(param1:int) : void{}
      
      override protected function addChildren() : void{}
      
      override public function dispose() : void{}
   }
}
