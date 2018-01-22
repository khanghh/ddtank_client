package petIsland.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import petIsland.PetIslandManager;
   import petIsland.event.PetIslandEvent;
   
   public class PetIslandCell extends Sprite
   {
       
      
      private var cell:MovieClip;
      
      private var _type:int;
      
      public var _row:int;
      
      public var _col:int;
      
      private var _isShine:Boolean;
      
      public function PetIslandCell(param1:int, param2:int, param3:int)
      {
         super();
         _type = param1;
         _row = param2;
         _col = param3;
         init();
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function get isShine() : Boolean
      {
         return _isShine;
      }
      
      public function set isShine(param1:Boolean) : void
      {
         _isShine = param1;
         cell["shine"].visible = _isShine;
      }
      
      private function init() : void
      {
         cell = ComponentFactory.Instance.creat("asset.petIsland.cell" + _type);
         cell["shine"].visible = false;
         addChild(cell);
         cell.addEventListener("click",cellClickHandler);
      }
      
      public function destroy() : void
      {
         TweenLite.to(cell["cellMc"],0.4,{
            "alpha":0,
            "onComplete":tweenComplete
         });
         cell["breakMc"].gotoAndPlay(2);
      }
      
      private function tweenComplete() : void
      {
         PetIslandManager.instance.dispatchEvent(new PetIslandEvent("destroy",this));
      }
      
      private function cellClickHandler(param1:MouseEvent) : void
      {
         PetIslandManager.instance.dispatchEvent(new PetIslandEvent("pet_click",this));
      }
      
      public function clearShine() : void
      {
         cell["shine"].visible = false;
      }
   }
}
