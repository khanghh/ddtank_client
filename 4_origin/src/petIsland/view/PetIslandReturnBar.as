package petIsland.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import petIsland.PetIslandManager;
   import petIsland.event.PetIslandEvent;
   
   public class PetIslandReturnBar extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _stretchBtn:SelectedButton;
      
      private var _returnBtn:BaseButton;
      
      private var _pos:Point;
      
      public function PetIslandReturnBar()
      {
         super();
         initialize();
         addEvent();
      }
      
      private function initialize() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.petIsland.returnBarBG");
         _stretchBtn = ComponentFactory.Instance.creatComponentByStylename("asset.petIsland.returnBar.stretchBtn");
         _returnBtn = ComponentFactory.Instance.creatComponentByStylename("asset.petIsland.returnBar.returnBtn");
         _pos = ComponentFactory.Instance.creatCustomObject("asset.petIsland.returnBar.position");
         addChild(_bg);
         addChild(_stretchBtn);
         addChild(_returnBtn);
      }
      
      private function addEvent() : void
      {
         _stretchBtn.addEventListener("click",__onStretchBtnClick);
         _returnBtn.addEventListener("click",__onReturnClick);
      }
      
      private function __onStretchBtnClick(event:MouseEvent) : void
      {
         TweenLite.to(this,0.5,{"x":(!!_stretchBtn.selected?_pos.y:Number(_pos.x))});
      }
      
      private function __onReturnClick(event:MouseEvent) : void
      {
         PetIslandManager.instance.dispatchEvent(new PetIslandEvent("return_petIsLand"));
      }
      
      private function removeEvent() : void
      {
         _stretchBtn.removeEventListener("click",__onStretchBtnClick);
         _returnBtn.removeEventListener("click",__onReturnClick);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_stretchBtn);
         _stretchBtn = null;
         ObjectUtils.disposeObject(_returnBtn);
         _returnBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
