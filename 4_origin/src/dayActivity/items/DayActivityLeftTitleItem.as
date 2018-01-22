package dayActivity.items
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class DayActivityLeftTitleItem extends Sprite implements Disposeable
   {
       
      
      private var _back:Bitmap;
      
      private var _txt:FilterFrameText;
      
      public function DayActivityLeftTitleItem(param1:String, param2:int)
      {
         super();
         initView(param1,param2);
      }
      
      private function initView(param1:String, param2:int) : void
      {
         _back = ComponentFactory.Instance.creat(param1);
         addChild(_back);
         _txt = ComponentFactory.Instance.creatComponentByStylename("day.activityView.left.txt1");
         _txt.text = LanguageMgr.GetTranslation("ddt.dayActivity.activityNoOver",param2);
         addChild(_txt);
      }
      
      public function setTxt(param1:String) : void
      {
         _txt.text = param1;
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
