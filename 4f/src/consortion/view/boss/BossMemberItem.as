package consortion.view.boss
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.ConsortiaBossDataVo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   import vip.VipController;
   
   public class BossMemberItem extends Sprite implements Disposeable
   {
       
      
      private var _rankTxt:FilterFrameText;
      
      private var _rankIconList:Vector.<Bitmap>;
      
      private var _nameTxt:FilterFrameText;
      
      private var _nameFirstTxt:GradientText;
      
      private var _damageTxt:FilterFrameText;
      
      private var _contributionTxt:FilterFrameText;
      
      private var _honorTxt:FilterFrameText;
      
      public function BossMemberItem(){super();}
      
      public function set info(param1:ConsortiaBossDataVo) : void{}
      
      private function setRankIconVisible(param1:int) : void{}
      
      public function dispose() : void{}
   }
}
