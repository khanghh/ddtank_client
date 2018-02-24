package newOpenGuide
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class NewOpenGuideRightView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _titleTxt:FilterFrameText;
      
      private var _promptTxt:FilterFrameText;
      
      private var _iconMc:MovieClip;
      
      private var _isDispose:Boolean = false;
      
      public function NewOpenGuideRightView(){super();}
      
      public function refreshView() : void{}
      
      public function dispose() : void{}
   }
}
