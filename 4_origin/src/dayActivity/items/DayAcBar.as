package dayActivity.items
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   
   public class DayAcBar extends MovieClip implements Disposeable
   {
       
      
      private var _expBarTxt:FilterFrameText;
      
      private var _bar:MovieClip;
      
      private var _ground:Bitmap;
      
      private var _crruFrame:int = 1;
      
      private var _newFrame:int = 0;
      
      public function DayAcBar()
      {
         super();
         initView();
      }
      
      public function initView() : void
      {
         _ground = ComponentFactory.Instance.creat("day.activity.barBack");
         addChild(_ground);
         _bar = ComponentFactory.Instance.creat("day.activity.bar");
         _bar.x = 17;
         _bar.y = 9;
         _bar.gotoAndStop(_crruFrame);
         addChild(_bar);
         _expBarTxt = ComponentFactory.Instance.creatComponentByStylename("day.activityView.right.expBarTxt");
         _expBarTxt.text = "0";
         addChild(_expBarTxt);
      }
      
      public function initBar(param1:int) : void
      {
         _newFrame = param1;
         if(param1 == 0)
         {
            _bar.gotoAndStop(1);
            _expBarTxt.text = String(_newFrame);
            return;
         }
         if(_newFrame >= 100)
         {
            _expBarTxt.text = String(_newFrame);
            _bar.gotoAndStop(100);
            return;
         }
         _bar.gotoAndStop(_newFrame);
         _expBarTxt.text = String(_newFrame);
      }
      
      public function dispose() : void
      {
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         if(parent)
         {
            ObjectUtils.disposeObject(this);
         }
      }
   }
}
