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
      
      public function update(phase:int) : void
      {
         var mc:* = null;
         var box:* = null;
         ObjectUtils.disposeObject(_aniMc);
         _aniMc = ComponentFactory.Instance.creat("DDQiYuan.BoGuAni");
         addChild(_aniMc);
         _aniMc.gotoAndStop(1);
         if(phase > 0)
         {
            mc = _aniMc["boxContainer1"]["boxContainer2"]["boxContainer3"]["boxContainer4"];
            mc.removeChildAt(0);
            box = new Image();
            box.resourceLink = "DDQiYuan.Box" + phase;
            box.width = 80;
            box.height = 82;
            mc.addChild(box);
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
