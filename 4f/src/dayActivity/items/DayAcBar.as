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
      
      public function DayAcBar(){super();}
      
      public function initView() : void{}
      
      public function initBar(param1:int) : void{}
      
      public function dispose() : void{}
   }
}
