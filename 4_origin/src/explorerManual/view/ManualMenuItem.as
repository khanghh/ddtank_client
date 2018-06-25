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
      
      public function ManualMenuItem()
      {
         super();
         _icon = ComponentFactory.Instance.creat("asset.explorerManual.sighIcon");
         _icon.visible = false;
         PositionUtils.setPos(_icon,"explorerManual.sighIconPos");
      }
      
      public function get isHaveNewDebris() : Boolean
      {
         return _isHaveNewDebris;
      }
      
      public function set isHaveNewDebris(value:Boolean) : void
      {
         if(_isHaveNewDebris == value)
         {
            return;
         }
         _isHaveNewDebris = value;
         _icon.visible = isHaveNewDebris;
      }
      
      public function get chapter() : int
      {
         return _chapter;
      }
      
      public function set chapter(value:int) : void
      {
         _chapter = value;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_icon)
         {
            addChild(_icon);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_icon)
         {
            _icon.stopAllMovieClips();
            ObjectUtils.disposeObject(_icon);
            _icon = null;
         }
      }
   }
}
