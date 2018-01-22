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
      
      public function SignView()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.hall.signBuff.bg1");
         addChild(_bg);
         _signTxt = ComponentFactory.Instance.creatComponentByStylename("hall.signView.signTxt");
         addChild(_signTxt);
         _signTxt.text = String(SignBuffManager.instance.loginDays);
         _buffTxt = ComponentFactory.Instance.creatComponentByStylename("hall.signView.signTxt");
         addChild(_buffTxt);
         _buffTxt.text = String(SignBuffManager.instance.wellAddRate) + "%";
         PositionUtils.setPos(_buffTxt,"ddt.hall.signView.buffPos");
      }
      
      public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_signTxt)
         {
            ObjectUtils.disposeObject(_signTxt);
            _signTxt = null;
         }
         if(_buffTxt)
         {
            ObjectUtils.disposeObject(_buffTxt);
            _buffTxt = null;
         }
      }
   }
}
