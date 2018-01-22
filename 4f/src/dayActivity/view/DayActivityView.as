package dayActivity.view
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import dayActivity.ActivityData;
   import dayActivity.view.dayActtivityView.DayActtivityLeftView;
   import dayActivity.view.dayActtivityView.DayActtivityRightView;
   import flash.display.Sprite;
   
   public class DayActivityView extends Sprite implements Disposeable
   {
       
      
      private var _rightView:DayActtivityRightView;
      
      private var _leftView:DayActtivityLeftView;
      
      public function DayActivityView(){super();}
      
      private function initView() : void{}
      
      public function updataBtn(param1:int) : void{}
      
      public function setBar(param1:int) : void{}
      
      public function setLeftView(param1:Vector.<ActivityData>, param2:Vector.<ActivityData>) : void{}
      
      public function dispose() : void{}
   }
}
