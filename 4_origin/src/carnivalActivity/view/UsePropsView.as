package carnivalActivity.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   
   public class UsePropsView extends CarnivalActivityView
   {
       
      
      public function UsePropsView(type:int, childType:int = 0, $id:String = "")
      {
         super(type,childType,$id);
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
