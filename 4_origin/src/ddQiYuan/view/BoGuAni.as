package ddQiYuan.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class BoGuAni extends Sprite implements Disposeable
   {
       
      
      private var _aniMc:MovieClip;
      
      public function BoGuAni()
      {
         super();
      }
      
      public function update(param1:int) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         ObjectUtils.disposeObject(_aniMc);
         _aniMc = ComponentFactory.Instance.creat("DDQiYuan.BoGuAni");
         addChild(_aniMc);
         _aniMc.gotoAndStop(1);
         if(param1 > 0)
         {
            _loc2_ = _aniMc["boxContainer1"]["boxContainer2"]["boxContainer3"]["boxContainer4"];
            _loc2_.removeChildAt(0);
            _loc3_ = new Image();
            _loc3_.resourceLink = "DDQiYuan.Box" + param1;
            _loc3_.width = 80;
            _loc3_.height = 82;
            _loc2_.addChild(_loc3_);
         }
         else if(_aniMc["boxContainer1"]["boxContainer2"])
         {
            _aniMc["boxContainer1"].removeChild(_aniMc["boxContainer1"]["boxContainer2"]);
         }
         _aniMc.play();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_aniMc);
         _aniMc = null;
      }
   }
}
