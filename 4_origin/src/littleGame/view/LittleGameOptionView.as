package littleGame.view
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class LittleGameOptionView extends Sprite implements Disposeable
   {
       
      
      private var _leftView:OptionLeftView;
      
      private var _rightView:OptionRightView;
      
      public function LittleGameOptionView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _leftView = new OptionLeftView();
         addChild(_leftView);
         _rightView = new OptionRightView();
         addChild(_rightView);
      }
      
      private function addEvent() : void
      {
      }
      
      public function dispose() : void
      {
         if(_leftView)
         {
            ObjectUtils.disposeObject(_leftView);
         }
         _leftView = null;
         if(_rightView)
         {
            ObjectUtils.disposeObject(_rightView);
         }
         _rightView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
