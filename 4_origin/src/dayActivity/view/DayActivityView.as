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
      
      public function DayActivityView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _rightView = new DayActtivityRightView();
         _rightView.x = 360;
         _rightView.y = 87;
         addChild(_rightView);
         _leftView = new DayActtivityLeftView();
         _leftView.x = 23;
         _leftView.y = 87;
         addChild(_leftView);
      }
      
      public function updataBtn(param1:int) : void
      {
         _rightView.updataBtn(param1);
      }
      
      public function setBar(param1:int) : void
      {
         _rightView.setBarValue(param1);
      }
      
      public function setLeftView(param1:Vector.<ActivityData>, param2:Vector.<ActivityData>) : void
      {
         _leftView.initList(param1,param2);
      }
      
      public function dispose() : void
      {
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
