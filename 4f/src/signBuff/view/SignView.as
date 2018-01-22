package signBuff.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import signBuff.SignBuffManager;
   
   public class SignView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _signTxt:FilterFrameText;
      
      private var _buffTxt:FilterFrameText;
      
      public function SignView(){super();}
      
      private function init() : void{}
      
      public function dispose() : void{}
   }
}
