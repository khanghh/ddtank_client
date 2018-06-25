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
      
      public function DayActivityLeftTitleItem(str:String, num:int)
      {
         super();
         initView(str,num);
      }
      
      private function initView(str:String, num:int) : void
      {
         _back = ComponentFactory.Instance.creat(str);
         addChild(_back);
         _txt = ComponentFactory.Instance.creatComponentByStylename("day.activityView.left.txt1");
         _txt.text = LanguageMgr.GetTranslation("ddt.dayActivity.activityNoOver",num);
         addChild(_txt);
      }
      
      public function setTxt(str:String) : void
      {
         _txt.text = str;
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
