package gameCommon.view.experience
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   import gameCommon.model.Player;
   import vip.VipController;
   
   public class ExpSurvivalItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _rankImage:ScaleFrameImage;
      
      private var _rankText:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _nickName:FilterFrameText;
      
      private var _killNum:FilterFrameText;
      
      private var _flopNum:FilterFrameText;
      
      private var _luckyBitmap:Bitmap;
      
      private var _twoflops:Bitmap;
      
      public function ExpSurvivalItem(){super();}
      
      private function initView() : void{}
      
      public function setItemInfo(param1:int, param2:Player) : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
