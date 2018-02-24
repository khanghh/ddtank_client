package homeTemple.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class HomeTempleBlessItem extends Sprite implements Disposeable
   {
       
      
      private var _id:int;
      
      private var _bless:MovieClip;
      
      private var _blessBtn:BaseButton;
      
      public function HomeTempleBlessItem(param1:int){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
      
      public function get blessBtn() : BaseButton{return null;}
      
      public function get blessMovie() : MovieClip{return null;}
   }
}
