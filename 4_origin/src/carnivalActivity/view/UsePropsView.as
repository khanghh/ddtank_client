package carnivalActivity.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   
   public class UsePropsView extends CarnivalActivityView
   {
       
      
      public function UsePropsView(param1:int, param2:int = 0, param3:String = "")
      {
         super(param1,param2,param3);
      }
      
      override protected function initView() : void
      {
         super.initView();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         _bg = ComponentFactory.Instance.creat("activity.useProps.bg");
         addChildAt(_bg,0);
      }
   }
}
